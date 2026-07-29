#import "template.typ": resume, header, resume_heading, edu_item, exp_item, project_item, skill_item

#show: resume

#header(
  name: "Axel Sorenson",
  phone: "951-269-9768",
  email: "AxelPSorenson@gmail.com",
  linkedin: "linkedin.com/in/axel-sorenson/",
  site: "github.com/axelcool1234",
)

#resume_heading[Education]
#edu_item(
  name: "University of Utah",
  degree: "PhD in Computer Science (Compilers and Formal Methods)",
  location: "Salt Lake City, UT",
  date: "August 2025 - Present",
  [*Advisor*: #link("https://users.cs.utah.edu/~regehr/")[Professor John Regehr]],
  [*Lab*: Formal Methods Lab],
  [*Relevant Coursework*: Advanced Compiler Implementation, Software Verification, Programming Language Semantics, Testing and Verification of Digital Circuits, Advanced Operating System Implementation]
)
#edu_item(
  name: "University of California, Irvine",
  degree: "Bachelor of Science in Computer Science",
  location: "Irvine, CA",
  date: "September 2022 - March 2025",
  [*Cumulative GPA*: 4.0],
  [*Awards*: #link("https://uu.uci.edu/programs/deans-honor-list-reception/")[Dean's Honors List] (every quarter), #link("https://phibetakappa.uci.edu/events/pbk-book-awards-ceremony/")[Phi Beta Kappa Annual Book Award]],
  // [*Relevant Coursework*: Compiler Construction, Computer Organization, Operating Systems, Embedded Software, Data Structures and Algorithms, Information Retrieval, System Design, Database Management, Artificial Intelligence, Machine Learning, Data Mining]
)

