# Code Availability
This directory contains the code for EIRIs construction associated with the paper: Enhancer RNA regulates transcriptional bursting through Alu-mediated RNA interactions.

System Requirements
Linux
For minimal performance, this will be a computer with about 2 GB of RAM. For optimal performance, we recommend a computer with the following specs:RAM: 16+ GB, CPU: 4+ cores, 3.3+ GHz/core

Software Requirements
The package development version is tested on Linux operating systems Ubuntu 22.04. 
The repository includes a small demo dataset in the EIRI_construction directory:

EIRI_construction/HeLa.chimeric_reads.demo.sam – sam file of RIC-seq chimeric reads file
EIRI_construction/HeLa.enhancer_region.bed – BED file with enhancer regions
EIRI_construction/hg19.gencodeV19.gene_element_demo.bed– Reference genome annotation file
EIRI_construction/overlap.sonehs_to_stitched.list – file of stitched enhancer region clustered within a 12.5-kb region.
Run work.sh for EIRIs construction using RIC-seq chimeirc reads.
