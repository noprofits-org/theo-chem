# Experiment Design: Calculating Polarizabilities of Group 4A Elements

## Objective

Calculate the dipole moment ($\mu_x$), polarizability ($\alpha_{xx}$), first hyperpolarizability ($\beta_{xxx}$), and second hyperpolarizability ($\gamma_{xxxx}$) for carbon (C), silicon (Si), germanium (Ge), tin (Sn), and lead (Pb) using NWChem in a new directory (`~/nw_chem_IVA_pol_exp`).

## Method: Finite Field Approach

- **Theory**: Apply external electric fields along the x-axis and measure the induced dipole moment ($\mu_x$) to derive properties via finite differences:

  - $\alpha_{xx} = \frac{\mu_x(F_x=+h)-\mu_x(F_x=-h)}{2h}$
  
  - $\beta_{xxx} = \frac{\mu_x(F_x=+h)-2\mu_x(F_x=0)+\mu_x(F_x=-h)}{h^2}$
  
  - $\gamma_{xxxx} = \frac{\mu_x(F_x=+h)-2\mu_x(F_x=0)+\mu_x(F_x=-h)}{h^3}$ (simplified 3-point; we'll refine later if needed).

- **Field Strength ($h$)**: Use $h = 0.002$ a.u. (consistent with your Psi4 runs—small enough for linearity, big enough to avoid numerical noise).

- **Fields**: Run each element at $F_x = 0.0$, $+0.002$, and $-0.002$ a.u.

## System Details

- **Software**: NWChem 7.2.0 (installed in `(psi4fix)` environment).

- **Elements**: C, Si, Ge, Sn, Pb.

- **Basis Sets**:
  - C, Si, Ge: `cc-pVDZ` (no ECP needed—light elements).
  - Sn, Pb: `cc-pVDZ-PP` (with ECP to handle relativistic effects).

- **Geometry**: Single atom at (0, 0, 0) for each element (spherical symmetry, no nuclear dipole).

- **Charge**: Neutral (0).

- **Convergence**: SCF threshold at $10^{-8}$ for precision.

## Workflow

1. **Generate Input Files**:
   - For each element and field (15 total: 5 elements × 3 fields).
   - Store in `inputs/` as `.nw` files (e.g., `C_field0.0.nw`, `C_field0.002.nw`, `Sn_fieldminus0.002.nw`).
   - Include basis set, ECP (where applicable), field, and SCF task.

2. **Run NWChem**:
   - Execute each `.nw` file, saving outputs in `outputs/` (e.g., `C_field0.0.out`).
   - Ensure each run completes with `Total SCF energy` and `Multipole analysis`.

3. **Extract Data**:
   - Pull $\mu_x$ from "Multipole analysis" section (line `1 1 0 0` for x-dipole).
   - Handle missing/invalid data with defaults (e.g., 0.0).

4. **Calculate Properties**:
   - Use finite difference formulas for $\alpha_{xx}$, $\beta_{xxx}$, $\gamma_{xxxx}$.
   - Output to `analysis/properties.csv`.

5. **Validate**:
   - Compare $\alpha_{xx}$ for C, Si, Ge to your Psi4 results (7.11, 20.17, 20.19 a.u.).
   - Check $\beta$ and $\gamma$ (expect ~0 for symmetric atoms, but fields might reveal small values).

## Directory Structure

- `~/nw_chem_IVA_pol_exp/`:
  - `inputs/`: `.nw` input files.
  - `outputs/`: `.out` output files.
  - `scripts/`: Bash scripts (e.g., `generate_inputs.sh`, `extract_properties.sh`).
  - `analysis/`: Results (e.g., `properties.csv`, `results.log`).

## Expected Output

- `properties.csv`:
