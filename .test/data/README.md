# reference genomes

## `mason_genome.contig-length_6500.seed_37.fa`

This file was generated with `mason` in the following version (installed via bioconda):

    VERSION
        Last update: 2018-02-02_13:03:05_+0100
        mason_genome version: 2.0.9 [e165baf]
        SeqAn version: 2.4.0

The command was:

    mason_genome --contig-length 6500 --seed 37 --out-file mason_genome.contig-length_6500.seed_37.fa

## `M13.fa`

This file is simply a copy of the 5th entry in
[the UniVec core fasta file](https://ftp.ncbi.nlm.nih.gov/pub/UniVec/UniVec_Core).

# simulated reads

Reads were simulated separately from each of the above genomes, to keep sources of reads separate. 
They were then joined for the workflow to remove the M13 reads again.
Original read data as simulated can be found here.
The files found in `../trimmed/test/` are simply copies of `test.R1.fq` and `test.R2.fq`.
The workflow should remove all M13 reads from them.
The GitHub workflow validates this by comparing the resulting reads against the simulated genome reads.

Reads were simulated with `mason` in the following version (installed via bioconda):

    VERSION
        Last update: 2018-02-02_13:03:05_+0100
        mason_simulator version: 2.0.9 [e165baf]
        SeqAn version: 2.4.0 

Commands were:

    mason_simulator -ir mason_genome.contig-length_6500.seed_37.fa -n 1000 -o mason_genome.contig-length_6500.seed_37.R1.fq -or mason_genome.contig-length_6500.seed_37.R2.fq --read-name-prefix mason_genome.contig-length_6500.seed_37_
    mason_simulator -ir M13.fa -n 1000 -o M13.R1.fq -or M13.R2.fq --read-name-prefix M13_
    cat M13.R1.fq mason_genome.contig-length_6500.seed_37.R1.fq >test.R1.fq
    cat M13.R2.fq mason_genome.contig-length_6500.seed_37.R2.fq >test.R2.fq

