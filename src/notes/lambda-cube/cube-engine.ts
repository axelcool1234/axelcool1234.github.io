// A binary coordinate used for each cube dimension.
export type Bit = 0 | 1;

// A cube coordinate as [first dimension, second dimension, third dimension].
export type Coords = [Bit, Bit, Bit];

// Two strings ordered by bit value 0 then 1.
export type DimensionText = readonly [string, string];

// A 2D point or vector in SVG coordinates.
export type Vector = {
  // Horizontal component in SVG units.
  x: number;
  // Vertical component in SVG units.
  y: number;
};

// A text offset relative to a node or axis endpoint.
export type LabelOffset = Vector;

// A text offset plus SVG text anchoring information.
export type AxisTextOffset = LabelOffset & {
  // Horizontal text anchoring mode used by the SVG text element.
  anchor: "start" | "middle" | "end";
};

// Shared node-label placement at the lower-right of a node.
export const LABEL_BOTTOM_RIGHT: LabelOffset = { x: 12, y: 20 };

// Shared node-label placement at the upper-right of a node.
export const LABEL_TOP_RIGHT: LabelOffset = { x: 12, y: -10 };

// Shared node-label placement at the upper-left of a node.
export const LABEL_TOP_LEFT: LabelOffset = { x: -42, y: -10 };

// Tighter upper-left node-label placement for shorter labels.
export const LABEL_TOP_LEFT_TIGHT: LabelOffset = { x: -32, y: -10 };

// Shared node-label placement at the lower-left of a node.
export const LABEL_BOTTOM_LEFT: LabelOffset = { x: -64, y: 20 };

// Shared axis-label placement to the right of an arrow tip.
export const AXIS_TEXT_RIGHT: AxisTextOffset = { x: 10, y: 4, anchor: "start" };

// Shared axis-label placement centered above an arrow tip.
export const AXIS_TEXT_ABOVE: AxisTextOffset = { x: 0, y: -14, anchor: "middle" };

// Shared axis-label placement directly below an arrow tip.
export const AXIS_TEXT_BELOW: AxisTextOffset = { x: 0, y: 18, anchor: "start" };

// Shared axis-label placement below and to the right of an arrow tip.
export const AXIS_TEXT_BELOW_RIGHT: AxisTextOffset = { x: 10, y: 18, anchor: "start" };

// Static data used to define a cube node before animation state is added.
export type CubeNodeSpec = {
  // Cube coordinates for this node.
  coords: Coords;
  // Display color for the node and its label.
  color: string;
  // Optional full title shown in the info panel.
  name?: string;
  // Optional short label rendered next to the node.
  shortName?: string;
  // Optional extra HTML note shown below the generated description.
  note?: string;
  // Optional label placement relative to the node position.
  labelOffset?: LabelOffset;
};

// Metadata for one named cube axis and its rendered arrow label.
export type Axis = {
  // Display color for the axis arrow and text.
  color: string;
  // Label rendered next to the axis arrow and used in the info heading.
  label: string;
  // Description shown when the axis is selected.
  description: string;
  // Value labels for this axis, ordered by bit value 0 then 1.
  values: DimensionText;
  // Description sentences for this axis, ordered by bit value 0 then 1.
  valueDescriptions: DimensionText;
  // Placement and anchoring for the axis label text.
  textOffset: AxisTextOffset;
};

// Static geometry for the cube layout and axis arrow placement.
export type CubeGeometry = {
  // Origin corner of the cube in SVG coordinates.
  origin: Vector;
  // Per dimension step vectors ordered to match the three coordinate components.
  axisVectors: readonly [Vector, Vector, Vector];
  // How far axis arrows extend past the cube.
  axisExtend: number;
};

