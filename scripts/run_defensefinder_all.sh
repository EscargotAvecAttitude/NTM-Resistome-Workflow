#!/bin/bash

# ============================================================
# Batch defensefinder analysis
# Iterate over all .fasta files in data
# ============================================================

set -u

# folder of input
INPUT_DIR="data/"

# folder of defensefinder output
OUTPUT_DIR="results/defensefinder"

# folder of logs
LOG_DIR="results/logs"

mkdir -p "$OUTPUT_DIR"
mkdir -p "$LOG_DIR"

# Iterate over all .fasta
for GENOME in "$INPUT_DIR"/*.fasta
do

    # extract sample names from files name
    # rawdata/ASSEMBLY__ERR459914.fasta
    # ↓
    # ASSEMBLY__ERR459914
    SAMPLE=$(basename "$GENOME" .fasta)

    echo "=============================================="
    echo "Starting defensefinder: $SAMPLE"
    echo "Input: $GENOME"
    echo "Start: $(date)"
    echo "=============================================="

    # create individual folder for each sample
    SAMPLE_OUT="$OUTPUT_DIR/$SAMPLE"

    mkdir -p "$SAMPLE_OUT"

    # run defensefinder
    defense-finder run \
    "$GENOME" \
    --out-dir results/defensefinder/"$SAMPLE" \
    --workers 4 \
        > "$LOG_DIR/${SAMPLE}_defensefinder.log" 2>&1

    # judge if it ran successfully
    if [ $? -eq 0 ]; then
        echo "SUCCESS: $SAMPLE"
    else
        echo "ERROR: $SAMPLE"
        echo "Check log: $LOG_DIR/${SAMPLE}_defensefinder.log"
    fi

    echo "End: $(date)"
    echo ""

done

echo "All defensefinder analyses finished."
