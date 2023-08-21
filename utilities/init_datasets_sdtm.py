from domino import Domino
import os

domino = Domino(f"{os.environ['DOMINO_PROJECT_OWNER']}/{os.environ['DOMINO_PROJECT_NAME']}")

# Create domino datasets

# Required Datasets & Descriptions
REQUIRED = {
    "SDTMUNBLIND": "SDTMUNBLIND is created using RAW and UNBLIND",
    "SDTMBLIND": "SDTMBLIND is created using RAW and DUMMY",
    "METADATA": "Metadata file is copied by the SDTM project to the METADATA dataset and snapshotted with the study specific reference files."
}

# Existing Datasets
CURRENT = set(d['datasetName'] for d in domino.datasets_list(project_id=os.environ["DOMINO_PROJECT_ID"]))

# For any required datasets which do not exist 
for key in set(REQUIRED.keys()).difference(CURRENT):
    # Make them
    domino.datasets_create(key, REQUIRED[key])
