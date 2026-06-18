/*****************************************************************************\
* Adapted from prod/sdtm/dm.sas (dominodatalab/CDISC01_SDTM)
* ____________________________________________________________________________
* DESCRIPTION
*
* The purpose of this program is to convert the raw XPT data to SDTM.
* This is the Demographics (DM) domain converter.
*
* Adaptation notes (kept minimal so the converter logic is unchanged):
* - The %include of domino.sas is replaced by autoexec.sas, which defines
*   the SDTMBLND and SDTMUNBD output libraries (see autoexec.sas).
* - Upstream the input transport file is /mnt/imported/data/CDISC01_RAW/dm.xpt.
*   So the bundle is self-contained, the SETUP block below first writes a
*   small CDISC Pilot01-style DM sample to ./dm.xpt as a SAS XPORT (v5)
*   transport file. The converter then reads it back exactly as upstream
*   reads the raw transport (libname xport -> set).
*
* Output:
* - SDTMBLND.dm
* - SDTMUNBD.dm
\*****************************************************************************/

* ---- SETUP: write the sample DM transport file (stands in for the raw XPT) ;
libname x xport './dm.xpt';
data x.dm;
  length STUDYID $8 DOMAIN $2 USUBJID $12 ARM $4 AGE 8 AGEU $8 SEX $1 RACE $8;
  infile datalines dsd;
  input STUDYID $ DOMAIN $ USUBJID $ ARM $ AGE AGEU $ SEX $ RACE $;
  datalines;
CDISC01,DM,01-701-1015,ARMA,56,YEARS,F,WHITE
CDISC01,DM,01-701-1023,ARMB,64,YEARS,M,WHITE
CDISC01,DM,01-701-1028,ARMA,71,YEARS,M,WHITE
CDISC01,DM,01-701-1033,ARMB,74,YEARS,M,WHITE
CDISC01,DM,01-701-1034,ARMA,77,YEARS,F,WHITE
CDISC01,DM,01-701-1047,ARMB,85,YEARS,F,WHITE
CDISC01,DM,01-701-1057,ARMA,68,YEARS,F,BLACK
CDISC01,DM,01-701-1097,ARMB,81,YEARS,F,WHITE
CDISC01,DM,01-701-1111,ARMA,52,YEARS,M,WHITE
CDISC01,DM,01-701-1115,ARMB,79,YEARS,F,ASIAN
CDISC01,DM,01-701-1118,ARMA,86,YEARS,M,WHITE
CDISC01,DM,01-701-1130,ARMB,73,YEARS,F,WHITE
;
run;
libname x clear;

* ==== dm.sas (adapted): import the DM transport domain into the SDTM libs ;
libname xpt xport './dm.xpt'; * substitute in the filename;

data SDTMBLND.dm;
  set xpt.dm;
run;

data SDTMUNBD.dm;
  set xpt.dm;
run;

libname xpt clear;

* show the converted Demographics domain;
proc contents data=SDTMBLND.dm; run;
proc print data=SDTMBLND.dm; run;
