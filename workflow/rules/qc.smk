
rule falco:
    input:
        "results/trimmed/UniVec{core}_filtered/{sample}/{unit}.{read}.fastq.gz",
    output:
        "results/trimmed/UniVec{core}_filtered/{sample}/{unit}.{read}/fastqc_data.txt",
        report(
            "trimmed/UniVec{core}_filtered/{sample}/{unit}.{read}/fastqc_report.html",
            caption="../report/falco_univec.rst",
            category="Quality Control",
        ),
        "results/trimmed/UniVec{core}_filtered/{sample}/{unit}.{read}/summary.txt",
    params:
        out_dir=lambda wc, output: path.dirname(output[0]),
    conda:
        "../envs/falco.yaml"
    log:
        "logs/falco/UniVec{core}_filtered/{sample}/{unit}.{read}.log",
    shell:
        """
        ( falco --outdir {params.out_dir} --dir {params.out_dir} {input} ) >{log} 2>&1
        """
