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
* - /mnt/data/SDTM/XPT/ae.xpt
* - /mnt/data/SDTM/XPT/cm.xpt
* - /mnt/data/SDTM/XPT/dm.xpt
* - /mnt/data/SDTM/XPT/ex.xpt
* - /mnt/data/SDTM/XPT/lb.xpt
* - /mnt/data/SDTM/XPT/mh.xpt
* - /mnt/data/SDTM/XPT/qs.xpt
* - /mnt/data/SDTM/XPT/relrec.xpt
* - /mnt/data/SDTM/XPT/sc.xpt
* - /mnt/data/SDTM/XPT/se.xpt
* - /mnt/data/SDTM/XPT/suppae.xpt
* - /mnt/data/SDTM/XPT/suppdm.xpt
* - /mnt/data/SDTM/XPT/suppds.xpt
* - /mnt/data/SDTM/XPT/supplb.xpt
* - /mnt/data/SDTM/XPT/sv.xpt
* - /mnt/data/SDTM/XPT/ta.xpt
* - /mnt/data/SDTM/XPT/te.xpt
* - /mnt/data/SDTM/XPT/ti.xpt
* - /mnt/data/SDTM/XPT/ts.xpt
* - /mnt/data/SDTM/XPT/tv.xpt
* - /mnt/data/SDTM/XPT/vs.xpt
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
local raw_files = io.popen("ls /mnt/data/CDISC01_SDTM/*.xpt");

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

