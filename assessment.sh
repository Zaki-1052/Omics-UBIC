# check_current_state.sh
#!/bin/bash

echo "=== Checking current data state ==="

# Check what FASTQ files we have
echo -e "\nOriginal 10x FASTQ files:"
ls -la pbmc_granulocyte_sorted_3k/gex/*.fastq.gz | head -5
ls -la pbmc_granulocyte_sorted_3k/atac/*.fastq.gz | head -5

# Check if we have barcode information preserved
echo -e "\nChecking if barcodes are in read names:"
zcat pbmc_granulocyte_sorted_3k/gex/*_R1_001.fastq.gz | head -n 4
echo "---"
zcat pbmc_granulocyte_sorted_3k/gex/*_R2_001.fastq.gz | head -n 4

# Check reference files
echo -e "\nReference files:"
ls -la ../references/*.fa
ls -la ../graphs/*.vg

# Check if we have the barcode whitelist
echo -e "\nBarcode whitelist:"
ls -la *barcode*.txt* || echo "No barcode whitelist found"
