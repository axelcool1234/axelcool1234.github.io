import { prepare, layout } from '@chenglou/pretext';
import { createBundledHighlighter } from '@shikijs/core';
import { createJavaScriptRegexEngine } from '@shikijs/engine-javascript';
import lean from '@shikijs/langs/lean';
import llvm from '@shikijs/langs/llvm';
import githubDark from '@shikijs/themes/github-dark';

const button = document.getElementById('toggle-note');
const shell = document.getElementById('note-shell');
const content = document.getElementById('note-content');
const lineCountEl = document.getElementById('line-count');
const boxHeightEl = document.getElementById('box-height');
const popup = document.getElementById('aside-popup');
const popupTitle = document.getElementById('aside-popup-title');
const popupBody = document.getElementById('aside-popup-body');

const makeHighlighter = createBundledHighlighter({
  langs: {
    lean: async () => lean,
    llvm: async () => llvm
  },
  themes: {
    'github-dark': async () => githubDark
  },
  engine: createJavaScriptRegexEngine
});

const highlighterPromise = makeHighlighter({
  langs: ['lean', 'llvm'],
  themes: ['github-dark']
});

const codeAsides = {
  'dataflow-context': [
    {
      target: 'analyses',
      asideTitle: 'analyses',
      aside: 'The analyses registered for this solver run, keyed by analysis id.',
      exactWord: true
    },
    {
      target: 'lattice',
      asideTitle: 'lattice',
      aside: 'The shared store of analysis lattice states. Each entry is keyed by a lattice anchor, and multiple analyses can store their own facts at that same anchor.',
      exactWord: true
    },
    {
      target: 'LatticeAnchor',
      asideTitle: 'LatticeAnchor',
      aside: 'The key that says what a fact is attached to, such as a program point, SSA value, or CFG edge.',
      exactWord: true
    },
    {
      target: 'workList',
      asideTitle: 'workList',
      aside: 'The queue of work items waiting to be processed by the fixpoint loop.',
      exactWord: true
    },
    {
      target: 'WorkList',
      asideTitle: 'WorkList',
      aside: 'Queue (ProgramPoint × Lean.Name)',
      asideFormat: 'code',
      exactWord: true
    }
  ],
  'dataflow-analysis': [
    {
      target: 'id',
      asideTitle: 'id',
      aside: 'The analysis identity (for RTTI), used to register and retrieve the analysis within the shared context.',
      exactWord: true
    },
    {
      target: 'init',
      asideTitle: 'init',
      aside: 'Seeds the solver with the initial facts and subscriptions needed before the fixpoint loop starts.',
      exactWord: true
    },
    {
      target: 'visit',
      asideTitle: 'visit',
      aside: 'The transfer function invoked for a worklist item at a program point.',
      exactWord: true
    }
  ],
  'lattice-element': [
    {
      target: 'typeNameInst',
      asideTitle: 'typeNameInst',
      aside: 'The identifier (for RTTI) for this domain.',
      exactWord: true
    }
  ],
  'sparse-analysis-new': [
    {
      target: 'Domain',
      asideTitle: 'Domain',
      aside: 'The lattice domain propagated by the sparse analysis.',
      exactWord: true
    },
    {
      target: 'analysisName',
      asideTitle: 'analysisName',
      aside: 'The analysis id (for RTTI) used when registering and scheduling this sparse analysis.',
      exactWord: true
    },
    {
      target: 'visitOperationImpl',
      asideTitle: 'visitOperationImpl',
      aside: 'The operation transfer function provided by this specific sparse analysis.',
      exactWord: true
    },
    {
      target: 'VisitOperationFn',
      asideTitle: 'VisitOperationFn',
      aside: 'The type of the user-supplied operation transfer function. The first Array ValuePtr is the operation\'s operand values, and the second Array ValuePtr is the operation\'s result values.',
      asideCode: 'OperationPtr -> Array ValuePtr -> Array ValuePtr ->\n  DataFlowContext -> IRContext OpCode -> DataFlowContext',
      exactWord: true
    },
    {
      target: 'setToEntryState',
      asideTitle: 'setToEntryState',
      aside: 'The conservative fallback used when control flow reaches a value but no precise incoming fact can be computed.',
      exactWord: true
    },
    {
      target: 'SetToEntryStateFn',
      asideTitle: 'SetToEntryStateFn',
      aside: 'The type of the user-supplied entry state function.',
      asideCode: 'ValuePtr -> DataFlowContext -> IRContext OpCode -> DataFlowContext',
      exactWord: true
    },
    {
      target: 'DataFlowAnalysis.new',
      asideTitle: 'DataFlowAnalysis.new',
      aside: 'Sparse analysis ultimately constructs an ordinary DataFlowAnalysis by supplying specialized init and visit functions.'
    },
    {
      target: 'init',
      asideTitle: 'sparse init',
      aside: 'The framework synthesizes this for the sparse analysis author. It seeds entry block arguments with setToEntryState, then recursively visits all SSA-value owners to establish the initial sparse state and subscriptions.',
      exactWord: true
    },
    {
      target: 'visit',
      asideTitle: 'sparse visit',
      aside: 'The framework synthesizes this for the sparse analysis author. For each work item, it decides whether to propagate block-argument facts at a block start or to visit the preceding operation. When it visits an operation, it collects the operand and result ValuePtrs and supplies them to visitOperationImpl, so the analysis author does not need to gather them manually.',
      exactWord: true
    }
  ],
  'fixpoint-solve': [
    {
      target: 'DataFlowContext.empty',
      asideTitle: 'DataFlowContext.empty',
      aside: 'Creates a fresh shared context for the solve.'
    },
    {
      target: 'analyses',
      asideTitle: 'analyses',
      aside: 'The array of analyses that will be registered and solved together.',
      exactWord: true
    },
    {
      target: 'insertAnalysis',
      asideTitle: 'insertAnalysis',
      aside: 'Registers each analysis in the shared context before initialization begins.',
      exactWord: true
    },
    {
      target: 'analysis.init',
      asideTitle: 'analysis.init',
      aside: 'Runs each analysis initializer to seed the worklist and any initial facts.'
    },
    {
      target: 'run',
      asideTitle: 'run',
      aside: 'Drains the worklist until no more visits are scheduled, yielding the joint fixpoint.',
      exactWord: true
    }
  ]
};

