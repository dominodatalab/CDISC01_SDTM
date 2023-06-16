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
* Program              : te.sas
* ____________________________________________________________________________
* DESCRIPTION 
*
* The purpose of this program is to convert the raw XPT data to SDTM.
*                                                                   
* Input files:
* - /mnt/imported/data/CDISC01_RAW/te.xpt
* 
* Output files:                                                   
* - /mnt/data/SDTMBLIND/te.sas7bdat
* - /mnt/data/SDTMUNBLIND/te.sas7bdat
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

libname xpt xport '/mnt/imported/data/CDISC01_RAW/te.xpt'; * substitute in the filename;

proc copy in=xpt out=SDTMBLND;
run;

proc copy in=xpt out=SDTMUNBD;
run;

libname xpt clear;
