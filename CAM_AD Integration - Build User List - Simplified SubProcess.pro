601,100
602,"CAM_AD Integration - Build User List - Simplified SubProcess"
562,"CHARACTERDELIMITED"
586,"\\PRDAPP433VS\tm1_common_strategic_finance\Upload\sample.csv"
585,"\\PRDAPP433VS\tm1_common_strategic_finance\CSD_TM1\zImport\test.csv"
564,
565,"lKiK[_D3kGJyaW7De4mc>8fA7tg@EH4SCLGpOqc8VSt]hH89YXWX=B7i4rYe7:x7k=J:9QXsH1QLJ;_[xiBw?RXnzfR];XkwKtx<L^?dP48VW:f[;]An6S5jL_qb[wEYMa7kKFowipsRXW=`^2RUa=cJFJ>l4^m[Ka\`c_;p<q6B2n@]Zr6btt1G4sFIambwRgjl<mS="
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
560,2
pFilePath
pCamNamespace
561,2
2
2
590,2
pFilePath,"zImport\"
pCamNamespace,"CAM_AD"
637,2
pFilePath,"File path to send temporary user list to eg - \\tm1-Report\TM1_Common_Shared_Services_FS\Shared_Services_FS\zImport\ or 'zImport\'"
pCamNamespace,"Namespace for production of CAM ID (either AD or an underlying domain) or 'CAM_AD'"
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
572,121

#****Begin: Generated Statements***
#****End: Generated Statements****






# Process Name: CAM_AD Integration - Build User List - Simplified SubProcess
#_______________________________________________________________________________

# _______________________________________________________________________________
# 1.0 Start Prolog
# _______________________________________________________________________________

# _______________________________________________________________________________
# Purpose:          This process will obtain a list of all users within 
#                   the active directory to provide the drop-down picklist in the 
#                   PAW security workbook.
#
# Prerequisites:    Must be run on Windows Server with PowerShell and AD commandlets available
#
# Developer:        Excelerated | Andrew Craig | 22 Feb 2021
# 
# Update Log:       AC | 24 Feb 2021 | Add wait time before file is accessed
#                   AC | 01 Mar 2021 | Add stronger error handling for locked files
#                   AC | 01 Mar 2021 | Move PowerShell commands from sub to master process
#                   AC | 02 Mar 2021 | Move deletion commands from master to this sub-process to ensure
#                                      only triggered when file is available
# _______________________________________________________________________________



# Parameters
# _______________________________________________________________________________

# pFilePath | String | File path to send temporary user list to eg - \\tm1-Report\TM1_Common_Shared_Services_FS\Shared_Services_FS\zImport\ or 'zImport\'
# pCamNamespace | String | Namespace for production of CAM ID (either AD or an underlying domain) or 'CAM_AD'



# Variables
# _______________________________________________________________________________

# vSamAccountName (string)
# vName (string)
# vObjectguid (string)
# vEmail (string)
# vUserPrincipalName (string)



# 1.1 Initilisation
# _______________________________________________________________________________

cProcessName = GetProcessName();
cProcessTime = TIMST ( NOW , '\y\m\d\h\i\s');
cProcessReference = cProcessName | '_' | cProcessTime;

sSystemControlCube = 'System Control';
sFilePath = pFilePath;
sDomain = '';
sCamNamespace = pCamNamespace;
sADGroupRestriction = '';
sCamPrefix = 'u';
sADUsersDim = 'CAM_AD All AD Accounts';
sADUsersParent = 'All Users';



# 1.2 Clear dimension
# _______________________________________________________________________________

DimensionDeleteAllElements( sADUsersDim );



# 1.3 Add parent direct
# _______________________________________________________________________________

DimensionElementInsertDirect( sADUsersDim, '', sADUsersParent, 'C' );



# 1.4 Sort AD Users dimension
# _______________________________________________________________________________

DimensionSortOrder( sADUsersDim, 'by name', 'Ascending', 'by name', 'Ascending' );



# 1.5 Assign data source 
# _______________________________________________________________________________

DataSourceType                  = 'CHARACTERDELIMITED';
DatasourceNameForServer         = sFilePath;
DatasourceNameForClient         = sFilePath;
DatasourceASCIIHeaderRecords    = 2;
DatasourceASCIIDelimiter        = ',';
DatasourceASCIIQuoteCharacter   = '"';



# _______________________________________________________________________________
# 1.9 End Prolog
# _______________________________________________________________________________














573,27

#****Begin: Generated Statements***
#****End: Generated Statements****




# _______________________________________________________________________________
# 2.0 Start MetaData
# _______________________________________________________________________________


# 2.1 Populate dimension with user name
# _______________________________________________________________________________

DimensionElementInsert( sADUsersDim, '', vSamAccountName, 'N' );
DimensionElementComponentAdd( sADUsersDim, sADUsersParent , vSamAccountName, 1 );





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
