/*****************************************************************************\
* Adapted from prod/sdtm/vs.sas (dominodatalab/CDISC01_SDTM)
* ____________________________________________________________________________
* DESCRIPTION
*
* The purpose of this program is to convert the raw XPT data to SDTM.
* This is the Vital Signs (VS) findings-domain converter.
*
* Adaptation notes (kept minimal so the converter logic is unchanged):
* - The %include of domino.sas is replaced by autoexec.sas, which defines
*   the SDTMBLND and SDTMUNBD output libraries (see autoexec.sas).
* - Upstream the input transport file is /mnt/imported/data/CDISC01_RAW/vs.xpt.
*   So the bundle is self-contained, the SETUP block below first writes a
*   small CDISC Pilot01-style VS sample to ./vs.xpt as a SAS XPORT (v5)
*   transport file. The converter then reads it back exactly as upstream
*   reads the raw transport (libname xport -> set).
*
* Output:
* - SDTMBLND.vs
* - SDTMUNBD.vs
\*****************************************************************************/

* ---- SETUP: write the sample VS transport file (stands in for the raw XPT) ;
libname x xport './vs.xpt';
data x.vs;
  length STUDYID $8 DOMAIN $2 USUBJID $12 VSTESTCD $8 VSTEST $30
         VSSTRESN 8 VSSTRESU $12 VISITNUM 8;
  infile datalines dsd;
  input STUDYID $ DOMAIN $ USUBJID $ VSTESTCD $ VSTEST $ VSSTRESN VSSTRESU $ VISITNUM;
  datalines;
CDISC01,VS,01-701-1015,SYSBP,Systolic Blood Pressure,120,mmHg,1
CDISC01,VS,01-701-1015,DIABP,Diastolic Blood Pressure,80,mmHg,1
CDISC01,VS,01-701-1015,PULSE,Pulse Rate,72,beats/min,1
CDISC01,VS,01-701-1023,SYSBP,Systolic Blood Pressure,135,mmHg,1
CDISC01,VS,01-701-1023,DIABP,Diastolic Blood Pressure,88,mmHg,1
CDISC01,VS,01-701-1023,PULSE,Pulse Rate,80,beats/min,1
CDISC01,VS,01-701-1028,SYSBP,Systolic Blood Pressure,118,mmHg,1
CDISC01,VS,01-701-1028,DIABP,Diastolic Blood Pressure,76,mmHg,1
CDISC01,VS,01-701-1028,PULSE,Pulse Rate,68,beats/min,1
CDISC01,VS,01-701-1033,SYSBP,Systolic Blood Pressure,142,mmHg,1
CDISC01,VS,01-701-1033,TEMP,Temperature,36.7,C,1
CDISC01,VS,01-701-1034,WEIGHT,Weight,78.5,kg,1
;
run;
libname x clear;

* ==== vs.sas (adapted): import the VS transport domain into the SDTM libs ;
libname xpt xport './vs.xpt'; * substitute in the filename;

data SDTMBLND.vs;
  set xpt.vs;
run;

data SDTMUNBD.vs;
  set xpt.vs;
run;

libname xpt clear;

* show the converted Vital Signs domain, and a quick numeric summary;
proc contents data=SDTMBLND.vs; run;
proc print data=SDTMBLND.vs; run;
proc means data=SDTMBLND.vs n mean min max maxdec=1;
  class vstestcd;
  var vsstresn;
run;
