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
* Program              : ta.sas
* ____________________________________________________________________________
* DESCRIPTION 
*
* The purpose of this program is to convert the raw XPT data to SDTM.
*                                                                   
* Input files:
* - /mnt/data/SDTM/XPT/ta.xpt
* 
* Output files:                                                   
* - /mnt/data/SDTMBLIND/ta.sas7bdat
* - /mnt/data/SDTMUNBLIND/ta.sas7bdat
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

libname xpt xport '/mnt/data/CDISC01_SDTM/ta.xpt'; * substitute in the filename;

proc copy in=xpt out=SDTMBLND;
run;

proc copy in=xpt out=SDTMUNBD;
run;

libname xpt clear;
