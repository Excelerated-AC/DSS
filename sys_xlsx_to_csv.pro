601,100
602,"sys_xlsx_to_csv"
562,"NULL"
586,
585,
564,
565,"r4UYe;KJSoxikNceVDazhaR`qA;HM472VR7PC;F]uLctNC\7k<yO\jw2=oPkY5OAIV=^ApP[EkGg8>vQbWWl5=JO9WDNVIFe9voo7ztn`lL<yIVZ@yjLwcxB<_S6LoqRO<PxdVMBtsggnImUjKNoV17z`4affxCcsqhjThPr]>Cd_tdr\pftZPQ<hSrxU@Be@CfbM?KD"
559,1
928,0
593,
594,
595,
597,
598,
596,
800,
801,
566,0
567,","
588,"."
589,
568,""""
570,
571,
569,0
592,0
599,1000
560,3
psXLSFile
psXLSSheet
psCSVFile
561,3
2
2
2
590,3
psXLSFile,"\\tm1-tams\tm1_common_tccs\TAMS_Upload\Activity Based Costing\2020-2021\Vehicle Allocation\Vehicle Invoice Files\CP Aug.xlsx"
psXLSSheet,"invoice Data"
psCSVFile,"\\tm1-tams\tm1_common_tccs\TAMS_Upload\Activity Based Costing\2020-2021\Vehicle Allocation\Vehicle Invoice Files\CP Aug.csv"
637,3
psXLSFile,"Path to XLS file"
psXLSSheet,"Sheet name "
psCSVFile,"Path to CSV (output) file (will be overwritten)"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,50

#****Begin: Generated Statements***
#****End: Generated Statements****



#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#
# Process:            sys_xlsx_to_csv
#
# Purpose:            Script to convert XLS file into a CSV for import into TM1
#                                            
# Written by:         Rod Jager (rjager@excelerated.com.au) | Initial script development
#
# Date:                  08/10/2020
#
#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#----------------------------------------------------------
#    VARIABLES
#----------------------------------------------------------
sPSScript = '.\scripts\xlsx_to_csv.ps1';
sCmdLine = 'powershell -file ' | sPSScript | ' -xlsfile "' | psXLSFile | '" -xlssheet "' | psXLSSheet | '" -csvfile "' | psCSVFile | '"';

#----------------------------------------------------------
#    TEST SOURCE FILE
#----------------------------------------------------------
# Check if output file exists
IF(FILEEXISTS(psXLSFile) = 0);
      # File does not exist so quit
      ITEMREJECT(psXLSFile | ' cannot be found.');
ENDIF;

#----------------------------------------------------------
#    EXECUTE THE SCRIPT
#----------------------------------------------------------
# Using paramter of 1 as we need to wait for script to complete before going to next step
EXECUTECOMMAND(sCmdLine, 1);

#----------------------------------------------------------
#    TEST CSV FILE
#----------------------------------------------------------
# Check if output file exists
IF(FILEEXISTS(psCSVFile) = 0);
      # File does not exist so quit
      ITEMREJECT(psCSVFile | ' cannot be found.');
ENDIF;


# DO REST OF PROCESS FROM HERE ON...
573,3

#****Begin: Generated Statements***
#****End: Generated Statements****
574,3

#****Begin: Generated Statements***
#****End: Generated Statements****
575,3

#****Begin: Generated Statements***
#****End: Generated Statements****
576,CubeAction=1511DataAction=1503CubeLogChanges=0
930,0
638,1
804,0
1217,0
900,
901,
902,
938,0
937,
936,
935,
934,
932,0
933,0
903,
906,
929,
907,
908,
904,0
905,0
909,0
911,
912,
913,
914,
915,
916,
917,0
918,1
919,0
920,50000
921,""
922,""
923,0
924,""
925,""
926,""
927,""
