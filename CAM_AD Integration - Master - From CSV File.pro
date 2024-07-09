601,100
602,"CAM_AD Integration - Master - From CSV File"
562,"CHARACTERDELIMITED"
586,"\\tm1-Report\TM1_Common_Shared_Services_FS\Shared_Services_FS\zSource\Names.csv"
585,"\\tm1-Report\TM1_Common_Shared_Services_FS\Shared_Services_FS\zSource\Names.csv"
564,
565,"f<ap3]a<4nXAIrDY3VDPM`@jIqxmB6hb3OsU4K\jCWVmMzCpr=9LPowMzEwb@e0IGK<lCAVFzvocf]>bW7[DPPM3iUQN^7Wv=UwHfnx:x0KFCF0QQD9xhhVThL9m?gW2vMKs2Q>4]1OjZpEN1S\K@@nT;OxcCh`_=?I1Fb::X\@dGxcNub6swV0Zo?KRJ^KIA5;FLBhH"
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
569,0
592,0
599,1000
560,1
pSourcePath
561,1
2
590,1
pSourcePath,"zSource\names.csv"
637,1
pSourcePath,"Full file path, for example 'zSource\names.csv'"
577,1
vSourceName
578,1
2
579,1
1
580,1
0
581,1
0
582,1
VarType=32ColType=827
603,0
572,194

#****Begin: Generated Statements***
#****End: Generated Statements****

# Process Name: CAM_AD Integration - Master - From CSV File
#_______________________________________________________________________________

# _______________________________________________________________________________
# 1.0 Start Prolog
# _______________________________________________________________________________

# _______________________________________________________________________________
# Purpose:          This process obtain user information from a flat file (CSV, one   
#                   column, first name space last name) and create an equivalent CAM
#                   user. It will also replicate their security group access if this 
#                   user exists as non-CAM
#
# Prerequisites:    Must be run on Windows Server with PowerShell and AD commandlets available
#
# Developer:        Excelerated | Andrew Craig | 22 Dec 2020
#
# Update Log:       AC | 22 Dec 2020 | Update to correct number of headers
#                   AC | 23 Dec 2020 | Add logic to create message log cube
# _______________________________________________________________________________

# Data Source
# _______________________________________________________________________________

# Flat File



# Parameters
# _______________________________________________________________________________

# pSourcePath (String) | zSource\names.csv | Full file path, for example 'zSource\names.csv'



# Variables
# _______________________________________________________________________________

# vSourceName (String)



# 1.1 Initilisation
# _______________________________________________________________________________

cProcessName = GetProcessName();
cProcessTime = TIMST ( NOW , '\y\m\d\h\i\s');
cProcessReference = 'Integration' | '_' | cProcessTime;

sClientCreateProcess = 'CAM_AD Integration - Create Client';
sSecurityGroupProcess = 'CAM_AD Integration - Copy Security Groups';

sClientDim = '}Clients';
sClientAttrDim = '}ElementAttributes_}Clients';
sCamTrackingAttrName = 'Non_CAM_ID';

sType = 'User';
sSourcePath = pSourcePath;
sFilePath = 'zImport\';
sCamNamespace = 'CAM_AD';
nTempObject = 1;

nCount = 1;



# 1.2 Create temporary folder
# _______________________________________________________________________________

sCreateFolderCommand = 'cmd /c "md ' | sFilePath | '"';
ExecuteCommand ( sCreateFolderCommand, 1);



# 1.3 One off setup
# _______________________________________________________________________________

# Create attribute

If( DimIx( sClientAttrDim, sCamTrackingAttrName ) = 0 );
    AttrInsert( sClientDim, '', sCamTrackingAttrName, 'S' );
EndIf;


# Create tracking cube

sMessageCube = 'CAM_AD Integration';
sMessageDim1 = 'CAM_AD Items';
sMessageDim1_Parent = 'All CAM_AD Items';
sMessageDim2 = 'CAM_AD Integration Measure';
sMessageDim2Element = 'Message';


If( DimensionExists( sMessageDim1 )=0 );
    DimensionCreate( sMessageDim1);
    DimensionElementInsert( sMessageDim1, '', sMessageDim1_Parent, 'C' );
    i = 1;
    While( i < 500 );
        sMessageElement = NumberToString( i );
        DimensionElementInsertDirect( sMessageDim1, '', sMessageElement, 'N' );
        DimensionElementComponentAddDirect( sMessageDim1, sMessageDim1_Parent, sMessageElement, 1 );
        i = i+1;
    End;
