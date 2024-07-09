601,100
602,"CAM_AD Integration - Master - From Input"
562,"NULL"
586,
585,
564,
565,"p^?:tL1Hoz?N@O\caFyuxQRNtbutF1bp<lig^`El@p_ycJ<pvtY]5UqoL<6tD_^16D<fJo=O_<3kX^T9JSetpKCZ0nIdJ<LRO4sj^m_pGcvHRXp?TMnPNgDdk[T9==_By<2>Y[AulCBBCNA^sLG6wbZH8X0:E0m:yhH716sIMe56o\\^cik=IgukXLfg2[O]OQE[G`TW"
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
pType
pLookup
pDomain
561,3
2
2
2
590,3
pType,"user"
pLookup,"Belina Chan"
pDomain,""
637,3
pType,"Can be either 'user' for single user or 'group' for Acive Directory group"
pLookup,"Valid User ID or Group Name to extract from the Active Directory"
pDomain,"Optional: Restrict search to a single domain, only available if pType = 'user'"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,174

#****Begin: Generated Statements***
#****End: Generated Statements****

# Process Name: CAM_AD Integration - Master - From Input
#_______________________________________________________________________________

# _______________________________________________________________________________
# 1.0 Start Prolog
# _______________________________________________________________________________

# _______________________________________________________________________________
# Purpose:          This process will take trigger client add process based on input 
#                   from PAW workbook
#
# Prerequisites:    Must be run on Windows Server with PowerShell and AD commandlets available
#
# Developer:        Excelerated | Andrew Craig | 23 Dec 2020
#
# Update Log:       AC | 04 Jan 2021 | Remove bulk security group copy functionality 
# _______________________________________________________________________________


# Parameters
# _______________________________________________________________________________

# pType | String | Can be either 'user' for single user or 'group' for Acive Directory group
# pLookup | String | Valid User ID or Group Name to extract from the Active Directory
# pDomain | String | Optional: Restrict search to a single domain, only available if pType = 'user'


# Variables
# _______________________________________________________________________________

# Nil



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
sFilePath = 'zImport\';


nTempObject = 1;



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



# 1.5 Take parameters and execute create client process
# _______________________________________________________________________________

# Input based

sType = pType;
sLookup = pLookup;
sDomain = pDomain;

# Static

sCamNamespace = 'CAM_AD';
sCount = '1';

ExecuteProcess( sClientCreateProcess, 'pType', sType, 'pLookup', sLookup, 'pDomain', sDomain, 'pFilePath', sFilePath, 'pCamNamespace', sCamNamespace, 'pCount', sCount );







# _______________________________________________________________________________
# 1.9 End Prolog
# _______________________________________________________________________________




573,3

#****Begin: Generated Statements***
#****End: Generated Statements****
574,3

#****Begin: Generated Statements***
#****End: Generated Statements****
575,38

#****Begin: Generated Statements***
#****End: Generated Statements****








# _______________________________________________________________________________
# 4.0 Start Epilog
# _______________________________________________________________________________

# 4.1 Clean up temporary folder and files
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
