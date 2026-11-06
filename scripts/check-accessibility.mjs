import AxeBuilder from '@axe-core/playwright';
import { chromium } from 'playwright-core';
import { createServer } from 'node:http';
import { readFile, readdir, stat, writeFile } from 'node:fs/promises';
import { resolve, relative, extname, sep } from 'node:path';

// Scan the actual Nix output, including generated pages and JavaScript widgets.
// Run: nix build .#site; nix develop -c npm ci; nix develop -c npm run check:a11y
// A11Y_ALL_THEMES=1 also checks every page in every palette (a much longer audit).
const root = resolve(process.argv[2] ?? 'result');
const reportPath = process.env.A11Y_REPORT ?? 'accessibility-report.json';
const tags = ['wcag2a', 'wcag2aa', 'wcag21a', 'wcag21aa', 'wcag22aa', 'best-practice'];
const mime = { '.html': 'text/html', '.js': 'text/javascript', '.css': 'text/css', '.json': 'application/json', '.svg': 'image/svg+xml', '.mp4': 'video/mp4', '.pdf': 'application/pdf' };
const server = createServer(async (req, res) => {
  try {
    let file = resolve(root, '.' + decodeURIComponent(new URL(req.url, 'http://localhost').pathname));
    if (file !== root && !file.startsWith(root + sep)) throw new Error('Outside site');
    if ((await stat(file)).isDirectory()) file = resolve(file, 'index.html');
    res.setHeader('Content-Type', mime[extname(file)] ?? 'application/octet-stream');
    res.end(await readFile(file));
  } catch {
    res.writeHead(404).end('Not found');
  }
});

async function htmlFiles(dir) {
  const files = [];
  for (const entry of await readdir(dir, { withFileTypes: true })) {
    const file = resolve(dir, entry.name);
    // The site is a symlinkJoin; Dirent.isDirectory() alone misses its links.
    if ((await stat(file)).isDirectory()) files.push(...await htmlFiles(file));
    else if (entry.name.endsWith('.html')) files.push('/' + relative(root, file).split(sep).join('/'));
  }
  return files.sort();
}

await new Promise(resolve => server.listen(0, '127.0.0.1', resolve));
const origin = `http://127.0.0.1:${server.address().port}`;
const report = { tags, scans: [], errors: [] };
let browser;
try {
  browser = await chromium.launch({ executablePath: process.env.CHROMIUM_EXECUTABLE_PATH ?? 'chromium', headless: true });
  const context = await browser.newContext({ reducedMotion: 'reduce' });
  const page = await context.newPage();
  page.on('pageerror', error => report.errors.push(error.stack ?? error.message));

  async function chooseChart(id, value) {
    const picker = page.locator(`#${id} .chart-selection`);
    if (!await picker.evaluate(element => element.open)) await picker.locator('summary').click();
    await picker.locator('select').selectOption(value);
    await picker.locator('select').press('Escape');
  }

  async function scan(path, state) {
    const { violations, incomplete } = await new AxeBuilder({ page }).withTags(tags).analyze();
    report.scans.push({ path, state, violations, incomplete });
    await writeFile(reportPath, JSON.stringify(report, null, 2) + '\n');
    console.log(`${violations.length ? 'FAIL' : 'PASS'} ${path} (${state}): ${violations.map(v => `${v.id} [${v.nodes.length}]`).join(', ') || 'no violations'}`);
  }

  for (const path of await htmlFiles(root)) {
    for (const mode of ['dark', 'light']) {
      await page.emulateMedia({ colorScheme: mode });
      await page.goto(origin + path, { waitUntil: 'networkidle' });
      await page.evaluate(() => document.fonts.ready);
      await scan(path, `default theme, system ${mode}`);
      if (await page.locator('#theme-picker').count()) {
        await page.locator('#theme-summary').click();
        await scan(path, `theme picker open, ${mode}`);
        await page.locator('#theme-summary').click();
        await page.locator('#mode-summary').click();
        await scan(path, `mode picker open, ${mode}`);
        await page.locator('#mode-summary').click();
      }
    }
  }

  // Exercise keyboard paths that a rule engine cannot discover by itself.
  await page.goto(origin + '/index.html', { waitUntil: 'networkidle' });
  await page.keyboard.press('Tab');
  if (!await page.locator('.skip-link').evaluate(element => element === document.activeElement)) {
    throw new Error('The first Tab must reach the skip-to-content link');
  }
  await page.keyboard.press('Enter');
  if (!await page.locator('main').evaluate(element => element === document.activeElement)) {
    throw new Error('The skip link must focus main content');
  }
  await page.locator('#theme-summary').click();
  await page.locator('#theme-search').focus();
  await page.keyboard.press('Escape');
  if (await page.locator('#theme-picker').evaluate(element => element.open) ||
      !await page.locator('#theme-summary').evaluate(element => element === document.activeElement)) {
    throw new Error('Escape must close the theme picker and restore trigger focus');
  }

  await page.goto(origin + '/notes/lambda-cube/index.html', { waitUntil: 'networkidle' });
  for (const section of await page.locator('.cube').all()) {
    const select = section.locator('select');
    await select.focus();
    await page.keyboard.press('End');
    if (!(await section.locator('.cube-info h3').textContent()).includes('Axis')) {
      throw new Error('The keyboard must reach cube axis descriptions');
    }
    await page.keyboard.press('Home');
    const pause = section.getByRole('button', { name: 'Pause cube animation' });
    if (await pause.getAttribute('aria-pressed') !== 'true') throw new Error('Cubes must respect reduced motion');
  }
  await scan('/notes/lambda-cube/index.html', 'keyboard exploration, reduced motion');

  for (const mode of ['dark', 'light']) {
    await page.emulateMedia({ colorScheme: mode });
    await page.goto(origin + '/posts/coexec-scheduler/index.html', { waitUntil: 'networkidle' });
    for (const id of ['te', 'bw', 'dr', 'lr']) {
      await page.locator(`#${id} button[data-kernel="f16"]`).click();
    }
    await page.waitForLoadState('networkidle');
    await chooseChart('bw', '0');
    await chooseChart('lr', 'fragment-0');
    await page.locator('#lr button[data-dag="on"]').click();
    await page.waitForLoadState('networkidle');
    await page.locator('#lr .av summary').click();
    await scan('/posts/coexec-scheduler/index.html', `f16 fragments, mutation on, assembly open, ${mode}`);
    await chooseChart('lr', 'wait-0');
    await scan('/posts/coexec-scheduler/index.html', `f16 waits, assembly open, ${mode}`);
    for (const id of ['bw', 'lr']) {
      await page.locator(`#${id} .chart-selection summary`).click();
      await scan('/posts/coexec-scheduler/index.html', `${id} selection menu open, ${mode}`);
      await page.locator(`#${id} select`).press('Escape');
    }
  }

  await page.setViewportSize({ width: 320, height: 900 });
  for (const mode of ['dark', 'light']) {
    await page.emulateMedia({ colorScheme: mode });
    await page.goto(origin + '/index.html', { waitUntil: 'networkidle' });
    await page.locator('#theme-summary').click();
    const menu = await page.locator('.theme-menu').boundingBox();
    if (!menu || menu.x < 0 || menu.x + menu.width > 320) {
      throw new Error('The theme menu must fit the viewport at 320 CSS pixels');
    }
    await scan('/index.html', `320px viewport, theme picker open, ${mode}`);
    await page.goto(origin + '/posts/coexec-scheduler/index.html', { waitUntil: 'networkidle' });
    for (const id of ['bw', 'lr']) {
      await page.locator(`#${id} .chart-selection summary`).click();
      const box = await page.locator(`#${id} select`).boundingBox();
      if (!box || box.x < 0 || box.x + box.width > 320) {
        throw new Error(`${id} selection menu must fit the 320px viewport`);
      }
      await scan('/posts/coexec-scheduler/index.html', `320px viewport, ${id} selection menu open, ${mode}`);
      await page.locator(`#${id} select`).press('Escape');
    }
  }
  await page.goto(origin + '/presentations/coexec-scheduler/index.html', { waitUntil: 'networkidle' });
  const deck = page.frames().find(frame => new URL(frame.url()).pathname.endsWith('/deck.html'));
  if (!deck) throw new Error('The slide deck must load');
  await deck.waitForFunction(() => {
    const video = document.querySelector('.slide-background.present video');
    return video && video.readyState >= 2 && video.videoWidth > 0 && video.getBoundingClientRect().height > 0;
  });
  if (await deck.locator('a[href="/posts/coexec-scheduler/"]').count()) {
    throw new Error('The embedded deck must display its slides without an article shortcut');
  }
  await deck.getByRole('button', { name: 'next slide', exact: true }).press('ArrowRight');
  if (await deck.evaluate(() => Reveal.getIndices().h) === 0) {
    throw new Error('The keyboard must advance the slide deck');
  }
  // Full-page capture also exercises iframe resizing and offscreen layout.
  await page.screenshot({ fullPage: true });
  await scan('/presentations/coexec-scheduler/index.html', '320px viewport, next slide, resized iframe');
  await page.setViewportSize({ width: 1280, height: 720 });

  // Every offered palette must work with the shared navigation and body text.
  // A full content scan of every palette can be requested for a deeper audit.
  const themePages = process.env.A11Y_ALL_THEMES === '1' ? await htmlFiles(root) : ['/index.html'];
  const themes = (await readdir(resolve(root, 'themes'))).filter(file => file.endsWith('.css')).sort();
  for (const path of themePages) {
    await page.goto(origin + path, { waitUntil: 'networkidle' });
    if (!await page.locator('#theme-picker').count()) continue;
    for (const theme of themes) {
      for (const mode of ['dark', 'light']) {
        await page.evaluate(async ({ theme, mode }) => {
          document.documentElement.dataset.themeMode = mode;
          const link = document.querySelector('#theme-stylesheet');
          const href = '/themes/' + theme;
          if (link.getAttribute('href') !== href) {
            await new Promise((resolve, reject) => {
              link.onload = resolve;
              link.onerror = reject;
              link.href = href;
            });
          }
          document.querySelector('#theme-picker').open = true;
          document.querySelector('#mode-picker').open = true;
        }, { theme, mode });
        await scan(path, `${theme}, ${mode}, pickers open`);
      }
    }
  }
} catch (error) {
  report.errors.push(error.stack ?? String(error));
} finally {
  await browser?.close();
  await new Promise(resolve => server.close(resolve));
  await writeFile(reportPath, JSON.stringify(report, null, 2) + '\n');
}
const failures = report.scans.filter(scan => scan.violations.length).length;
console.log(`${report.scans.length} scans; ${failures} failed; ${report.errors.length} runtime errors. Details: ${reportPath}`);
for (const error of report.errors) console.error(error);
process.exitCode = failures || report.errors.length ? 1 : 0;
