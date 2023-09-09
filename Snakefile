output_dir = "/mnt/artifacts/results"

rule all:
    output:
        f"{output_dir}/output.txt"

rule create_empty_file:
    output:
        f"{output_dir}/output.txt"
    shell:
        "touch {output}"