// Animation tuning constants for the shared bob and spring motion.
export type CubeMotion = {
  // Amplitude of the shared cube motion along the x axis.
  xAmplitude: number;
  // Speed of the shared cube motion along the x axis.
  xSpeed: number;
  // Amplitude of the shared cube motion along the y axis.
  yAmplitude: number;
  // Speed of the shared cube motion along the y axis.
  ySpeed: number;
  // Amplitude of each node's small independent wobble.
  jitterAmplitude: number;
  // Speed of each node's small independent wobble.
  jitterSpeed: number;
  // Phase offset between node jitters so they do not move identically.
  jitterPhaseStep: number;
  // Strength of the spring pulling a node back toward its target position.
  spring: number;
  // Velocity damping applied each frame so motion settles down.
  damping: number;
};

// Visual and interaction tuning constants for rendering the cube.
export type CubeStyle = {
  // Radius of each visible node circle.
  nodeRadius: number;
  // Hit radius for grabbing the nearest node from empty SVG space.
  nodeHitRadius: number;
  // Font size used for node and axis labels.
  labelFontSize: number;
  // Normal font weight for unselected labels.
  fontWeightNormal: string;
  // Bold font weight for selected labels.
  fontWeightSelected: string;
  // Default stroke width for edges and arrows.
  strokeWidth: number;
  // Stroke width for the selected axis or selected axis edges.
  selectedStrokeWidth: number;
  // Width of the invisible hit area used for selecting axis lines.
  lineHitStrokeWidth: number;
  // Length of each arrow head segment.
  arrowLength: number;
  // Angle spread of the arrow head from the main line.
  arrowSpread: number;
  // Dash pattern used for axis arrow lines.
  axisDashPattern: string;
  // Default color for non-axis edges.
  neutralEdgeColor: string;
  // Outline color for node circles.
  nodeOutlineColor: string;
  // Default heading used for unnamed cube corners.
  unnamedNodeLabel: string;
};

// Complete data and optional tuning needed to mount one interactive cube.
export type CubeConfig = {
  // CSS selector for the SVG element to render into.
  svgSelector: string;
  // CSS selector for the info panel element.
  infoSelector: string;
  // Static node definitions for the eight cube corners before derived state is added.
  nodeSpecs: CubeNodeSpec[];
  // Static definitions for the three cube axes and their rendered labels.
  axes: readonly [Axis, Axis, Axis];
  // Optional overrides for the default cube geometry.
  geometry?: Partial<CubeGeometry>;
  // Optional overrides for the default animation constants.
  motion?: Partial<CubeMotion>;
  // Optional overrides for the default visual and interaction constants.
  style?: Partial<CubeStyle>;
};

// A fully realized cube node with derived labels, geometry, and live animation state.
type CubeNode = CubeNodeSpec & {
  // Resting x position before animation offsets are applied.
  homeX: number;
  // Resting y position before animation offsets are applied.
  homeY: number;
  // Derived value labels for the three coordinate dimensions.
  axisValues: readonly [string, string, string];
  // Current animated x position.
  x: number;
  // Current animated y position.
  y: number;
  // Current x velocity used by the spring simulation.
  vx: number;
  // Current y velocity used by the spring simulation.
  vy: number;
  // Per-node phase offset for the independent jitter motion.
  jitterPhase: number;
};

// A line segment between two cube nodes, optionally associated with an axis.
type Edge = {
  // Index of the starting node in the nodes array.
  fromIndex: number;
  // Index of the ending node in the nodes array.
  toIndex: number;
  // Stroke color used when drawing the edge.
  color: string;
  // Axis index for selectable axis edges, or null for neutral edges.
  axisIndex: number | null;
};

// Current selection, which is always either a node or an axis.
type CubeSelection =
  | {
      // Node selection state.
      kind: "node";
      // Selected node index.
      index: number;
    }
  | {
      // Axis selection state.
      kind: "axis";
      // Selected axis index.
      index: number;
    };

// SVG namespace used when creating SVG elements from JavaScript.
const SVG_NS = "http://www.w3.org/2000/svg";

// Builtin geometry defaults used when a cube config does not override them.
const DEFAULT_GEOMETRY: CubeGeometry = {
  origin: { x: 190, y: 250 },
  axisVectors: [
    { x: 150, y: 0 },
    { x: 0, y: -150 },
    { x: -92, y: 56 }
  ],
  axisExtend: 45
};

// Builtin motion defaults used when a cube config does not override them.
const DEFAULT_MOTION: CubeMotion = {
  xAmplitude: 2,
  xSpeed: 0.0015,
  yAmplitude: 4,
  ySpeed: 0.002,
  jitterAmplitude: 0.8,
  jitterSpeed: 0.0025,
  jitterPhaseStep: 0.8,
  spring: 0.01,
  damping: 0.9
};

// Builtin visual and interaction defaults used when a cube config does not override them.
const DEFAULT_STYLE: CubeStyle = {
  nodeRadius: 10,
  nodeHitRadius: 16,
  labelFontSize: 14,
  fontWeightNormal: "400",
  fontWeightSelected: "700",
  strokeWidth: 2,
  selectedStrokeWidth: 3,
  lineHitStrokeWidth: 18,
  arrowLength: 12,
  arrowSpread: Math.PI / 7,
  axisDashPattern: "4 4",
  neutralEdgeColor: "--outline",
  nodeOutlineColor: "--outline",
  unnamedNodeLabel: "Unnamed Corner"
};

// Mark a color as coming from the shared theme schema.
export function themeColor(name: string): string {
  return name;
}

// Read a CSS custom property from the document root and fail if it is missing.
export function cssColor(name: string): string {
  const value = getComputedStyle(document.documentElement).getPropertyValue(name).trim();

  if (value === "") {
    throw new Error(`Missing CSS color variable: ${name}`);
  }

  return value;
}

// Mount one interactive cube using the provided data and selectors.
export function mountCube(config: CubeConfig): void {
  const geometry = { ...DEFAULT_GEOMETRY, ...config.geometry };
  const motion = { ...DEFAULT_MOTION, ...config.motion };

  // Grab the target SVG and info panel. Browser runtime error if either selector is missing.
  const svg = document.querySelector<SVGSVGElement>(config.svgSelector);
  const info = document.querySelector<HTMLElement>(config.infoSelector);

  if (!svg || !info) {
    throw new Error("Cube elements not found");
  }

  const style = { ...DEFAULT_STYLE, ...config.style };

  // Resolve theme color tokens like "--primary" into current concrete colors.
  function resolveColor(color: string): string {
    return color.startsWith("--") ? cssColor(color) : color;
  }

  // Realized cube nodes with derived labels, geometry, and live animation state.
  const nodes: CubeNode[] = config.nodeSpecs.map((node, index) => {
    const [firstBit, secondBit, thirdBit] = node.coords;
    const homeX =
      geometry.origin.x
      + firstBit * geometry.axisVectors[0].x
      + secondBit * geometry.axisVectors[1].x
      + thirdBit * geometry.axisVectors[2].x;
    const homeY =
      geometry.origin.y
      + firstBit * geometry.axisVectors[0].y
      + secondBit * geometry.axisVectors[1].y
      + thirdBit * geometry.axisVectors[2].y;

    return {
      ...node,
      homeX,
      homeY,
      axisValues: [
        config.axes[0].values[firstBit],
        config.axes[1].values[secondBit],
        config.axes[2].values[thirdBit]
      ],
      jitterPhase: index * motion.jitterPhaseStep,
      x: homeX,
      y: homeY,
      vx: 0,
      vy: 0
    };
  });

  // Converts a cube coordinate into a string key for coordinate lookups.
  function coordKey(coords: Coords) {
    return coords.join("");
  }

  // Returns a copy of coords with one dimension replaced by a new bit value.
  function setCoord(coords: Coords, dimension: number, value: Bit): Coords {
    return coords.map((coord, index) => (index === dimension ? value : coord)) as Coords;
  }

  // Lookup from a coordinate key like "010" to the corresponding node index.
  const nodeIndexFromCoords = new Map<string, number>(
    nodes.map((node, index) => [coordKey(node.coords), index])
  );
  // Index of the origin node at cube coordinate [0, 0, 0].
  const originIndex = nodeIndexFromCoords.get(coordKey([0, 0, 0]))!;

  // Derived cube edges, with the three origin edges marked as selectable axes.
  const edges: Edge[] = nodes.flatMap((node, fromIndex) =>
    node.coords.flatMap((coord, dimension) => {
      // Only create the edge from the 0 side so each cube edge is generated once.
      if (coord === 1) {
        return [];
      }

      const isOriginEdge = fromIndex === originIndex;

      return [
        {
          fromIndex,
          toIndex: nodeIndexFromCoords.get(coordKey(setCoord(node.coords, dimension, 1)))!,
          color: isOriginEdge ? config.axes[dimension].color : style.neutralEdgeColor,
          axisIndex: isOriginEdge ? dimension : null
        }
      ];
    })
  );

  // Mutable interaction state: the current selection and any node being dragged.
  let selection: CubeSelection = { kind: "node", index: 0 };
  let draggedNodeIndex: number | null = null;

  // Create an SVG element in the SVG namespace with the provided attributes.
  function svgElement<K extends keyof SVGElementTagNameMap>(
    name: K,
    attributes: Record<string, string | number>
  ): SVGElementTagNameMap[K] {
    const element = document.createElementNS(SVG_NS, name) as SVGElementTagNameMap[K];

    for (const [key, value] of Object.entries(attributes)) {
      element.setAttribute(key, String(value));
    }

    return element;
  }

  // Given a node index, return back whether it's currently selected.
  function nodeIsSelected(index: number): boolean {
    return selection.kind === "node" && index === selection.index;
  }

  // Generate the description that's placed in the info panel for the node.
  function nodeDescription(node: CubeNode): string {
    const [firstBit, secondBit, thirdBit] = node.coords;
    return (
      `${config.axes[0].valueDescriptions[firstBit]} `
      + `${config.axes[1].valueDescriptions[secondBit]} `
      + `${config.axes[2].valueDescriptions[thirdBit]}`
    );
  }

  // Given a node, update the info panel with the node's information.
  function updateInfo(node: CubeNode): void {
    const heading = node.name || style.unnamedNodeLabel;
    const note = node.note ?? "";

    info.innerHTML = `
      <h2>${heading}</h2>
      <p>${nodeDescription(node)}</p>
      ${note}
      <dl>
        ${config.axes
          .map(
            (axis, index) =>
              `<dt>${axis.label}</dt><dd>${node.axisValues[index]}</dd>`
          )
          .join("")}
      </dl>
    `;
  }

  // Update state: select node at given index, and update the info panel.
  function selectNode(index: number): void {
    selection = { kind: "node", index };
    updateInfo(nodes[index]);
  }

  // Update state: select axis at given index, and update the info panel.
  function selectAxis(index: number): void {
    selection = { kind: "axis", index };
    info.innerHTML = `
      <h2>${config.axes[index].label} Axis</h2>
      <p>${config.axes[index].description}</p>
    `;
  }

  // Convert browser pointer coordinates into the SVG's local coordinate system.
  function pointerPosition(event: PointerEvent): DOMPoint {
    const point = svg.createSVGPoint();
    point.x = event.clientX;
    point.y = event.clientY;
    return point.matrixTransform(svg.getScreenCTM().inverse());
  }

  // Start dragging a node by selecting it, moving it to the pointer, and capturing the pointer.
  function startDragging(index: number, event: PointerEvent): void {
    const position = pointerPosition(event);
    draggedNodeIndex = index;
    selectNode(index);
    nodes[index].x = position.x;
    nodes[index].y = position.y;
    svg.setPointerCapture(event.pointerId);
  }

  // Stop dragging the active node and release the captured pointer.
  function stopDragging(event: PointerEvent): void {
    if (draggedNodeIndex == null) {
      return;
    }

    draggedNodeIndex = null;
    svg.releasePointerCapture(event.pointerId);
  }

  // Find the nearest node within the configured hit radius, or null if none are close enough.
  function closestNodeIndex(x: number, y: number): number | null {
    let bestIndex = null;
    let bestDistance = style.nodeHitRadius;

    for (const [index, node] of nodes.entries()) {
      const dx = node.x - x;
      const dy = node.y - y;
      const distance = Math.hypot(dx, dy);

      if (distance <= bestDistance) {
        bestDistance = distance;
        bestIndex = index;
      }
    }

    return bestIndex;
  }

  // Append a visible SVG line with the given endpoints and attributes.
  function appendLine(
    x1: number,
    y1: number,
    x2: number,
    y2: number,
    attributes: Record<string, string | number> = {}
  ): void {
    svg.appendChild(
      svgElement("line", {
        x1,
        y1,
        x2,
        y2,
        ...attributes
      })
    );
  }

  // Append an invisible wide SVG line that acts as an easier-to-click hit target.
  function appendHitLine(
    x1: number,
    y1: number,
    x2: number,
    y2: number,
    onClick: () => void
  ): void {
    const hitLine = svgElement("line", {
      x1,
      y1,
      x2,
      y2,
      stroke: "transparent",
      "stroke-width": style.lineHitStrokeWidth
    });

    hitLine.addEventListener("pointerdown", event => {
      event.stopPropagation();
      event.preventDefault();
      onClick();
    });

    svg.appendChild(hitLine);
  }

  // Append an arrow by drawing the main line plus two short angled lines at the tip.
  function drawArrow(
    x1: number,
    y1: number,
    x2: number,
    y2: number,
    attributes: Record<string, string | number> = {}
  ): void {
    const angle = Math.atan2(y2 - y1, x2 - x1);

    appendLine(x1, y1, x2, y2, attributes);
    appendLine(
      x2,
      y2,
      x2 - Math.cos(angle - style.arrowSpread) * style.arrowLength,
      y2 - Math.sin(angle - style.arrowSpread) * style.arrowLength,
      attributes
    );
    appendLine(
      x2,
      y2,
      x2 - Math.cos(angle + style.arrowSpread) * style.arrowLength,
      y2 - Math.sin(angle + style.arrowSpread) * style.arrowLength,
      attributes
    );
  }

  // Draw the three labeled axis arrows by extending each origin edge past the cube.
  function drawAxes(): void {
    for (const [index, axis] of config.axes.entries()) {
      const from = nodes[originIndex];
      const to = nodes[nodeIndexFromCoords.get(coordKey(setCoord(from.coords, index, 1)))!];
      const dx = to.x - from.x;
      const dy = to.y - from.y;
      const length = Math.hypot(dx, dy);
      const unitX = dx / length;
      const unitY = dy / length;
      const x2 = to.x + unitX * geometry.axisExtend;
      const y2 = to.y + unitY * geometry.axisExtend;
      const label = svgElement("text", {
        x: x2 + axis.textOffset.x,
        y: y2 + axis.textOffset.y,
        "font-size": style.labelFontSize,
        "text-anchor": axis.textOffset.anchor,
        fill: resolveColor(axis.color),
        "font-weight":
          selection.kind === "axis" && selection.index === index
            ? style.fontWeightSelected
            : style.fontWeightNormal
      });

      drawArrow(to.x, to.y, x2, y2, {
        stroke: resolveColor(axis.color),
        "stroke-width":
          selection.kind === "axis" && selection.index === index
            ? style.selectedStrokeWidth
            : style.strokeWidth,
        "stroke-dasharray": style.axisDashPattern
      });
      appendHitLine(to.x, to.y, x2, y2, () => selectAxis(index));
      label.textContent = axis.label;
      label.addEventListener("pointerdown", event => {
        event.stopPropagation();
        event.preventDefault();
        selectAxis(index);
      });
      svg.appendChild(label);
    }
  }

  // Draw the cube edges, with invisible hit targets on the selectable axis edges.
  function drawEdges(): void {
    for (const edge of edges) {
      const from = nodes[edge.fromIndex];
      const to = nodes[edge.toIndex];

      appendLine(from.x, from.y, to.x, to.y, {
        stroke: resolveColor(edge.color),
        "stroke-width":
          selection.kind === "axis" && selection.index === edge.axisIndex
            ? style.selectedStrokeWidth
            : style.strokeWidth
      });

      if (edge.axisIndex != null) {
        appendHitLine(from.x, from.y, to.x, to.y, () => selectAxis(edge.axisIndex));
      }
    }
  }

  // Draw the short text labels for named nodes.
  function drawNodeLabels(): void {
    for (const [index, node] of nodes.entries()) {
      if (!node.name || !node.labelOffset || !node.shortName) {
        continue;
      }

      const label = svgElement("text", {
        x: node.x + node.labelOffset.x,
        y: node.y + node.labelOffset.y,
        "font-size": style.labelFontSize,
        fill: resolveColor(node.color),
        "font-weight": nodeIsSelected(index) ? style.fontWeightSelected : style.fontWeightNormal
      });

      label.textContent = node.shortName;
      label.addEventListener("pointerdown", event => {
        event.stopPropagation();
        event.preventDefault();
        selectNode(index);
      });
      svg.appendChild(label);
    }
  }

  // Draw the node circles and attach drag handlers.
  function drawNodes(): void {
    for (const [index, node] of nodes.entries()) {
      const circle = svgElement("circle", {
        cx: node.x,
        cy: node.y,
        r: style.nodeRadius,
        fill: resolveColor(node.color),
        stroke: resolveColor(style.nodeOutlineColor),
        "stroke-width": nodeIsSelected(index) ? style.selectedStrokeWidth : style.strokeWidth
      });

      circle.addEventListener("pointerdown", event => {
        event.stopPropagation();
        event.preventDefault();
        startDragging(index, event);
      });

      svg.appendChild(circle);
    }
  }

  // Redraw the full cube scene for the current animation frame.
  function draw(): void {
    svg.innerHTML = "";
    drawAxes();
    drawEdges();
    drawNodeLabels();
    drawNodes();
  }

  // Update each node's animated position by applying bob, jitter, and spring motion.
  function updateNodePositions(time: number): void {
    const bobX = Math.sin(time * motion.xSpeed) * motion.xAmplitude;
    const bobY = Math.cos(time * motion.ySpeed) * motion.yAmplitude;

    for (const [index, node] of nodes.entries()) {
      if (index === draggedNodeIndex) {
        node.vx = 0;
        node.vy = 0;
        continue;
      }

      const jitterX = Math.sin(time * motion.jitterSpeed + node.jitterPhase) * motion.jitterAmplitude;
      const jitterY = Math.cos(time * motion.jitterSpeed + node.jitterPhase) * motion.jitterAmplitude;
      const targetX = node.homeX + bobX + jitterX;
      const targetY = node.homeY + bobY + jitterY;

      node.vx += (targetX - node.x) * motion.spring;
      node.vy += (targetY - node.y) * motion.spring;
      node.vx *= motion.damping;
      node.vy *= motion.damping;
      node.x += node.vx;
      node.y += node.vy;
    }
  }

  // Main animation loop: advance the animation by updating node positions, redrawing the scene, and scheduling the next frame.
  function animate(time: number): void {
    updateNodePositions(time);
    draw();
    requestAnimationFrame(animate);
  }

  // Drag handlers
  svg.addEventListener("pointerdown", event => {
    const position = pointerPosition(event);
    const index = closestNodeIndex(position.x, position.y);

    if (index == null) {
      return;
    }

    startDragging(index, event);
  });
  svg.addEventListener("pointermove", event => {
    if (draggedNodeIndex == null) {
      return;
    }

    const position = pointerPosition(event);
    const node = nodes[draggedNodeIndex];
    node.x = position.x;
    node.y = position.y;
  });
  svg.addEventListener("pointerup", stopDragging);
  svg.addEventListener("pointercancel", stopDragging);

  // Initialize
  updateInfo(nodes[0]);
  requestAnimationFrame(animate);
}
