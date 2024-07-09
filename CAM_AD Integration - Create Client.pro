601,100
602,"CAM_AD Integration - Create Client"
562,"CHARACTERDELIMITED"
586,"\\PRDAPP433VS\tm1_common_strategic_finance\CSD_TM1\Test\test.csv"
585,"\\PRDAPP433VS\tm1_common_strategic_finance\CSD_TM1\Test\test.csv"
564,
565,"cT8a?x8_kgX2@vnY]URnf6LutH=mjf98JTGQBlW@wnlHKQp0dtV7<f;q7J7]Mv`4:?I=j8rEhT=<EboD7\3u=Sz@\nZdHaB<M<C]XxW4BP:MkFg8gU[2Hx9KEB@eW>t:^EO`qcyAWYAP<J5uBI71NxS;ISe:C75s87liNFYSefSRH^5sxOw1dPVOzgt7_ckWXh<xTZ9o"
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
560,8
pType
pLookup
pDomain
pFilePath
pCamNamespace
pFileName
pCount
pCopyPrivateViews
561,8
2
2
2
2
2
2
2
2
590,8
pType,"user"
pLookup,"John Smith"
pDomain,""
pFilePath,"zImport\"
pCamNamespace,"CAM_AD"
pFileName,""
pCount,""
pCopyPrivateViews,""
637,8
pType,"Can be either 'user' for single user or 'group' for AD group"
pLookup,"User ID or Group Name to extract from AD"
pDomain,"Optional: Restrict search to a single domain, eg. ecdmz.local, only available if pType = 'user'"
pFilePath,"File path to send temporary user list to eg - \\tm1-Report\TM1_Common_Shared_Services_FS\Shared_Services_FS\zImport\ or 'zImport\'"
pCamNamespace,"Namespace for production of CAM ID (either AD or an underlying domain) or 'CAM_AD'"
pFileName,"Only required if using a manually created file - under normal use leave blank - eg - sample2.csv"
pCount,"ount information for logging purposes - only required when running under automated conditions"
pCopyPrivateViews,"If ""Yes"", will copy the user's private views and subsets from non-CAM user to CAM user, if ""No"" will not."
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
572,194

#****Begin: Generated Statements***
#****End: Generated Statements****

# Process Name: CAM_AD Integration - Create Client
#_______________________________________________________________________________

# _______________________________________________________________________________
# 1.0 Start Prolog
# _______________________________________________________________________________

# _______________________________________________________________________________
# Purpose:          This process will source user information from the active directory
#                   and utilise this to update the CAM client information in TM1. The 
#                   process may be run for an individual user, or for a group of users
#                   as dicteted by the parameter
#
# Prerequisites:    Must be run on Windows Server with PowerShell and AD commandlets available
#
# Developer:        Excelerated | Andrew Craig | 16 Sep 2020
#
# Update Log:       AC | 21 Sep 2020 |  Add system control functionality and remove parameters for 
#                                       better alignment with PAW
#                   AC | 01 Dec 2020 |  Update domain search logic
#                   AC | 17 Dec 2020 |  Update with parameterised logic
#                   AC | 18 Dec 2020 |  Update to provide tracking ID number
#                   AC | 22 Dec 2020 |  Add error logging
#                   AC | 23 Dec 2020 |  Add message logging functionality
#                   AC | 04 Jan 2021 |  Update error logging for missing file case
#                   AC | 02 Feb 2021 |  Add functionality to copy private views and subsets
#                   AC | 02 Feb 2021 |  Wait for file to be produced
#                   AC | 22 Feb 2021 |  Place user in "BMS - Write" security group (default group)
#                   AC | 22 Feb 2021 |  Run default client preferences management processes
#                   AC | 25 Feb 2021 |  Add apostrophe handling logic (1.2)
# _______________________________________________________________________________



# Parameters
# _______________________________________________________________________________

# pType | String | Can be either 'user' for single user or 'group' for AD group
# pLookup | String | User ID or Group Name to extract from AD
# pDomain | String | Optional: Restrict search to a single domain, eg. ecdmz.local, only available if pType = 'user'
# pFilePath | String | File path to send temporary user list to eg - \\tm1-Report\TM1_Common_Shared_Services_FS\Shared_Services_FS\zImport\ or 'zImport\'
# pCamNamespace | String | Namespace for production of CAM ID (either AD or an underlying domain) or 'CAM_AD'
# pFileName | String | Only required if using a manually created file - under normal use leave blank - eg - sample2.csv
# pCount | String | Count information for logging purposes - only required when running under automated conditions
# pCopyPrivateViews | String | If "Yes", will copy the user's private views and subsets from non-CAM user to CAM user, if "No" will not.


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
cProcessReference = 'Integration' | '_' | cProcessTime;

