
rule download_univec:
    output:
        fasta="resources/UniVec{core}.fa",
        uv="resources/UniVec/README.uv",
        origins="resources/UniVec/README.vector.origins",
    log:
        "logs/UniVec{core}/download.log",
    conda:
        "../envs/curl.yaml"
    cache: True
    shell:
        "( curl -sS -o {output.fasta} https://ftp.ncbi.nlm.nih.gov/pub/UniVec/UniVec{wildcards.core} && "
        "  curl -sS -o {output.uv} https://ftp.ncbi.nlm.nih.gov/pub/UniVec/README.uv && "
        "  curl -sS -o {output.origins} https://ftp.ncbi.nlm.nih.gov/pub/UniVec/README.vector.origins  ) > {log} 2>&1"


rule bwa_index:
    input:
        "resources/UniVec{core}.fa",
    output:
        multiext("resources/UniVec{core}", ".amb", ".ann", ".bwt", ".pac", ".sa"),
    log:
        "logs/bwa_index/UniVec{core}.log",
    params:
        prefix=lambda wc: "UniVec{wc.core}",
        algorithm="bwtsw",
    cache: True
    wrapper:
        "0.80.3/bio/bwa/index"


rule bwa_mem:
    input:
        reads=["trimmed/{sample}/{unit}.1.fastq", "trimmed/{sample}/{unit}.2.fastq"],
        genome=multiext("resources/UniVec{core}", ".amb", ".ann", ".bwt", ".pac", ".sa"),
    output:
        "mapped/UniVec{core}/{sample}/{unit}.bam",
    params:
        index="genome",
        extra=r"-R '@RG\tID:{sample}\tSM:{sample}'",
        sorting="samtools",  # Can be 'none', 'samtools' or 'picard'.
        sort_order="coordinate",  # Can be 'queryname' or 'coordinate'.
        sort_extra="",  # Extra args for samtools/picard.
    log:
        "logs/bwa_mem/UniVec{core}/{sample}/{unit}.log",
    threads: 8
    wrapper:
        "0.80.3/bio/bwa/mem"


rule bam_2_unmapped_paired_fq:
    input:
        "mapped/UniVec{core}/{sample}.bam",
    output:
        forward="trimmed/UniVec{core}_filtered/{sample}/{unit}.1.fastq.gz",
        reverse="trimmed/UniVec{core}_filtered/{sample}/{unit}.2.fastq.gz",
    conda:
        "../envs/samtools.yaml"
    log:
        "logs/samtools/UniVec{core}_filtered/{sample}/{unit}_bam_to_fastq.log",
    threads: 1
    shell:
        """
        ( samtools fastq -F 0x2 -1 {output.forward} -2 {output.reverse} {input} ) >{log} 2>&1
        """
