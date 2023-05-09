# SCE_SDTM_TEMPLATE

This repo contains the folder structure to template a study wide SDTM project.

# Directory structure

The programming is created in a typical clinical trial folder structure, where the production (prod) and qc programs have independent directory trees.

Reporting effort level standard code (e.g. SAS macros) should be stored in the `share/macros` folder.

The global `domino.sas` autoexec progam is also included in the repository to appropriately set up the SAS environment. 

```
repo
│   domino.sas
├───prod
│   └───sdtm
├───qc
│   └───sdtm
└───share
    └───macros
```

# Naming convention

The programs follow a typical clinical trial naming convention, where the SDTM programs are named after the datasets they are producing (e.g. DM.sas, AE.sas, etc...)

# Support

Programming was created by Veramed Ltd. on behalf of Domino Data Lab, Inc.