sSystemControlCube = 'System Control';
sFilePathPrefix = pFilePath;
sFileName = pFileName;
sTrackingAlias = 'Non_CAM_ID';
sPrivateViewCopyProcessName = 'CAM_AD Integration - Private View Maintenance - SubProcess';
sClientPreferencesManagementProcess = 'sys_Client Preferences Management';

If( sFileName @= '' );
    sFilePath = sFilePathPrefix | cProcessReference | '.csv';
Else;
    sFilePath = sFilePathPrefix | sFileName;
EndIf;

sLookup = pLookup;
sDomain = pDomain;
sCount = pCount;
sType = pType;
sCopyPrivateViews = pCopyPrivateViews;
sCamNamespace = pCamNamespace;
sCamPrefix = 'u';
sClientDim = '}Clients';
sSecurityGroupsDim = '}Groups';
sSecurityGroupDefault = 'BMS - Write';
sClientGroupsCube = '}ClientGroups';
sDisplayAliasName = '}TM1_DefaultDisplayValue';
sClientPropertiesCube = '}ClientProperties';
nRecordCount = 0;

sMessageCube = 'CAM_AD Integration';
sMesasgeDim1 = 'CAM_AD Items';
sMessageDim1_Parent = 'All CAM_AD Items';
sMesasgeDim2 = 'CAM_AD Integration Measure';
sMessageDim2Element = 'Message';





# 1.2 Execute PowerShell commands to produce flat file 
# _______________________________________________________________________________

# Handle Apostrophes

