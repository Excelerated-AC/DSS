601,100
602,"CAM_AD Integration - File Availability Assessment"
562,"CHARACTERDELIMITED"
586,"\\PRDAPP433VS\tm1_common_strategic_finance\Upload\sample.csv"
585,"\\PRDAPP433VS\tm1_common_strategic_finance\CSD_TM1\zImport\test.csv"
564,
565,"m8g=K@dDhn7tNabeUK3K;V29duT>>LE7vDbGSa_Gbk1_jzK;k^uFMAbt5h4CfZr;W8TJ9[5zH>?jZ=S:qQ^lR3pXPIhygGzFUx8VX=;8ExR`:=jSn9t_3LXa5WpQ;=R?rcM6\tVn[Fb1:1WuJVblSV?yJQPj^lFN4^McWPfzea6zBMV7]A1?\05HylDY:rooCg]]ID0e"
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
589,","
568,""""
570,
571,
569,2
592,0
599,1000
560,1
pFilePath
561,1
2
590,1
pFilePath,"zImport\"
637,1
pFilePath,"File path to send temporary user list to eg - \\tm1-Report\TM1_Common_Shared_Services_FS\Shared_Services_FS\zImport\ or 'zImport\'"
577,6
vSamAccountName
vName
vObjectguid
vEmail
vuserPrincipalName
V6
578,6
2
2
2
2
2
1
579,6
1
2
3
4
5
6
580,6
0
0
0
0
0
0
581,6
0
0
0
0
0
0
582,6
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=33ColType=827
603,0
572,64

#****Begin: Generated Statements***
#****End: Generated Statements****


# Process Name: CAM_AD Integration - File Availability Assessment
#_______________________________________________________________________________

# _______________________________________________________________________________
# 1.0 Start Prolog
# _______________________________________________________________________________

# _______________________________________________________________________________
# Purpose:          This process will attempt to run the required file 
#                   the purpose is to generate a return-code which will then be  
#                   used by the parent process to determine whether to proceed.
#
# Developer:        Excelerated | Andrew Craig | 01 Mar 2021
# 
# Update Log:       
# _______________________________________________________________________________



# Parameters
# _______________________________________________________________________________

# pFilePath | String | File path to send temporary user list to eg - \\tm1-Report\TM1_Common_Shared_Services_FS\Shared_Services_FS\zImport\ or 'zImport\'



# Variables
# _______________________________________________________________________________

# Nil



# 1.1 Assign data source 
# _______________________________________________________________________________

sFilePath = pFilePath;

DataSourceType                  = 'CHARACTERDELIMITED';
DatasourceNameForServer         = sFilePath;
DatasourceNameForClient         = sFilePath;
DatasourceASCIIHeaderRecords    = 2;
DatasourceASCIIDelimiter        = ',';
DatasourceASCIIQuoteCharacter   = '"';



# _______________________________________________________________________________
# 1.9 End Prolog
# _______________________________________________________________________________









573,19

#****Begin: Generated Statements***
#****End: Generated Statements****




# _______________________________________________________________________________
# 2.0 Start MetaData
# _______________________________________________________________________________




# _______________________________________________________________________________
# 2.9 End MetaData
# _______________________________________________________________________________


574,28

#****Begin: Generated Statements***
#****End: Generated Statements****


# _______________________________________________________________________________
# 3.0 Start Data
# _______________________________________________________________________________





# _______________________________________________________________________________
# 3.9 End Data
# _______________________________________________________________________________












575,17

#****Begin: Generated Statements***
#****End: Generated Statements****



# _______________________________________________________________________________
# 4.0 Start Epilog
# _______________________________________________________________________________




# _______________________________________________________________________________
# 4.9 End Epilog
# _______________________________________________________________________________

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
