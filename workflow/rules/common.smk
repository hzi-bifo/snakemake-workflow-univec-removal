import pandas as pd
from os import path

from snakemake.utils import validate

validate(config, schema="../schemas/config.schema.yaml")


units = (
    pd.read_csv(
        config["units"],
        sep="\t",
        dtype={"sample_name": str, "unit_name": str},
        comment="#",
    )
    .set_index(["sample_name", "unit_name"], drop=False)
    .sort_index()
)

validate(units, schema="../schemas/units.schema.yaml")


def get_final_output():
    final_output = []
    
    sample_units = Path('') / units["sample_name"] / units["unit_name"]
    
    final_output.extend(
        expand(
            "trimmed/UniVec{core}_filtered/{sample_unit}.{read_number}.fastq.gz",
            core="_Core" if config["univec"]["core"] else "",
            sample_unit=sample_units,
            read_number=["1", "2"],
        )
    )

    return final_output


wildcard_constraints:
    sample="|".join(units["sample_name"]),
    unit="|".join(units["unit_name"]),
    core="|".join(["", "_Core"]),