function wrapFirstTextMatch(root, annotation) {
  const walker = document.createTreeWalker(root, NodeFilter.SHOW_TEXT);

  while (walker.nextNode()) {
    const textNode = walker.currentNode;
    const text = textNode.textContent ?? '';

    let index = text.indexOf(annotation.target);
    if (index === -1) continue;

    if (annotation.exactWord) {
      while (index !== -1) {
        const beforeChar = index === 0 ? '' : text[index - 1];
        const afterIndex = index + annotation.target.length;
        const afterChar = afterIndex >= text.length ? '' : text[afterIndex];
        const boundaryBefore = beforeChar === '' || !/[A-Za-z0-9_]/.test(beforeChar);
        const boundaryAfter = afterChar === '' || !/[A-Za-z0-9_]/.test(afterChar);
        if (boundaryBefore && boundaryAfter) break;
        index = text.indexOf(annotation.target, index + annotation.target.length);
      }
      if (index === -1) continue;
    }

    const before = text.slice(0, index);
    const match = text.slice(index, index + annotation.target.length);
    const after = text.slice(index + annotation.target.length);
    const fragment = document.createDocumentFragment();

    if (before) fragment.append(document.createTextNode(before));

    const trigger = document.createElement('button');
    trigger.type = 'button';
    trigger.className = 'inline-note-trigger code-inline-trigger';
    trigger.textContent = match;
    trigger.dataset.asideTitle = annotation.asideTitle;
    trigger.dataset.aside = annotation.aside;
    if (annotation.asideFormat) {
      trigger.dataset.asideFormat = annotation.asideFormat;
    }
    if (annotation.asideCode) {
      trigger.dataset.asideCode = annotation.asideCode;
    }
    trigger.setAttribute('aria-haspopup', 'dialog');
    trigger.setAttribute('aria-expanded', 'false');
    fragment.append(trigger);

    if (after) fragment.append(document.createTextNode(after));

    textNode.parentNode.replaceChild(fragment, textNode);
    return;
  }
}

