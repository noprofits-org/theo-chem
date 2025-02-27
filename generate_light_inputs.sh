cd ~/nw_chem_IVA_pol_exp
cat > scripts/generate_light_inputs.sh << 'EOL'
#!/bin/bash
INPUT_DIR="inputs"
OUTPUT_DIR="outputs"
mkdir -p "$INPUT_DIR" "$OUTPUT_DIR"
FIELDS=("0.002" "0.0" "-0.002")
ELEMENTS=("C" "Si" "Ge")

for elem in "${ELEMENTS[@]}"; do
  for field in "${FIELDS[@]}"; do
    field_name=${field//-/minus}
    filename="$INPUT_DIR/${elem}_field${field_name}.nw"
    if [ "$field" == "0.0" ]; then
      cat > "$filename" << EOF
start ${elem}_field${field_name}
geometry
  ${elem} 0 0 0
end
basis
  ${elem} library cc-pVDZ
end
set scf:thresh 1.0e-8
charge 0
task scf
EOF
    else
      cat > "$filename" << EOF
start ${elem}_field${field_name}
geometry
  ${elem} 0 0 0
end
basis
  ${elem} library cc-pVDZ
end
set scf:thresh 1.0e-8
charge 0
field
  dipole
  x $field
end
task scf
EOF
    fi
    echo "Generated $filename"
  done
done
EOL
chmod +x scripts/generate_light_inputs.sh
./scripts/generate_light_inputs.sh
ls -l inputs/
