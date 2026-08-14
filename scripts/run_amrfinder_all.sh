#!/bin/bash

# ============================================================
# Batch amrfinder analysis
# Iterate over all .fasta files in data
# ============================================================

set -u

# folder of input
INPUT_DIR="data/"

# folder of amrfinder output
OUTPUT_DIR="results/amrfinder"

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
    echo "Starting amrfinder: $SAMPLE"
    echo "Input: $GENOME"
    echo "Start: $(date)"
    echo "=============================================="

    # create individual folder for each sample
    SAMPLE_OUT="$OUTPUT_DIR/$SAMPLE"

    mkdir -p "$SAMPLE_OUT"

    # run amrfinder
    amrfinder -n "$GENOME" -o "$SAMPLE_OUT/${SAMPLE}.tsv" \
        > "$LOG_DIR/${SAMPLE}_amrfinder.log" 2>&1

    # judge if it ran successfully
    if [ $? -eq 0 ]; then
        echo "SUCCESS: $SAMPLE"
    else
        echo "ERROR: $SAMPLE"
        echo "Check log: $LOG_DIR/${SAMPLE}_amrfinder.log"
    fi

    echo "End: $(date)"
    echo ""

done

echo "All amrfinder analyses finished."