If( Scan( '''', sLookup ) > 0 );
    nApostrophePosition = Scan( '''', sLookup );
    sFirstHalfString = SubSt( sLookup, 1, nApostrophePosition - 1 );
    sSecondHalfString = SubSt( sLookup, nApostrophePosition + 1, Long(sLookup) );
    sApostropheInsertion = '''''';
    sParsedLookup = sFirstHalfString | sApostropheInsertion | sSecondHalfString;
    #Debug Only: logoutput( 'INFO', 'Parsed Lookup is ' | sParsedLookup);
Else;
    sParsedLookup = sLookup;
EndIf;


# Run Command

If( sType @= 'user' );
    If( sDomain @= ''  );
        sPowerShellCommand = Expand( 'cmd /c powershell -command "Get-ADUser ''"%sParsedLookup%"'' -Properties * | Select SamAccountName, Name, Objectguid, Email, userPrincipalName | Export-csv -Path ''%sFilePath%'' " ' ); 
    Else;
        sPowerShellCommand = Expand( 'cmd /c powershell -command "Get-ADUser ''%slookup%'' -Server ''%sDomain%'' -Properties * | Select SamAccountName, Name, Objectguid, Email, userPrincipalName | Export-csv -Path ''%sFilePath%'' " ' );
    EndIf;
ElseIf( sType @= 'group' );
    sPowerShellCommand = Expand( 'cmd /c powershell -command "Get-ADGroupMember -Identity ''%slookup%'' | ') | '%' | Expand( '{get-aduser $_.SamAccountName | select SamAccountName, Name, Objectguid, Email, userPrincipalName } | Export-csv -Path ''%sFilePath%'' " ' );
EndIf;

#Debug Only: Logoutput( 'INFO',  sPowerShellCommand );
ExecuteCommand ( sPowerShellCommand, 1);



# 1.3 Assign data source 
# _______________________________________________________________________________

Sleep( 2000 );

If( FileExists( sFilePath ) = 1);

    sFileAvailable                  = 'Yes';
    DataSourceType                  = 'CHARACTERDELIMITED';
    DatasourceNameForServer         = sFilePath;
    DatasourceNameForClient         = sFilePath;
    DatasourceASCIIHeaderRecords    = 1;
    DatasourceASCIIDelimiter        = ',';
    DatasourceASCIIQuoteCharacter   = '"';

Else;

    sErrorMessage = sLookup | ' not found in the active directory and therefore user not added. (File not produced)';
    CellPutS( sErrorMessage, sMessageCube, sCount, sMessageDim2Element );    
    sFileAvailable                  = 'No';

    ProcessBreak;

EndIf;


# _______________________________________________________________________________
# 1.9 End Prolog
# _______________________________________________________________________________
























573,37

#****Begin: Generated Statements***
#****End: Generated Statements****




# _______________________________________________________________________________
# 2.0 Start MetaData
# _______________________________________________________________________________


# 2.1 Create userID based on the objectguid field in AD and the CAM namespace
# _______________________________________________________________________________

If( sFileAvailable @= 'Yes');

    sID = SubSt( vObjectguid,7,2 ) | SubSt( vObjectguid,5,2 ) | SubSt( vObjectguid,3,2 ) | SubSt( vObjectguid,1,2 ) | SubSt( vObjectguid,12,2 ) | SubSt( vObjectguid,10,2 ) | SubSt( vObjectguid,17,2 ) | SubSt( vObjectguid,15,2 ) | SubSt( vObjectguid,20,4 ) | SubSt( vObjectguid,25,12 );
    sCAMID = 'CAMID("' | sCamNamespace | ':' | sCamPrefix | ':' | sID | '")';
    AddClient( sCAMID );

EndIf;



# _______________________________________________________________________________
# 2.9 End MetaData
# _______________________________________________________________________________









574,115

#****Begin: Generated Statements***
#****End: Generated Statements****











# _______________________________________________________________________________
# 3.0 Start Data
# _______________________________________________________________________________


If( sFileAvailable @= 'Yes');

    # 3.1 Build CAM ID as in MetaData
    # _______________________________________________________________________________

    sID = SubSt( vObjectguid,7,2 ) | SubSt( vObjectguid,5,2 ) | SubSt( vObjectguid,3,2 ) | SubSt( vObjectguid,1,2 ) | SubSt( vObjectguid,12,2 ) | SubSt( vObjectguid,10,2 ) | SubSt( vObjectguid,17,2 ) | SubSt( vObjectguid,15,2 ) | SubSt( vObjectguid,20,4 ) | SubSt( vObjectguid,25,12 );
    sCAMID = 'CAMID("' | sCamNamespace | ':' | sCamPrefix | ':' | sID | '")';



    # 3.2 Populate attributes and properties based on information sourced from AD
    # _______________________________________________________________________________

    sDefaultAlias = sCamNamespace | '/' | vName;
    AttrPutS( sDefaultAlias, sClientDim, sCAMID, sDisplayAliasName );

    sUniqueID = vUserPrincipalName;
    CellPutS( sUniqueID, sClientPropertiesCube, sCAMID, 'UniqueID' );



    # 3.3 Provide tracking ID
    # _______________________________________________________________________________

    AttrPutS( sLookup, sClientDim, sCAMID, sTrackingAlias );



    # 3.4 Logging
    # _______________________________________________________________________________

    nRecordCount = nRecordCount + 1;
    sSuccessMessage = sLookup | ' successfully added as CAM ID ' | sCAMID;
    CellPutS( sSuccessMessage, sMessageCube, sCount, sMessageDim2Element );



    # 3.5 Execute process to copy private views and subsets
    # _______________________________________________________________________________

    If( sCopyPrivateViews @= 'Yes' );
        ExecuteProcess( sPrivateViewCopyProcessName, 'pCamNamespace', sCamNamespace, 'pSourceUser', sLookup, 'pTargetUser', vName );
        LogOutput( 'Info', 'view copy subprocess executed - target user name was ' | vName  );
    EndIf;



    # 3.6 Place user in default security group
    # _______________________________________________________________________________

    If( Dimix( sSecurityGroupsDim, sSecurityGroupDefault ) > 0 );
        If( CellIsUpdateable( sClientGroupsCube, sCAMID, sSecurityGroupDefault) = 1 );
            CellPutS( sSecurityGroupDefault, sClientGroupsCube, sCAMID, sSecurityGroupDefault );
        EndIf;
    EndIf;



    # 3.7 Run default client preferences management processes if it exists
    # _______________________________________________________________________________

    If( Dimix( '}Processes', sClientPreferencesManagementProcess) > 0 );
        ExecuteProcess( sClientPreferencesManagementProcess );
    EndIf;

EndIf;






# _______________________________________________________________________________
# 3.9 End Data
# _______________________________________________________________________________





















575,32

#****Begin: Generated Statements***
#****End: Generated Statements****






# _______________________________________________________________________________
# 4.0 Start Epilog
# _______________________________________________________________________________

# 4.1 Error Logging
# _______________________________________________________________________________

If( sFileAvailable @= 'Yes');
    If( nRecordCount = 0 );
        sErrorMessage = sLookup | ' not found in the active directory and therefore user not added. (Record not available)';
        CellPutS( sErrorMessage, sMessageCube, sCount, sMessageDim2Element );    
    EndIf;
EndIf;






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
