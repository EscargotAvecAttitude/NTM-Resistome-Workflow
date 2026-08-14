#!/bin/bash

# ============================================================
# Batch PADLOC analysis
# Iterate over all .fasta files in data
# ============================================================

set -u

# folder of input
INPUT_DIR="data/"

# folder of PADLOC output
OUTPUT_DIR="results/padloc"

# folder of logs
LOG_DIR="results/logs"

mkdir -p "$OUTPUT_DIR"
mkdir -p "$LOG_DIR"


# Iterate over all .fasta
for GENOME in "$INPUT_DIR"/*.fasta
do

    # extract sample names from files name
    # rawdata/ASSEMBLY__AAA0000.fasta
    # ↓
    # ASSEMBMBLY__AAA0000
    SAMPLE=$(basename "$GENOME" .fasta)

    echo "=============================================="
    echo "Starting PADLOC: $SAMPLE"
    echo "Input: $GENOME"
    echo "Start: $(date)"
    echo "=============================================="

    # create individual folder for each sample
    SAMPLE_OUT="$OUTPUT_DIR/$SAMPLE"

    mkdir -p "$SAMPLE_OUT"

    # run PADLOC
    padloc \
        --fna "$GENOME" \
        --outdir "$SAMPLE_OUT" \
        --cpu 4 \
        > "$LOG_DIR/${SAMPLE}_padloc.log" 2>&1

    # judge if it ran successfully
    if [ $? -eq 0 ]; then
        echo "SUCCESS: $SAMPLE"
    else
        echo "ERROR: $SAMPLE"
        echo "Check log: $LOG_DIR/${SAMPLE}_padloc.log"
    fi

    echo "End: $(date)"
    echo ""

done

echo "All PADLOC analyses finished."
