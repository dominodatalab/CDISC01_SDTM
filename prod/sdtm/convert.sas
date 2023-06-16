/*****************************************************************************\
*        O                                                                     
*       /                                                                      
*  O---O     _  _ _  _ _  _  _|                                                
*       \ \/(/_| (_|| | |(/_(_|                                                
*        O                                                                     
* ____________________________________________________________________________
* Sponsor              : Domino
* Compound             : VeraMedimol
* Study                : Pilot01
* Analysis             : Interim
* Program              : convers.sas
* ____________________________________________________________________________
* DESCRIPTION 
*
* The purpose of this program is to convert the raw XPT data to SDTM.
*                                                                   
* Input files:
* - /mnt/imported/data/CDISC01_RAW/ae.xpt
* - /mnt/imported/data/CDISC01_RAW/cm.xpt
* - /mnt/imported/data/CDISC01_RAW/dm.xpt
* - /mnt/imported/data/CDISC01_RAW/ex.xpt
* - /mnt/imported/data/CDISC01_RAW/lb.xpt
* - /mnt/imported/data/CDISC01_RAW/mh.xpt
* - /mnt/imported/data/CDISC01_RAW/qs.xpt
* - /mnt/imported/data/CDISC01_RAW/relrec.xpt
* - /mnt/imported/data/CDISC01_RAW/sc.xpt
* - /mnt/imported/data/CDISC01_RAW/se.xpt
* - /mnt/imported/data/CDISC01_RAW/suppae.xpt
* - /mnt/imported/data/CDISC01_RAW/suppdm.xpt
* - /mnt/imported/data/CDISC01_RAW/suppds.xpt
* - /mnt/imported/data/CDISC01_RAW/supplb.xpt
* - /mnt/imported/data/CDISC01_RAW/sv.xpt
* - /mnt/imported/data/CDISC01_RAW/ta.xpt
* - /mnt/imported/data/CDISC01_RAW/te.xpt
* - /mnt/imported/data/CDISC01_RAW/ti.xpt
* - /mnt/imported/data/CDISC01_RAW/ts.xpt
* - /mnt/imported/data/CDISC01_RAW/tv.xpt
* - /mnt/imported/data/CDISC01_RAW/vs.xpt
* 
* Output files:                                                   
* - /mnt/data/SDTM/ae.sas7bdat
* - /mnt/data/SDTM/cm.sas7bdat
* - /mnt/data/SDTM/dm.sas7bdat
* - /mnt/data/SDTM/ex.sas7bdat
* - /mnt/data/SDTM/lb.sas7bdat
* - /mnt/data/SDTM/mh.sas7bdat
* - /mnt/data/SDTM/qs.sas7bdat
* - /mnt/data/SDTM/relrec.sas7bdat
* - /mnt/data/SDTM/sc.sas7bdat
* - /mnt/data/SDTM/se.sas7bdat
* - /mnt/data/SDTM/suppae.sas7bdat
* - /mnt/data/SDTM/suppdm.sas7bdat
* - /mnt/data/SDTM/suppds.sas7bdat
* - /mnt/data/SDTM/supplb.sas7bdat
* - /mnt/data/SDTM/sv.sas7bdat
* - /mnt/data/SDTM/ta.sas7bdat
* - /mnt/data/SDTM/te.sas7bdat
* - /mnt/data/SDTM/ti.sas7bdat
* - /mnt/data/SDTM/ts.sas7bdat
* - /mnt/data/SDTM/tv.sas7bdat
* - /mnt/data/SDTM/vs.sas7bdat
*
* Macros: 
* - NA
*
* Assumptions: 
* - Every file with a .xpt extension is in a SAS XPORT format.
* ____________________________________________________________________________
* PROGRAM HISTORY                                                         
 * ----------------------------------------------------------------------------
*  YYYYMMDD  |  username        | ..description of change..         
\*****************************************************************************/


%include "!DOMINO_WORKING_DIR/domino.sas";

* Don't panic! This just loops over XPTs;
proc lua restart;
submit;
-- Get list of files
local raw_files = io.popen("ls /mnt/imported/data/CDISC01_RAW/*.xpt");

for file in raw_files:lines() do
	sas.submit([[
		libname xpt xport '@file@'; * substitute in the filename;

		proc copy in=xpt out=SDTMBLND;
		run;

		proc copy in=xpt out=SDTMUNBD;
		run;

		libname xpt clear;
	]])
end
endsubmit;
run;