EndIf;

If( DimensionExists( sMessageDim2 )=0 );
    DimensionCreate( sMessageDim2 );
    DimensionElementInsertDirect( sMessageDim2, '', sMessageDim2Element, 'S' );
EndIf;

If( CubeExists( sMessageCube )=0 );
    CubeCreate( sMessageCube , sMessageDim1, sMessageDim2 );
EndIf;




# 1.4 Clear out message log cube
# _______________________________________________________________________________

sClearViewName = cProcessReference | '_Clear';
sClearSubName = sClearViewName;

# Create View
If( ViewExists( sMessageCube, sClearViewName ) = 0);
    ViewCreate( sMessageCube, sClearViewName , 1);
EndIf;

# Dim 1. 
sDim = sMessageDim1;
If( SubsetExists( sDim, sClearSubName) = 0);
    SubsetCreate( sDim, sClearSubName, nTempObject);
EndIf;
SubsetIsAllSet( sDim, sClearSubName, 1 );
ViewSubsetAssign( sMessageCube, sClearViewName, sDim, sClearSubName); 

# Dim 2. 
sDim = sMessageDim2;
If( SubsetExists( sDim, sClearSubName) = 0);
    SubsetCreate( sDim, sClearSubName, nTempObject);
EndIf;
SubsetIsAllSet( sDim, sClearSubName, 1 );
ViewSubsetAssign( sMessageCube, sClearViewName, sDim, sClearSubName); 

# View Parameters
ViewExtractSkipCalcsSet(sMessageCube, sClearViewName, 1);
ViewExtractSkipRuleValuesSet(sMessageCube, sClearViewName, 1);
ViewExtractSkipZeroesSet(sMessageCube, sClearViewName, 1);

# Clear Target View 
ViewZeroOut( sMessageCube, sClearViewName);



# 1.5 Assign data source 
# _______________________________________________________________________________

DataSourceType                  = 'CHARACTERDELIMITED';
DatasourceNameForServer         = sSourcePath;
DatasourceNameForClient         = sSourcePath;
DatasourceASCIIHeaderRecords    = 0;
DatasourceASCIIDelimiter        = ',';
DatasourceASCIIQuoteCharacter   = '"';






# _______________________________________________________________________________
# 1.9 End Prolog
# _______________________________________________________________________________


















573,23

#****Begin: Generated Statements***
#****End: Generated Statements****





# _______________________________________________________________________________
# 2.0 Start MetaData
# _______________________________________________________________________________





# _______________________________________________________________________________
# 2.9 End MetaData
# _______________________________________________________________________________




574,30

#****Begin: Generated Statements***
#****End: Generated Statements****




# _______________________________________________________________________________
# 3.0 Start Data
# _______________________________________________________________________________

# 3.1 Loop through users and execute create client process
# _______________________________________________________________________________

sCount = NumberToString( nCount );

ExecuteProcess( sClientCreateProcess, 'pType', sType, 'pLookup', vSourceName, 'pFilePath', sFilePath, 'pCamNamespace', sCamNamespace, 'pCount', sCount );

nCount = nCount + 1;


# _______________________________________________________________________________
# 3.9 End Data
# _______________________________________________________________________________






575,48

#****Begin: Generated Statements***
#****End: Generated Statements****






# _______________________________________________________________________________
# 4.0 Start Epilog
# _______________________________________________________________________________

# 4.1 Mirror security groups from old clients to new clients
# _______________________________________________________________________________

ExecuteProcess( sSecurityGroupProcess );

SecurityRefresh;



# 4.2 Clean up temporary folder and files
# _______________________________________________________________________________

# Remove files

sCleanUpCommand = 'cmd /c powershell -command "Get-ChildItem -Path ' | sFilePath | ' -Include *.* -Recurse | foreach { $_.Delete()}"';

ExecuteCommand( sCleanUpCommand, 1 );



# Remove folder

sRemoveFolderCommand = 'cmd /c "rd /s /q ' | sFilePath | '"';

ExecuteCommand( sRemoveFolderCommand, 1 );






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
