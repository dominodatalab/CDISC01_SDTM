# Start a SAS and R job via the Domino API from Python

import os
from domino import Domino

domino = Domino(
    "CDISC01_Data_Management/CDISC01_SDTM",
    api_key=os.environ["DOMINO_USER_API_KEY"],
    host=os.environ["DOMINO_API_HOST"],
)

# SAS JOB
domino.job_start(command="/mnt/code/prod/sdtm/ae.sas", environment_id="64c976672b981732df07d477", title="SAS executed via API")

# R JOB
domino.job_start(command="/mnt/code/utilities/refresh.R", environment_id="64c978892b981732df07d4a5", title="R executed via API")