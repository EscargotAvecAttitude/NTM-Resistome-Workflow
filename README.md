# High-Throughput Genomic Pipeline (HPC) 🧬💻

![Language](https://img.shields.io/badge/Language-Bash-blue)
![Platform](https://img.shields.io/badge/Platform-Linux%20/%20HPC-orange)
![Field](https://img.shields.io/badge/Field-Bioinformatics%20/%20Genomics-brightgreen)

## 📌 Project Overview
This repository contains custom automated command-line workflows developed to process a massive dataset of **35,000+ Non-Tuberculous Mycobacteria (NTM) genomes**. The pipeline is fully optimized for execution on the University of Southampton's *IridisX* High-Performance Computing (HPC) cluster.

The primary objective of these scripts is to conduct large-scale, parallelized profiling of:
- **Antimicrobial Resistance (AMR):** Identifying horizontally acquired resistance genes via AMRFinderPlus.
- **Mobilome & Phage-Defense Systems:** Mapping prophage regions and bacterial defense mechanisms using Phigaro, PADLOC, and DefenseFinder.

## 📂 Repository Structure
All automated batch scripts are securely located in the `scripts/` directory:
- `scripts/run_phigaro_all.sh`: Batch prophage prediction across all FASTA assemblies.
- `scripts/run_amrfinder_all.sh`: Automated AMR gene and point mutation profiling.
- `scripts/run_padloc_all.sh`: Systematic phage-defense system mapping.
- `scripts/run_defensefinder_all.sh`: High-throughput anti-phage defense system identification.

## 🚀 Execution Guide (Standard Workflow)
All batch scripts follow a standardized execution logic. Below is an example demonstrating how to deploy the pipeline using the `defensefinder` script (the exact same logic applies to `phigaro`, `padloc`, and `amrfinder`).

**1. Activate the corresponding Conda environment:**
```bash
conda activate defensefinder
```

**2. Grant execution permissions to the script:**
```bash
chmod +x scripts/run_defensefinder_all.sh
```

**3. Execute the script in the background using nohup:**
```bash
nohup bash scripts/run_defensefinder_all.sh > results/logs/defensefinder_batch.log 2>&1 &
```

**4. Monitor the real-time progress:**
```bash
tail -f results/logs/defensefinder_batch.log
```

> ⚠️ Disclaimer: Due to data privacy and clinical confidentiality, this repository only contains the computational pipeline scripts. Raw genomic data (.fasta) and patient-associated metadata from the university research project are strictly omitted.


Developed by Mira Wang as part of the Bioinformatics Research Assistant placement (Summer 2026).