function annotateCodeBlock(preEl, annotationId) {
  if (!annotationId) return;

  const annotations = codeAsides[annotationId];
  if (!annotations) return;

  const codeRoot = preEl.querySelector('code');
  if (!codeRoot) return;

  for (const annotation of annotations) {
    wrapFirstTextMatch(codeRoot, annotation);
  }
}

async function highlightCodeBlocks() {
  const blocks = document.querySelectorAll('pre.code-block > code');
  const highlighter = await highlighterPromise;

  for (const codeEl of blocks) {
    if (codeEl.dataset.noHighlight === 'true') {
      continue;
    }

    const source = codeEl.textContent ?? '';
    const lang = codeEl.dataset.shikiLang || 'lean';
    const annotationId = codeEl.dataset.codeAsides;
    const html = highlighter.codeToHtml(source, {
      lang,
      theme: 'github-dark'
    });

    const template = document.createElement('template');
    template.innerHTML = html.trim();
    const shikiPre = template.content.firstElementChild;
    if (!shikiPre) continue;

    shikiPre.classList.add('code-block', 'shiki-block');
    annotateCodeBlock(shikiPre, annotationId);
    codeEl.parentElement.replaceWith(shikiPre);
  }
}

const segments = [
  { text: 'setToEntryState exists because ' },
  {
    text: 'bottom',
    asideTitle: 'bottom',
    aside:
      'Bottom means no useful fact has been established yet. It means "uninitialized" or "unreachable."'
  },
  { text: ' and ' },
  {
    text: 'unknown',
    asideTitle: 'unknown / top',
    aside:
      'Unknown is the pessimistic reachable state. The analysis cannot prove a precise constant.'
  },
  { text: ' are not the same thing. When control flow reaches a value but the framework cannot derive a precise incoming fact, the analysis should not leave the value at ' },
  {
    text: 'bottom',
    asideTitle: 'why not stay at bottom?',
    aside:
      'Leaving a reachable value at bottom would leave "not reached yet" and "reached, but imprecise" as indistinguishable. The entry-state hook separates those cases cleanly.'
  },
  { text: '. Instead, it moves the value to the analysis-specific ' },
  {
    text: 'pessimistic entry state',
    asideTitle: 'pessimistic entry state',
    aside:
      'This is the conservative fallback chosen by the analysis. For sparse constant propagation, it is unknown/top. A different sparse analysis could choose a different entry fact.'
  },
  { text: '. In short: the value is ' },
  {
    text: 'reachable',
    asideTitle: 'reachable',
    aside:
      'Reachable means the relevant control-flow path has become executable, so the value now participates in the analysis and can affect later operations.'
  },
  { text: ', but ' },
  {
    text: 'not precisely knowable here',
    asideTitle: 'not precisely knowable here',
    aside:
      'This usually happens at control-flow boundaries, region boundaries, or any point where the framework lacks a precise transfer rule for the incoming value.'
  },
  { text: '.' }
];

const text = segments.map((segment) => segment.text).join('');

function renderNoteContent() {
  content.textContent = '';

  for (const segment of segments) {
    if (!segment.aside) {
      content.append(document.createTextNode(segment.text));
      continue;
    }

    const trigger = document.createElement('button');
    trigger.type = 'button';
    trigger.className = 'inline-note-trigger';
    trigger.textContent = segment.text;
    trigger.dataset.asideTitle = segment.asideTitle;
    trigger.dataset.aside = segment.aside;
    trigger.dataset.asideFormat = 'text';
    trigger.setAttribute('aria-haspopup', 'dialog');
    trigger.setAttribute('aria-expanded', 'false');
    content.append(trigger);
  }
}

