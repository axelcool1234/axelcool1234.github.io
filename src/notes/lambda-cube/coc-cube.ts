import {
  AXIS_TEXT_ABOVE,
  AXIS_TEXT_BELOW_RIGHT,
  AXIS_TEXT_RIGHT,
  LABEL_BOTTOM_RIGHT,
  LABEL_TOP_LEFT_TIGHT,
  LABEL_TOP_RIGHT,
  mountCube,
  themeColor,
  type Axis,
  type CubeNodeSpec,
} from "./cube-engine.js";

// Static node definitions for Barendregt's lambda cube.
const nodeSpecs: CubeNodeSpec[] = [
  {
    coords: [0, 0, 0],
    color: themeColor("--on_surface"),
    name: "Simply Typed Lambda Calculus",
    shortName: "λ→",
    note: `
      <p>
        In this system, the only way to construct an abstraction is by making a term
        depend on a term, with the
        <a href="https://en.wikipedia.org/wiki/Typing_rule">typing rule</a>:
      </p>
      <math display="block">
        <mfrac>
          <mrow>
            <mi>&Gamma;</mi>
            <mo>,</mo>
            <mi>x</mi>
            <mo>:</mo>
            <mi>&sigma;</mi>
            <mo>&vdash;</mo>
            <mi>t</mi>
            <mo>:</mo>
            <mi>&tau;</mi>
          </mrow>
          <mrow>
            <mi>&Gamma;</mi>
            <mo>&vdash;</mo>
            <mi>&lambda;</mi>
            <mi>x</mi>
            <mo>.</mo>
            <mi>t</mi>
            <mo>:</mo>
            <mi>&sigma;</mi>
            <mo>&rarr;</mo>
            <mi>&tau;</mi>
          </mrow>
        </mfrac>
      </math>
      <p>Via the Curry-Howard isomorphism, this corner corresponds to (Zeroth-order) <a href="https://en.wikipedia.org/wiki/Propositional_logic">propositional logic</a>.</p>
    `,
    labelOffset: LABEL_BOTTOM_RIGHT
  },
  {
    coords: [1, 0, 0],
    color: themeColor("--terminal_normal_red"),
    name: "Lambda-P",
    shortName: "λP",
    note: `
      <p>This system is also named λΠ and is closely related to the <a href="https://en.wikipedia.org/wiki/Logical_framework#LF">LF logical framework</a>.</p>
      <p>Its crucial introduction rule is:</p>
      <math display="block">
        <mfrac>
          <mrow>
            <mi>&Gamma;</mi>
            <mo>,</mo>
            <mi>x</mi>
            <mo>:</mo>
            <mi>A</mi>
            <mo>&vdash;</mo>
            <mi>B</mi>
            <mo>:</mo>
            <mo>*</mo>
          </mrow>
          <mrow>
            <mi>&Gamma;</mi>
            <mo>&vdash;</mo>
            <mo>(</mo>
            <mi>&Pi;</mi>
            <mi>x</mi>
            <mo>:</mo>
            <mi>A</mi>
            <mo>.</mo>
            <mi>B</mi>
            <mo>)</mo>
            <mo>:</mo>
            <mo>*</mo>
          </mrow>
        </mfrac>
      </math>
      <p>Here <math><mo>*</mo></math> represents valid types.</p>
      <p>Note that <math><mi>&Pi;</mi></math> corresponds via the Curry-Howard isomorphism to a universal quantifier, so λP corresponds to (First order) <a href="https://en.wikipedia.org/wiki/First-order_logic">predicate logic</a> with implication as its only connective.</p>
    `,
    labelOffset: LABEL_BOTTOM_RIGHT
  },
  {
    coords: [0, 1, 0],
    color: themeColor("--terminal_normal_blue"),
    name: "System F",
    shortName: "λ2",
    note: `
      <p>Named λ2 for the "second-order typed lambda calculus", introduces another abstraction written with a <math><mi>&Lambda;</mi></math>.</p>
      <p>The characteristic rule is:</p>
      <math display="block">
        <mfrac>
          <mrow>
            <mi>&Gamma;</mi>
            <mo>&vdash;</mo>
            <mi>t</mi>
            <mo>:</mo>
            <mi>&sigma;</mi>
          </mrow>
          <mrow>
            <mi>&Gamma;</mi>
            <mo>&vdash;</mo>
            <mi>&Lambda;</mi>
            <mi>&alpha;</mi>
            <mo>.</mo>
            <mi>t</mi>
            <mo>:</mo>
            <mi>&Pi;</mi>
            <mi>&alpha;</mi>
            <mo>.</mo>
            <mi>&sigma;</mi>
          </mrow>
        </mfrac>
      </math>
      <p>provided that <math><mi>&alpha;</mi></math> does not occur free in <math><mi>&Gamma;</mi></math>.</p>
      <p>Terms beginning with <math><mi>&Lambda;</mi></math> are polymorphic: they can be applied to different types to obtain different functions. Via the Curry-Howard isomorphism, System F corresponds to <a href="https://en.wikipedia.org/wiki/Second-order_propositional_logic">second-order propositional logic</a>.</p>
    `,
    labelOffset: LABEL_TOP_RIGHT
  },
  {
    coords: [1, 1, 0],
    color: themeColor("--terminal_normal_magenta"),
    name: "λP2",
    shortName: "λP2",
    note: `
      <p>Via the Curry-Howard isomorphism, it corresponds to <a href="https://en.wikipedia.org/wiki/Second-order_logic">second-order predicate calculus</a>.</p>
    `,
    labelOffset: LABEL_TOP_RIGHT
  },
  {
    coords: [0, 0, 1],
    color: themeColor("--terminal_normal_green"),
    name: "System Fω̲",
    shortName: "λω̲",
    note: `
      <p>This system introduces type constructors: type-level functions that take a type as input and return a new type.</p>
      <p>It is useful mainly for isolating the independent feature of type operators, and is generally not used on its own.</p>
      <p>Via the Curry-Howard isomorphism, it corresponds to weakly higher-order propositional calculus.</p>
    `,
    labelOffset: LABEL_TOP_LEFT_TIGHT
  },
  {
    coords: [1, 0, 1],
    color: themeColor("--terminal_normal_yellow"),
    name: "λPω",
    shortName: "λPω",
    note: `
      <p>Via the Curry-Howard isomorphism, λPω corresponds to weak <a href="https://en.wikipedia.org/wiki/Higher-order_logic">higher-order predicate calculus</a>.</p>
    `,
    labelOffset: LABEL_BOTTOM_RIGHT
  },
  {
    coords: [0, 1, 1],
    color: themeColor("--terminal_normal_cyan"),
    name: "System Fω",
    shortName: "λω",
    note: `
      <p>System Fω combines the <math><mi>&Lambda;</mi></math>-abstraction of System F with the type constructors of System Fω̲.</p>
      <p>Via the Curry-Howard isomorphism, System Fω corresponds to higher-order propositional calculus.</p>
    `,
    labelOffset: LABEL_TOP_LEFT_TIGHT
  },
  {
    coords: [1, 1, 1],
    color: themeColor("--on_surface_variant"),
    name: "Calculus of Constructions",
    shortName: "λC",
    note: `
      <p>Here all four features coexist, so both types and terms can depend on both types and terms.</p>
      <p>The clear border between terms and types present in λ→ is weakened, since every type except the universal <math><mo>&#9633;</mo></math> is itself a term with a type.</p>
      <p>Via the Curry-Howard isomorphism, this corner is the <a href="https://en.wikipedia.org/wiki/Calculus_of_constructions">calculus of constructions</a>.</p>
    `,
    labelOffset: LABEL_BOTTOM_RIGHT
  }
];

