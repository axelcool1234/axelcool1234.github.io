#import "@preview/cetz:0.4.2"

#set page(width: auto, height: auto, margin: 1cm)

#cetz.canvas({
  import cetz.draw: *

  let s = 4 // Scale

  // Define the 8 vertices (Selection, λ-Restriction, β-Restriction)
  // X: 0=Innermost,    1=Outermost
  // Y: 0=Strong,       1=Weak
  // Z: 0=Unrestricted, 1=Restricted

  let p000 = (0, 0, 0) // Innermost, λ-Strong, β-Unrestricted (Applicative Order)
  let p100 = (s, 0, 0) // Outermost, λ-Strong, β-Unrestricted (Normal Order)
  let p010 = (0, s, 0) // Innermost, λ-Weak, β-Unrestricted (Weak Applicative)
  let p110 = (s, s, 0) // Outermost, λ-Weak, β-Unrestricted (Call-by-Name)

  let p001 = (0, 0, s) // Innermost, λ-Strong, β-Restricted (Rare)
  let p101 = (s, 0, s) // Outermost, λ-Strong, β-Restricted
  let p011 = (0, s, s) // Innermost, λ-Weak, β-Restricted (Call-by-Value - Machine)
  let p111 = (s, s, s) // Outermost, λ-Weak, β-Restricted (Call-by-Value - Redex)


  // Draw Axes for clarity
  line((0, 0, 0), (s + 1, 0, 0), mark: (end: ">"), name: "axis-x")
  line((0, 0, 0), (0, s + 1, 0), mark: (end: ">"), name: "axis-y")
  line((0, 0, 0), (0, 0, s + 1), mark: (end: ">"), name: "axis-z")

  content((s + 1.2, 0, 0), [Selection \ (Outermost)], anchor: "west")
  content((0, s + 1.2, 0), [λ-Restriction \ (Restricted)], anchor: "south")
  content((0, 0, s + 1.2), [β-Restriction \ (Restricted)], anchor: "north")

  // Draw Main Cube Edges
  line(p000, p100)
  line(p000, p010)
  line(p100, p110)
  line(p010, p110)
  line(p000, p001)
  line(p001, p101)
  line(p001, p011)
  line(p100, p101)
  line(p101, p111)
  line(p010, p011)
  line(p110, p111)
  line(p011, p111)

  // Lazy
  circle(p100, radius: 0.1, fill: red)
  content(p100, [ *λNO* ], anchor: "south-west", padding: .2) // Normal Order

  circle(p110, radius: 0.1, fill: red)
  content(p110, [ *λCBN* / *λWNO* ], anchor: "south-west", padding: .2) // Call-by-Name

  // Eager
  circle(p011, radius: 0.1, fill: green)
  content(p011, [ *λCBVₘ* ], anchor: "north-east", padding: .2) // Call-by-Value (Machine)

  circle(p111, radius: 0.1, fill: green)
  content(p111, [ *λCBVᵣ* ], anchor: "north-west", padding: .2) // Call-by-Value (Redex)


  // Applicative
  circle(p000, radius: 0.1, fill: blue)
  content(p000, [ *λAO* ], anchor: "south-east", padding: .2) // Applicative Order

  circle(p010, radius: 0.1, fill: blue)
  content(p010, [ *λWAO* ], anchor: "south-east", padding: .2) // Weak Applicative Order
})