Please include the workflow using the [Snakemake module system](https://snakemake.readthedocs.io/en/latest/snakefiles/modularization.html#modules).
The easiest way to deploy it is via the description here in the snakemake workflow catalog and by then adjusting:

1. The `reads=` entry in the `input:` of `rule bwa_mem:` to where your enclosing workflow provides adapter-trimmed read sequences.
2. Specifying whether you want to use the `core: True` version of UniVec, which avoids removing too much, or whether you want to use the more comprehensive catalog and risk false-positive read removals (`core: False`).
3. Set the  `output:` of `rule bam_2_unmapped_paired_fq:` to a path and files that your enclosing workflow processes downstream.
4. Optional: Make sure the `rule all:` of your enclosing workflow requires the `output:` of `rule falco:` as input, if you want the FastQC-like html-report in your snakemake report.
