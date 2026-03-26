#!/bin/bash

INPUT_DIR="${1:-.}"
OUTPUT_DIR="${2:-$INPUT_DIR}"

if [ ! -d "$INPUT_DIR" ]; then
    echo "Input folder not found: $INPUT_DIR"
    exit 1
fi

if [ -d "$OUTPUT_DIR" ]; then
    echo "Cleaning up files from previous run: $OUTPUT_DIR"
fi
rm -rf "$OUTPUT_DIR"
mkdir -p "$OUTPUT_DIR"

dbf_files=("$INPUT_DIR"/*.dbf "$INPUT_DIR"/*.DBF)
count=0
success=0
fail=0

for file in "${dbf_files[@]}"; do
    [ -f "$file" ] || continue  # Skip if no files matched
    ((count++))

    filename=$(basename "$file" | sed 's/\.[Dd][Bb][Ff]$//')
    echo "Converting: $(basename $file) -> ${filename}.csv"

    if libreoffice --headless --convert-to csv:"Text - txt - csv (StarCalc)":44,34,76 --infilter=dBase:30 "$file" --outdir "$OUTPUT_DIR" 2>/dev/null && [ -f "${OUTPUT_DIR}/${filename}.csv" ]; then
        echo "  [OK]"
        ((success++))
    else
        echo "  [FAILED]"
        ((fail++))
    fi
done

if [ $count -eq 0 ]; then
    echo "No DBF files found in: $INPUT_DIR"
    exit 0
fi

echo ""
echo "============================="
echo "Conversion complete."
echo "  Succeeded : $success"
echo "  Failed    : $fail"
echo "============================="
