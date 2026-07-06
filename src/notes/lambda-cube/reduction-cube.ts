import {
  AXIS_TEXT_ABOVE,
  AXIS_TEXT_BELOW,
  AXIS_TEXT_RIGHT,
  LABEL_BOTTOM_RIGHT,
  LABEL_TOP_LEFT,
  LABEL_TOP_RIGHT,
  mountCube,
  type Axis,
  type CubeGeometry,
  type CubeNodeSpec,
} from "./cube-engine.js";

const BLUE = "#2b6cb0";
const RED = "#c53030";
const GREEN = "#2f855a";
const GRAY = "#888";

// Static node definitions for the eight cube corners before derived state is added.
const nodeSpecs: CubeNodeSpec[] = [
  {
    coords: [0, 0, 0],
    color: BLUE,
    name: "Applicative Order",
    shortName: "λAO",
    labelOffset: LABEL_BOTTOM_RIGHT
  },
  {
    coords: [1, 0, 0],
    color: RED,
    name: "Normal Order",
    shortName: "λNO",
    labelOffset: LABEL_BOTTOM_RIGHT
  },
  {
    coords: [0, 1, 0],
    color: BLUE,
    name: "Weak Applicative Order",
    shortName: "λWAO",
    note:
      "<p>In pure lambda calculus, this is usually identified with call by value. In impure lambda calculus, it differs because weak applicative order can still beta reduce an application whose argument is not yet a value.</p>",
    labelOffset: LABEL_TOP_RIGHT
  },
  {
    coords: [1, 1, 0],
    color: RED,
    name: "Call by Name / Weak Normal Order",
    shortName: "λCBN / λWNO",
    labelOffset: LABEL_TOP_RIGHT
  },
  {
    coords: [0, 0, 1],
    color: GRAY
  },
  {
    coords: [1, 0, 1],
    color: GRAY
  },
  {
    coords: [0, 1, 1],
    color: GREEN,
    name: "Call by Value",
    shortName: "λCBV",
    note:
      "<p>In pure lambda calculus, this also refers to weak applicative order. In impure lambda calculus, value restriction can block beta reduction that weak applicative order would still perform.</p>",
    labelOffset: LABEL_TOP_LEFT
  },
  {
    coords: [1, 1, 1],
    color: GRAY
  }
];

// Static definitions for the three cube axes and their rendered labels.
const axes: [Axis, Axis, Axis] = [
  {
    color: RED,
    label: "Redex Selection",
    description:
      "This axis changes which redex is chosen next for evaluation. Moving in this direction means preferring the leftmost outermost redex instead of the leftmost innermost one. This is positional - it changes which of the available redexes is contracted first, but it doesn't change what is considered a redex. Together with λ-restriction, this is standard in the literature.",
    values: ["Innermost (leftmost innermost)", "Outermost (leftmost outermost)"],
    valueDescriptions: [
      "The next redex chosen for evaluation is the leftmost innermost redex.",
      "The next redex chosen for evaluation is the leftmost outermost redex."
    ],
    textOffset: AXIS_TEXT_RIGHT
  },
  {
    color: BLUE,
    label: "λ-Restriction",
    description:
      "This axis changes whether reduction is allowed under lambda abstractions. Moving in this direction means weak reduction: reduction under lambda abstractions is not allowed. This is positional - it blocks some redexes from being contracted, but it doesn't change what is considered a redex. The literature often refers to this as \"weak\" reduction or \"strong\" reduction.",
    values: ["Unrestricted / Strong", "Abstraction-Restricted / Weak"],
    valueDescriptions: [
      "Reduction under lambda abstractions is allowed.",
      "Reduction under lambda abstractions is not allowed."
    ],
    textOffset: AXIS_TEXT_ABOVE
  },
  {
    color: GREEN,
    label: "β-Restriction",
    description:
      "This axis changes what counts as a beta redex. Moving in this direction means only reducing applications whose argument is already a value. Unlike the other two axes, this is not positional - rather, it changes what is considered a redex. This axis is not usually made explicit in the literature, and in pure lambda calculus it effectively collapses away, which is why call by value and weak applicative order are often treated as the same. In impure lambda calculus, they differ.",
    values: ["Unrestricted", "Value Restricted"],
    valueDescriptions: [
      "Beta reduction does not require the argument to already be a value.",
      "Beta reduction requires the argument to already be a value."
    ],
    textOffset: AXIS_TEXT_BELOW
  }
];

mountCube({
  svgSelector: "#reduction-cube",
  infoSelector: "#reduction-cube-info",
  nodeSpecs,
  axes,
});
