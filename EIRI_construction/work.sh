perl from_sam_to_pair_reads_bed.pl HeLa.chimeric_reads.demo.sam
bedtools intersect -wa -wb -a HeLa.enhancer_region.bed -b read_1.bed -F 0.5 > enhancer_overlap_with_read1.bed
bedtools intersect -wa -wb -a HeLa.enhancer_region.bed -b read_2.bed -F 0.5 > enhancer_overlap_with_read2.bed
bedtools intersect -wa -wb -a hg19.gencodeV19.gene_element.bed -b read_1.bed -F 0.5 -s > genicEle_overlap_with_read1.bed
bedtools intersect -wa -wb -a hg19.gencodeV19.gene_element.bed -b read_2.bed -F 0.5 -s > genicEle_overlap_with_read2.bed
grep Intron genicEle_overlap_with_read1.bed > Intron_overlap_with_read1.bed
grep Intron genicEle_overlap_with_read2.bed > Intron_overlap_with_read2.bed
python format_Intron_overlap_reads.py Intron_overlap_with_read1.bed
python format_Intron_overlap_reads.py Intron_overlap_with_read2.bed
python format_Intron_overlap_reads_step2.py Intron_overlap_with_read1.formated.bed Intron_overlap_with_read1.formated_step2.bed
python format_Intron_overlap_reads_step2.py Intron_overlap_with_read2.formated.bed Intron_overlap_with_read2.formated_step2.bed
sort Intron_overlap_with_read1.formated_step2.bed |uniq > Intron_overlap_with_read1.formated.uniq.bed
sort Intron_overlap_with_read2.formated_step2.bed |uniq > Intron_overlap_with_read2.formated.uniq.bed
perl collect_enhancer_promoter.pl enhancer_overlap_with_read1.bed enhancer_overlap_with_read2.bed Intron_overlap_with_read1.formated.uniq.bed Intron_overlap_with_read2.formated.uniq.bed HeLaAndSecondadd_merge
perl make_network_stitchedEnhancer.pl result2.HeLaAndSecondadd_merge.enhancer_intron_interaction.pair overlap.sonehs_to_stitched.list > result3.HeLaAndSecondadd_merge.enhancer_to_preRNA.pair

