/* autoexec for t003_ts_xpt_to_sdtm
 *
 * Stands in for the part of the study's domino.sas autoexec that the TS
 * converter relies on: the SDTMBLND and SDTMUNBD output libraries.
 *
 * Upstream, domino.sas points these at the Domino platform paths
 *   libname SDTMUNBD "&__localdata_path./SDTMUNBLIND";
 *   libname SDTMBLND "&__localdata_path./SDTMBLIND";
 * where &__localdata_path resolves to /mnt/data (git project) on Domino.
 *
 * Here they are local directories so the converter runs in any SAS session.
 */
options obs=100;

libname SDTMBLND './sdtmblind';
libname SDTMUNBD './sdtmunblind';
