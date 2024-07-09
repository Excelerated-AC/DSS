601,100
602,"CAM_AD Integration - Build User List - SubProcess"
562,"CHARACTERDELIMITED"
586,"\\PRDAPP433VS\tm1_common_strategic_finance\Upload\sample.csv"
585,"\\PRDAPP433VS\tm1_common_strategic_finance\CSD_TM1\zImport\test.csv"
564,
565,"mb7Pt@Aiy6aZVa3heG;OAa=FfPh^`]SS=`MJgmc4Yx5Qka^zZg6lvyu1E=yI^;TvjqZIiE>N?\d7wZ?Zn4G01r380u2w6_SBBrj=JW_6yO[wcArSmZGPSU^uxl<sJLBU<GxSCDSc0=A>m5:7=3udioIQ@DG3mr[jq=P6A\KbNV=F\Cx?bu2r97;BcpIzhC]G[Rb3ayOX"
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
572,130

#****Begin: Generated Statements***
#****End: Generated Statements****




# Process Name: CAM_AD Integration - Build User List - SubProcess
#_______________________________________________________________________________

# _______________________________________________________________________________
# 1.0 Start Prolog
# _______________________________________________________________________________

# _______________________________________________________________________________
# Purpose:          This process will obtain a list of all users within a given domain
#                   from the active directory and use this to populate the "AD users"
#                   dimension.
#
# Prerequisites:    Must be run on Windows Server with PowerShell and AD commandlets available
#
# Developer:        Excelerated | Andrew Craig | 23 Sep 2020
#
# Update Log:       AC | 24 Sep 2020 |  Updated build user dim under parent - all users,  
#                                       sort dim in ascending alphabetical order, add AD group
#                                       restriction capability
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

sFilePathPrefix = pFilePath;
sSystemControlCube = 'System Control';
sFilePath = sFilePathPrefix | cProcessReference | '.csv';
sDomain = '';
sCamNamespace = pCamNamespace;
sADGroupRestriction = '';
sCamPrefix = 'u';
sADUsersDim = 'Active Directory Users';
sADUsersParent = 'All Users';



# 1.2 Sort AD Users dimension
# _______________________________________________________________________________

DimensionSortOrder( sADUsersDim, 'by name', 'Ascending', 'by name', 'Ascending' );



# 1.3 Execute PowerShell commands to produce flat file 
# _______________________________________________________________________________

# Ensure powershell is activated with relevant AD commandlets
sPowerShellCommand = 'powershell -command "import-module ActiveDirectory"';
ExecuteCommand ( sPowerShellCommand, 1);


# Export list of all users in the domain - no AD group restriction
If( sADGroupRestriction @= '');
    If( Scan( '.', sDomain ) = 0 );
        sPowerShellCommand = Expand( 'powershell -command "Get-ADUser -Filter * -Properties * | Select SamAccountName, Name, Objectguid, Email, userPrincipalName | Export-csv -Path ''%sFilePath%'' " ' ); 
    Else;
        sPowerShellCommand = Expand( 'powershell -command "Get-ADUser -Filter * -Server ''%sDomain%'' -Properties * | Select SamAccountName, Name, Objectguid, Email, userPrincipalName | Export-csv -Path ''%sFilePath%'' " ' );
    EndIf;
Else;

# Export list of all users in the domain - apply AD group restriction
    If( Scan( '.', sDomain ) = 0 );
        sPowerShellCommand = Expand( 'powershell -command "Get-ADGroupMember -Identity ''%sADGroupRestriction%'' | ') | '%' | Expand( '{get-aduser $_.SamAccountName | select SamAccountName, Name, Objectguid, Email, userPrincipalName } | Export-csv -Path ''%sFilePath%'' " ' );
    Else;
        sPowerShellCommand = Expand( 'powershell -command "Get-ADGroupMember -Identity ''%sADGroupRestriction%'' -Server ''%sDomain%'' | ') | '%' | Expand( '{get-aduser $_.SamAccountName | select SamAccountName, Name, Objectguid, Email, userPrincipalName } | Export-csv -Path ''%sFilePath%'' " ' );
    EndIf;
EndIf;

ExecuteCommand ( sPowerShellCommand, 1);



# 1.4 Assign data source 
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











573,28

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




574,50

#****Begin: Generated Statements***
#****End: Generated Statements****


# _______________________________________________________________________________
# 3.0 Start Data
# _______________________________________________________________________________

# 3.1 Populate user dimension with attributes
# _______________________________________________________________________________

#CAM Identifier
sID = SubSt( vObjectguid,7,2 ) | SubSt( vObjectguid,5,2 ) | SubSt( vObjectguid,3,2 ) | SubSt( vObjectguid,1,2 ) | SubSt( vObjectguid,12,2 ) | SubSt( vObjectguid,10,2 ) | SubSt( vObjectguid,17,2 ) | SubSt( vObjectguid,15,2 ) | SubSt( vObjectguid,20,4 ) | SubSt( vObjectguid,25,12 );
sCAMID = 'CAMID("' | sCamNamespace | ':' | sCamPrefix | ':' | sID | '")';
AttrPutS( sCAMID, sADUsersDim, vSamAccountName, 'CAM Identifier' );

#Email
AttrPutS( vEmail, sADUsersDim, vSamAccountName, 'Email' );

#Full Name
AttrPutS( vName, sADUsersDim, vSamAccountName, 'Full Name' );

#CAM Name
sCAMName = sCamNamespace | '/' | vName;
AttrPutS( sCAMName, sADUsersDim, vSamAccountName, 'CAM Name' );

#Unique ID
AttrPutS( vUserPrincipalName, sADUsersDim, vSamAccountName, 'Unique ID' );



# _______________________________________________________________________________
# 3.9 End Data
# _______________________________________________________________________________















575,18

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
