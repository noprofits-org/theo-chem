Experiment Design: Calculating Polarizabilities of Group 4A Elements
Objective
Calculate the dipole moment (
𝜇
𝑥
μ 
x
​
 ), polarizability (
𝛼
𝑥
𝑥
α 
xx
​
 ), first hyperpolarizability (
𝛽
𝑥
𝑥
𝑥
β 
xxx
​
 ), and second hyperpolarizability (
𝛾
𝑥
𝑥
𝑥
𝑥
γ 
xxxx
​
 ) for carbon (C), silicon (Si), germanium (Ge), tin (Sn), and lead (Pb) using NWChem in a new directory (~/nw_chem_IVA_pol_exp).

Method: Finite Field Approach
Theory: Apply external electric fields along the x-axis and measure the induced dipole moment (
𝜇
𝑥
μ 
x
​
 ) to derive properties via finite differences:
𝛼
𝑥
𝑥
=
𝜇
𝑥
(
𝐹
𝑥
=
+
ℎ
)
−
𝜇
𝑥
(
𝐹
𝑥
=
−
ℎ
)
2
ℎ
α 
xx
​
 = 
2h
μ 
x
​
 (F 
x
​
 =+h)−μ 
x
​
 (F 
x
​
 =−h)
​
 
𝛽
𝑥
𝑥
𝑥
=
𝜇
𝑥
(
𝐹
𝑥
=
+
ℎ
)
−
2
𝜇
𝑥
(
𝐹
𝑥
=
0
)
+
𝜇
𝑥
(
𝐹
𝑥
=
−
ℎ
)
ℎ
2
β 
xxx
​
 = 
h 
2
 
μ 
x
​
 (F 
x
​
 =+h)−2μ 
x
​
 (F 
x
​
 =0)+μ 
x
​
 (F 
x
​
 =−h)
​
 
𝛾
𝑥
𝑥
𝑥
𝑥
=
𝜇
𝑥
(
𝐹
𝑥
=
+
ℎ
)
−
2
𝜇
𝑥
(
𝐹
𝑥
=
0
)
+
𝜇
𝑥
(
𝐹
𝑥
=
−
ℎ
)
ℎ
3
γ 
xxxx
​
 = 
h 
3
 
μ 
x
​
 (F 
x
​
 =+h)−2μ 
x
​
 (F 
x
​
 =0)+μ 
x
​
 (F 
x
​
 =−h)
​
  (simplified 3-point; we’ll refine later if needed).
Field Strength (
ℎ
h): Use 
ℎ
=
0.002
h=0.002 a.u. (consistent with your Psi4 runs—small enough for linearity, big enough to avoid numerical noise).
Fields: Run each element at 
𝐹
𝑥
=
0.0
F 
x
​
 =0.0, 
+
0.002
+0.002, and 
−
0.002
−0.002 a.u.
System Details
Software: NWChem 7.2.0 (installed in (psi4fix) environment).
Elements: C, Si, Ge, Sn, Pb.
Basis Sets:
C, Si, Ge: cc-pVDZ (no ECP needed—light elements).
Sn, Pb: cc-pVDZ-PP (with ECP to handle relativistic effects).
Geometry: Single atom at (0, 0, 0) for each element (spherical symmetry, no nuclear dipole).
Charge: Neutral (0).
Convergence: SCF threshold at 
1
0
−
8
10 
−8
  for precision.
Workflow
Generate Input Files:
For each element and field (15 total: 5 elements × 3 fields).
Store in inputs/ as .nw files (e.g., C_field0.0.nw, C_field0.002.nw, Sn_fieldminus0.002.nw).
Include basis set, ECP (where applicable), field, and SCF task.
Run NWChem:
Execute each .nw file, saving outputs in outputs/ (e.g., C_field0.0.out).
Ensure each run completes with Total SCF energy and Multipole analysis.
Extract Data:
Pull 
𝜇
𝑥
μ 
x
​
  from “Multipole analysis” section (line 1 1 0 0 for x-dipole).
Handle missing/invalid data with defaults (e.g., 0.0).
Calculate Properties:
Use finite difference formulas for 
𝛼
𝑥
𝑥
α 
xx
​
 , 
𝛽
𝑥
𝑥
𝑥
β 
xxx
​
 , 
𝛾
𝑥
𝑥
𝑥
𝑥
γ 
xxxx
​
 .
Output to analysis/properties.csv.
Validate:
Compare 
𝛼
𝑥
𝑥
α 
xx
​
  for C, Si, Ge to your Psi4 results (7.11, 20.17, 20.19 a.u.).
Check 
𝛽
β and 
𝛾
γ (expect ~0 for symmetric atoms, but fields might reveal small values).
Directory Structure
~/nw_chem_IVA_pol_exp/:
inputs/: .nw input files.
outputs/: .out output files.
scripts/: Bash scripts (e.g., generate_inputs.sh, extract_properties.sh).
analysis/: Results (e.g., properties.csv, results.log).
Expected Output
properties.csv:
