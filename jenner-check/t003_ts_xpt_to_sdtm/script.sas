/*****************************************************************************\
* Adapted from prod/sdtm/ts.sas (dominodatalab/CDISC01_SDTM)
* ____________________________________________________________________________
* DESCRIPTION
*
* The purpose of this program is to convert the raw XPT data to SDTM.
* This is the Trial Summary (TS) trial-design-domain converter.
*
* Adaptation notes (kept minimal so the converter logic is unchanged):
* - The %include of domino.sas is replaced by autoexec.sas, which defines
*   the SDTMBLND and SDTMUNBD output libraries (see autoexec.sas).
* - Upstream the input transport file is /mnt/imported/data/CDISC01_RAW/ts.xpt.
*   So the bundle is self-contained, the SETUP block below first writes a
*   small CDISC Pilot01-style TS sample to ./ts.xpt as a SAS XPORT (v5)
*   transport file. The converter then reads it back exactly as upstream
*   reads the raw transport (libname xport -> set).
*
* Output:
* - SDTMBLND.ts
* - SDTMUNBD.ts
\*****************************************************************************/

* ---- SETUP: write the sample TS transport file (stands in for the raw XPT) ;
libname x xport './ts.xpt';
data x.ts;
  length STUDYID $8 DOMAIN $2 TSSEQ 8 TSPARMCD $8 TSPARM $40 TSVAL $40;
  infile datalines dsd;
  input STUDYID $ DOMAIN $ TSSEQ TSPARMCD $ TSPARM $ TSVAL $;
  datalines;
CDISC01,TS,1,ADAPT,Adaptive Design,N
CDISC01,TS,2,AGEMIN,Planned Minimum Age of Subjects,P50Y
CDISC01,TS,3,LENGTH,Trial Length,P26W
CDISC01,TS,4,PLANSUB,Planned Number of Subjects,306
CDISC01,TS,5,RANDOM,Trial is Randomized,Y
CDISC01,TS,6,SEXPOP,Sex of Participants,BOTH
CDISC01,TS,7,STYPE,Study Type,INTERVENTIONAL
CDISC01,TS,8,TBLIND,Trial Blinding Schema,DOUBLE BLIND
CDISC01,TS,9,TCNTRL,Control Type,PLACEBO
CDISC01,TS,10,TPHASE,Trial Phase Classification,PHASE II TRIAL
;
run;
libname x clear;

* ==== ts.sas (adapted): import the TS transport domain into the SDTM libs ;
libname xpt xport './ts.xpt'; * substitute in the filename;

data SDTMBLND.ts;
  set xpt.ts;
run;

data SDTMUNBD.ts;
  set xpt.ts;
run;

libname xpt clear;

* show the converted Trial Summary domain;
proc contents data=SDTMBLND.ts; run;
proc print data=SDTMBLND.ts; run;