// Static definitions for the three dependency axes of the lambda cube.
const axes: [Axis, Axis, Axis] = [
  {
    color: themeColor("--terminal_normal_red"),
    label: "Dependent Types",
    description:
      "This axis adds the ability for types to depend on terms. Moving in this direction introduces dependent types.",
    values: ["No dependent types", "Dependent types"],
    valueDescriptions: [
      "Types do not depend on terms.",
      "Types may depend on terms."
    ],
    textOffset: AXIS_TEXT_RIGHT
  },
  {
    color: themeColor("--terminal_normal_blue"),
    label: "Polymorphism",
    description:
      "This axis adds the ability for terms to depend on types. Moving in this direction introduces polymorphism.",
    values: ["No polymorphism", "Polymorphism"],
    valueDescriptions: [
      "Terms do not depend on types.",
      "Terms may depend on types."
    ],
    textOffset: AXIS_TEXT_ABOVE
  },
  {
    color: themeColor("--terminal_normal_green"),
    label: "Type Operators",
    description:
      "This axis adds the ability for types to depend on types. Moving in this direction introduces type operators.",
    values: ["No type operators", "Type operators"],
    valueDescriptions: [
      "Types do not depend on types.",
      "Types may depend on types."
    ],
    textOffset: AXIS_TEXT_BELOW_RIGHT
  }
];

mountCube({
  svgSelector: "#coc-cube",
  infoSelector: "#coc-cube-info",
  nodeSpecs,
  axes,
});