#resume_heading[Experience]
#exp_item(
  role: "Compiler Engineer Intern",
  name: "AMD (AIG-SHARKS)",
  location: "San Jose, CA",
  date: "May 2026 - August 2026",
  [Diagnosed a defect in AMD's current and next generation pre-register-allocation schedulers for gfx1250 (MI450) GPUs that bunched LDS loads too far ahead of the WMMAs consuming them, leading to significant register spillage and causing the matrix cores to majorly stall on s_wait_dscnt instructions.],
  [Implemented a ScheduleDAGMutation in LLVM's AMDGPU backend adding DAG edges confining each LDS load to a window determined from a statically calculated live VGPR histogram. (#link("https://github.com/llvm/llvm-project/pull/203095")[\#203095]\; an internal version of this PR is under review for merging)],
  [On AMD's cycle accurate simulator, raised matrix core utilization from 2.5% to 40.1% on the worst affected mxfp8 GEMM, cutting its VGPR spills from 805 to 16 and its average stall on s_wait_dscnt instructions from 594 to 44 cycles per loop iteration; additionally lifted an fp16 GEMM from 77.8% to 86.2% matrix core utilization. Peak register usage fell on all kernels tested.],
  [Built a containerized benchmark harness (using Docker, Make, and Python) for kernels in various configurations using AMD's simulator, autogenerating comparison tables used to iterate on the DAG mutation and further understand the defect in the AMD pre-RA schedulers.]
)
#exp_item(
  role: "PhD Research Assistant",
  name: [Formal Methods Lab with #link("https://users.cs.utah.edu/~regehr/")[Professor John Regehr]],
  location: "Salt Lake City, UT",
  date: "August 2025 - Present",
  [Authored the dataflow analysis framework of #link("https://github.com/opencompl/veir")[VeIR], a work in progress verified compiler in Lean 4 mirroring MLIR capabilities and asymptotic complexity with proof assistant level verification, developed with #link("https://grosser.science/")[Tobias Grosser]'s group at the University of Cambridge and my advisor. The framework is a port of MLIR's C++ DataFlowFramework - a worklist fixpoint solver built on top of the monotone framework. Sole author of all three modules VeIR exports as its analysis namespace, across 16 merged pull requests. (#link("https://github.com/opencompl/veir/pull/264")[\#264])],
  [Laid the groundwork for verified transfer functions by defining VeIR's abstract domain interface as a Lean typeclass carrying its own proof obligations: no instance typechecks until it discharges the bounded join semilattice laws and proves its concretization map monotone. Already instantiated for constant propagation and liveness. (#link("https://github.com/opencompl/veir/pull/666")[\#666], #link("https://github.com/opencompl/veir/pull/856")[\#856])],
  [Built VeIR's dominance and dead code analyses as clients of that framework: an iterative Cooper-Harvey-Kennedy immediate dominator solver, exposed through block  and operation level dominance queries over nested regions, and a dataflow based dead code analysis. (#link("https://github.com/opencompl/veir/pull/133")[\#133], #link("https://github.com/opencompl/veir/pull/721")[\#721], #link("https://github.com/opencompl/veir/pull/659")[\#659])],
  [Built the extraction harness producing the evaluation corpus for the lab's StableHLO semantics formalization: 121 torchvision models across 21 image and 42 video shapes through two export paths (JAX, torch-xla). (#link("https://github.com/axelcool1234/StableHLO-Extracter")[repo])],
  [Prototyped #link("https://github.com/axelcool1234/L2")[L2], a loop language with an implemented IC3/property directed reachability invariant prover over Z3, evaluated on 35 matched safe/unsafe benchmarks under lit and FileCheck - an experiment for exploring translation validation of unbounded loops, which Alive2 currently handles by bounded unrolling.]
)
#exp_item(
  role: "LLVM Open Source Contributor",
  name: "llvm-project (Open Source)",
  location: "Remote",
  date: "November 2024 - Present",
  [Implemented an extension point in the PassBuilder pipeline enabling developers to insert and run custom passes immediately after vectorization; used upstream to register AMDGPU's InferAddressSpacesPass. (#link("https://github.com/llvm/llvm-project/pull/123494")[\#123494])],
  [Ported a funnel shift combiner from SelectionDAG to GlobalISel as declarative TableGen, cutting a canonical AArch64 GlobalISel case from 9 instructions to 7. (#link("https://github.com/llvm/llvm-project/pull/135132")[\#135132])],
  [Ported a rotate transformation from SelectionDAG to InstCombine, giving the fold a middle end equivalent so chained rotates collapse earlier in the pipeline; #link("https://github.com/dtcxzyw/llvm-opt-benchmark/pull/2866")[benchmarked] across seven real world codebases including LuaJIT, wasmtime-rs, and ffmpeg, with instruction count reductions and no regressions. (#link("https://github.com/llvm/llvm-project/pull/160628")[\#160628])]
)
#exp_item(
  role: "Undergraduate Research Assistant",
  name: [#link("https://ssllab.org/")[Secure Systems and Software Laboratory] at University of California, Irvine],
  location: "Irvine, CA",
  date: "August 2024 - March 2025",
  [Helped document a binary lifter translating machine code into LLVM IR with #link("https://www.michaelfranz.com/")[Professor Michael Franz], learning pointer provenance, memory models, and aliasing rules to keep the lifter aligned with LLVM internals.],
  // [Studied pointer provenance, memory models, and aliasing rules to guide enhancements to the lifter and ensure alignment with LLVM internals.]
)
#exp_item(
  role: "Academic Intern",
  name: "University of California, Irvine",
  location: "Irvine, CA",
  date: "March 2023 - March 2025",
  [Developed automated grading tools handling 400+ weekly student submissions for UCI's lower division Intermediate Programming course.],
  [Refined students' programming skills by providing constructive feedback to hundreds of students on programming assignments and projects.],
  // [Collaborated with the course instructor to ensure consistency in handling the grade rubric and providing feedback to students in order to facilitate a more standardized and fair grading process.]
)

#resume_heading("Projects")
#project_item(
  name: [Compiler With x86 ELF Binary Generation (#link("https://github.com/axelcool1234/Tiny-Compiler")[repo])],
  skills: "C++, x86 Assembly",
  date: "March 2024 - June 2024",
  [Constructed an optimizing compiler supporting signed integer arithmetic, I/O, structured control flow, and user defined functions, running a benchmark that calculates the Mandelbrot set \~8x faster than the equivalent CPython program.],
  [Implemented lexer, LL(1) recursive descent parser, SSA IR with several optimizations, register allocator, assembly code generator, and ELF bytecode assembler.],
  [Designed and integrated a Graphviz based visualizer for the SSA IR to present optimized control flow diagrams.]
)
#project_item(
  name: [Lambda Calculus Interpreter (#link("https://github.com/axelcool1234/Lambda-Calculus-Interpreter")[repo])],
  skills: "Prolog",
  date: "August 2025",
  [Implemented a full lambda calculus interpreter: tokenization, parsing, pretty printing, and evaluation to normal form (normal order beta reduction), with capture avoiding substitution via alpha conversion and free variable analysis.],
  [Added macros and parameterized macros for encoding higher order functions and Church numerals, plus alpha equivalence checking to resugar results back into macro form.],
)
#project_item(
  name: "Search Engine and Web Crawler",
  skills: "Python",
  date: "October 2023 - December 2023",
  [Developed a polite web crawler adhering to robots.txt and sitemap protocols with a team of three, using a runtime thread pool for multithreaded crawling.],
  [Built partial binary indexing for memory efficient concurrent indexing over 40k+ pages, with a frontend ranking results via TF-IDF and cosine similarity.],
  // Folded above; the ~4x and ~200x multipliers had no committed benchmark.
  // [Increased crawling speed \~4x by implementing a runtime thread pool for multithreaded crawling.],
  // [Achieved \~200x speedup in indexing via optimized partial binary indexing for memory efficient concurrent indexing (40k+ pages).],
  // [Built a simple frontend with integrated ChatGPT functionality; improved ranking via TF-IDF and cosine similarity.]
)
/*
#project_item(
  name: "Multithreaded Assembly Unittesting Library",
  skills: "Python, Assembly",
  date: "September 2023 - December 2023",
  [Developed a MIPS assembly unittesting framework with automated test generation and execution.],
  [Implemented parallel test execution to reduce runtime using Python threading.],
  [Added modular test suite architecture with automated memory/register state tracking and convention checks.]
)
*/
/*
#project_item(
  name: "Canvas Autograder",
  skills: "Python",
  date: "September 2023 - March 2025",
  [Built an automated grading system for Canvas submissions, reducing grading time by \~300% via Python autograding and PDF parsing.],
  [Implemented secure/effective testing: AST filtering, unit tests, and time/memory limits to prevent infinite loops.],
  [Designed API based grading pipeline using Canvas API to update grades/comments programmatically, bypassing slow SpeedGrader UI.]
)
*/
/*
#project_item(
  name: "Movie Ratings Classification AI Models",
  skills: "Python",
  date: "November 2024 - December 2024",
  [Developed ML models for IMDB sentiment analysis, surpassing 80% accuracy using MLP, SVM, and Random Forest.],
  [Applied NLP techniques: TF-IDF vectorization, tokenization (lemmatization/stemming), and stopword removal.],
  [Performed hyperparameter tuning and anti-overfitting strategies to balance accuracy and generalizability.],
  [Evaluated ensembles: stacking and gradient boosting to further improve classification.]
)
*/

#resume_heading("Technical Skills")
#skill_item(
  category: "Languages",
  skills: "C, C++, Rust, Lean 4, Python, Nix, Bash, Nushell, Prolog, Haskell, SQL, LaTeX, Typst"
)
#skill_item(
  category: "Frameworks/Libraries",
  skills: "LLVM, MLIR, Triton, Alive2, Z3"
)
#skill_item(
  category: "Developer Tools",
  skills: "Linux, Git, Jujutsu, Nix, Docker, CMake"
)