renderNoteContent();
highlightCodeBlocks();

const styles = getComputedStyle(content);
const font = `${styles.fontSize} ${styles.fontFamily}`;
const lineHeight = parseFloat(styles.lineHeight);
const prepared = prepare(text, font);

function relayout() {
  const width = content.clientWidth;
  if (!width) return;

  const { height, lineCount } = layout(prepared, width, lineHeight);
  const chromeExtra = shell.firstElementChild.offsetHeight - content.offsetHeight;
  const total = Math.ceil(height + chromeExtra);

  shell.style.setProperty('--target-height', `${total}px`);
  lineCountEl.textContent = `${lineCount} line${lineCount === 1 ? '' : 's'}`;
  boxHeightEl.textContent = `${Math.ceil(height)} px text area`;
}

let activeTrigger = null;

function closePopup() {
  if (activeTrigger) {
    activeTrigger.setAttribute('aria-expanded', 'false');
  }

  activeTrigger = null;
  popup.hidden = true;
}

function positionPopup() {
  if (!activeTrigger || popup.hidden) return;

  const triggerRect = activeTrigger.getBoundingClientRect();
  const popupRect = popup.getBoundingClientRect();
  const gutter = 16;

  let left = triggerRect.left;
  const maxLeft = window.innerWidth - popupRect.width - gutter;
  left = Math.min(Math.max(gutter, left), Math.max(gutter, maxLeft));

  let top = triggerRect.bottom + 14;
  if (top + popupRect.height > window.innerHeight - gutter) {
    top = Math.max(gutter, triggerRect.top - popupRect.height - 14);
  }

  popup.style.left = `${Math.round(left)}px`;
  popup.style.top = `${Math.round(top)}px`;
}

function openPopup(trigger) {
  if (activeTrigger && activeTrigger !== trigger) {
    activeTrigger.setAttribute('aria-expanded', 'false');
  }

  activeTrigger = trigger;
  activeTrigger.setAttribute('aria-expanded', 'true');
  popupTitle.textContent = trigger.dataset.asideTitle;
  popupBody.replaceChildren();

  if (trigger.dataset.asideFormat === 'code') {
    const pre = document.createElement('pre');
    pre.className = 'aside-code';
    const code = document.createElement('code');
    code.textContent = trigger.dataset.aside;
    pre.append(code);
    popupBody.append(pre);
  } else {
    const paragraph = document.createElement('p');
    paragraph.textContent = trigger.dataset.aside;
    popupBody.append(paragraph);

    if (trigger.dataset.asideCode) {
      const pre = document.createElement('pre');
      pre.className = 'aside-code';
      const code = document.createElement('code');
      code.textContent = trigger.dataset.asideCode;
      pre.append(code);
      popupBody.append(pre);
    }
  }

  popup.hidden = false;
  positionPopup();
}

let open = false;

button.addEventListener('click', () => {
  open = !open;
  shell.classList.toggle('collapsed', !open);
  button.textContent = open ? 'Close note' : 'Open note';

  if (!open) {
    closePopup();
  }

  relayout();
});

document.addEventListener('click', (event) => {
  const trigger = event.target.closest('.inline-note-trigger');
  if (trigger) {
    if (activeTrigger === trigger && !popup.hidden) {
      closePopup();
    } else {
      openPopup(trigger);
    }
    return;
  }

  if (popup.hidden) return;
  if (popup.contains(event.target)) return;
  closePopup();
});

document.addEventListener('keydown', (event) => {
  if (event.key === 'Escape') {
    closePopup();
  }
});

const resizeObserver = new ResizeObserver(() => {
  relayout();
  positionPopup();
});

resizeObserver.observe(content);

window.addEventListener('resize', () => {
  relayout();
  positionPopup();
});

relayout();
