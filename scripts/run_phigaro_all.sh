#!/bin/bash

# ============================================================
# Batch Phigaro analysis
# run Phigaro with every .fasta files in data/ 
# ============================================================

# if serious mistake in bash, easier to find out
set -u

# ------------------------------------------------------------
# 1. Define Inut & Output Catelog
# ------------------------------------------------------------

# the folder storing all assembly FASTA
INPUT_DIR="data/"

# the folder storing all Phigaro results
OUTPUT_DIR="results/phigaro"

# the folder storing all logs
LOG_DIR="results/logs"

# ------------------------------------------------------------
# 2. Create results directory
# ------------------------------------------------------------

mkdir -p "$OUTPUT_DIR"
mkdir -p "$LOG_DIR"

# ------------------------------------------------------------
# 3. Iterate over all .fasta files in data_test
# ------------------------------------------------------------

for GENOME in "$INPUT_DIR"/*.fasta
do

    # --------------------------------------------------------
    # 4. Get sample names
    #
    # for example：
    # rawdata/ASSEMBLY__AAA0000.fasta
    #
    # after basename：
    # ASSEMBLY__AAA0000.fasta
    #
    # after removing .fasta：
    # ASSEMBLY__AAA0000
    # --------------------------------------------------------

    SAMPLE=$(basename "$GENOME" .fasta)

    # --------------------------------------------------------
    # 5. Print the sample currently being analyzed
    # --------------------------------------------------------

    echo "================================================="
    echo "Starting sample: $SAMPLE"
    echo "Input file: $GENOME"
    echo "Start time: $(date)"
    echo "================================================="

    # --------------------------------------------------------
    # 6. Create a dedicated results directory for the current sample
    # --------------------------------------------------------

    SAMPLE_OUT="$OUTPUT_DIR/$SAMPLE"

    mkdir -p "$SAMPLE_OUT"

    # --------------------------------------------------------
    # 7. run Phigaro
    # --------------------------------------------------------

    phigaro \
        -f "$GENOME" \
        -o "$SAMPLE_OUT/$SAMPLE" \
        -e tsv gff bed html \
        -t 4 \
        -p \
        --save-fasta \
        --not-open \
        --delete-shorts \
        > "$LOG_DIR/${SAMPLE}_phigaro.log" 2>&1

    # --------------------------------------------------------
    # 8. Check if Phigaro ran successfully
    #
    # $?  means the exit status of the previous command
    #
    # 0 = normal result
    # 非0 = mistake happened
    # --------------------------------------------------------

    if [ $? -eq 0 ]; then

        echo "SUCCESS: $SAMPLE completed."

    else

        echo "ERROR: $SAMPLE failed."
        echo "Please check:"
        echo "$LOG_DIR/${SAMPLE}_phigaro.log"

    fi

    echo "End time: $(date)"
    echo ""

done

# ------------------------------------------------------------
# 9. all samples are analyzed
# ------------------------------------------------------------

echo "All Phigaro jobs finished."
echo "Finish time: $(date)"
