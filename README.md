# Snakemake workflow: `snakemake-workflow-univec-removal`

[![Snakemake](https://img.shields.io/badge/snakemake-≥6.3.0-brightgreen.svg)](https://snakemake.github.io)
[![GitHub actions status](https://github.com/<owner>/<repo>/workflows/Tests/badge.svg?branch=main)](https://github.com/<owner>/<repo>/actions?query=branch%3Amain+workflow%3ATests)


A Snakemake workflow for removing reads from lab contaminations by filtering with the vector sequences in [the UniVec database](https://www.ncbi.nlm.nih.gov/tools/vecscreen/univec/).
This workflow assumes that (sequencing) adapters habe already been trimmed from input reads.


## Usage

The usage of this workflow is described in the [Snakemake Workflow Catalog](https://snakemake.github.io/snakemake-workflow-catalog/?usage=hzi-bifo%2Fsnakemake-workflow-univec-removal).

If you use this workflow in a paper, don't forget to give credits to the authors by citing the URL of this (original) repository and its DOI (see above).
