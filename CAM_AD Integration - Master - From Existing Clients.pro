601,100
602,"CAM_AD Integration - Master - From Existing Clients"
562,"NULL"
586,
585,
564,
565,"d=WhaXb=[;vE]:?5VW]G^HMtqo8o3JTOY6CuyhnTvlZZ6XZ[7B=9S[:D2=AfkJ@mNbCZ0=m\tG=k_w]\RLVEof?:66>?:mfMCeKFzez4T^xVWm:J2ZZ:M]0UDsh8i8[E\n5WfeQITwU7JqPIf9>Uz1sHADbxSnYwd]0C:jD[oIOp90r[ZD4JI5YU;IDOF1BC<JO=<WoN"
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
560,2
pContinue
pPrelimSetup
561,2
2
2
590,2
pContinue,"Yes"
pPrelimSetup,"No"
637,2
pContinue,"Select 'Yes' to run process"
pPrelimSetup,"Type 'Yes' for the first run to setup cubes and dimensions or 'No' for subsequent runs to copy clients"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,216

#****Begin: Generated Statements***
#****End: Generated Statements****

# Process Name: CAM_AD Integration - Master - From Existing Clients
#_______________________________________________________________________________

# _______________________________________________________________________________
# 1.0 Start Prolog
# _______________________________________________________________________________

# _______________________________________________________________________________
# Purpose:          This process will loop through the }clients dimension and if the 
#                   user is non-CAM, create an equivalent CAM user. It will also 
#                   replicate their security group access
#
# Prerequisites:    Must be run on Windows Server with PowerShell and AD commandlets available
#
# Developer:        Excelerated | Andrew Craig | 22 Dec 2020
#
# Update Log:       AC | 23 Dec 2020 | Add logic to create message log cube
#                   AC | 08 Jan 2020 | Add prompt re: requirement to run process
#                   AC | 02 Feb 2020 | Add parameter to distinguish between prelim setup and main run
#                   AC | 02 Feb 2021 | Add functionality to copy private views and subsets
# _______________________________________________________________________________



# Parameters
# _______________________________________________________________________________

# pContinue | String | Select 'Yes' to run process
# pPrelimSetup | String | Type 'Yes' for the first run to setup cubes and dimensions or 'No' for subsequent runs to copy clients



# Variables
# _______________________________________________________________________________

# Nil



# 1.1 Initilisation
# _______________________________________________________________________________

If( pContinue @<> 'Yes');
    ProcessQuit;
EndIf;

cProcessName = GetProcessName();
cProcessTime = TIMST ( NOW , '\y\m\d\h\i\s');
cProcessReference = 'Integration' | '_' | cProcessTime;

sClientCreateProcess = 'CAM_AD Integration - Create Client';
sSecurityGroupProcess = 'CAM_AD Integration - Copy Security Groups';

sClientDim = '}Clients';
sClientAttrDim = '}ElementAttributes_}Clients';
sCamTrackingAttrName = 'Non_CAM_ID';

sMessageCube = 'CAM_AD Integration';
sMessageDim1 = 'CAM_AD Items';
sMessageDim1_Parent = 'All CAM_AD Items';
sMessageDim2 = 'CAM_AD Integration Measure';
sMessageDim2Element = 'Message';

sType = 'User';
sFilePath = 'zImport\';
sCamNamespace = 'CAM_AD';
nTempObject = 1;



# 1.2 Create temporary folder
# _______________________________________________________________________________

If(  pPrelimSetup @= 'No' );

    sCreateFolderCommand = 'cmd /c "md ' | sFilePath | '"';
    ExecuteCommand ( sCreateFolderCommand, 1);

EndIf;



# 1.3 One off setup
# _______________________________________________________________________________

If( pPrelimSetup @= 'Yes' );

    # Create attribute

    If( DimIx( sClientAttrDim, sCamTrackingAttrName ) = 0 );
        AttrInsert( sClientDim, '', sCamTrackingAttrName, 'S' );
    EndIf;


    # Create tracking cube

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


EndIf;



If( pPrelimSetup @= 'No' );

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



    # 1.5 Loop through client groups and execute create client process
    # _______________________________________________________________________________

    sDim = sClientDim;

    nDimSize = DimSiz( sDim );
    i = nDimSize;
    nCount = 1;

    While( i > 0 );

        sElement = DimNm( sDim , i );
        
        If( SubSt( sElement, 1, 5 ) @<> 'CAMID' );

            If( sElement @<> 'Admin');

                sCount = NumberToString( nCount );

                ExecuteProcess( sClientCreateProcess, 'pType', sType, 'pLookup', sElement, 'pFilePath', sFilePath, 'pCamNamespace', sCamNamespace, 'pCount', sCount, 'pCopyPrivateViews', 'Yes' );

                nCount = nCount + 1;

            EndIf;

        EndIf;

        i = i-1;

    End;

EndIf;



# _______________________________________________________________________________
# 1.9 End Prolog
# _______________________________________________________________________________













573,3

#****Begin: Generated Statements***
#****End: Generated Statements****
574,3

#****Begin: Generated Statements***
#****End: Generated Statements****
575,52

#****Begin: Generated Statements***
#****End: Generated Statements****









# _______________________________________________________________________________
# 4.0 Start Epilog
# _______________________________________________________________________________

If( pPrelimSetup @= 'No' );

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
