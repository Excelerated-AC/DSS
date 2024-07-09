601,100
602,"CAM_AD Integration - Delete User"
562,"NULL"
586,
585,
564,
565,"uE]9VOGPWb2mhdd[YJ^KWaph_=CDbJG^N91fpF1NrHoB@U67SJPu^RrJK<QBpRcglGt13;d]Uk>wh?pOv1R8ORu00Gl_qGyXgI]cMxpsNQM:fr8[fN@Vp<faQUYvI>TmaTeg:1?_GVf=a<;\73kww<V\kuWQjWzs>PU7Ib\jf]Y:5OBAAqB_KncO<^YW95Hq@G27zyW<"
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
pClient
pCount
561,2
2
2
590,2
pClient,"John Smith"
pCount,"1"
637,2
pClient,"Client to be removed - must be a valid member of '}Clients'"
pCount,"Count information for logging purposes - only required when running under automated conditions, otherwise use 1"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,131

#****Begin: Generated Statements***
#****End: Generated Statements****



# Process Name: CAM_AD Integration - Delete User
#_______________________________________________________________________________

# _______________________________________________________________________________
# 1.0 Start Prolog
# _______________________________________________________________________________

# _______________________________________________________________________________
# Purpose:          This process will delete individual users.
#
# Workflow:         Run from PAW - uses subnm client list for validation.
#
# Developer:        Excelerated | Andrew Craig | 08 Jan 2021
#
# Update Log:         
#                   AC | 15 Feb 2021 | Update to take source information in alias form if required
# _______________________________________________________________________________


# 1.1 Parameters
# _______________________________________________________________________________

# pClient | String | Client to be removed - must be a valid member of '}Clients'
# pCount | String | Count information for logging purposes - only required when running under automated conditions, otherwise use 1




# 1.2 Initialise
# _______________________________________________________________________________

cProcessName = GetProcessName();
cProcessTime = TIMST ( NOW , '\y\m\d\h\i\s');
cProcessReference = 'Integration' | '_' | cProcessTime;

sClientsDim = '}Clients';
sClientToRemove = pClient;
sCount = pCount;

sMessageCube = 'CAM_AD Integration';
sMessageDim1 = 'CAM_AD Items';
sMessageDim1_Parent = 'All CAM_AD Items';
sMessageDim2 = 'CAM_AD Integration Measure';
sMessageDim2Element = 'Message';

nTempObject = 1;
nErrorCount = 0;




# 1.3 Clear out message log cube for first record
# _______________________________________________________________________________

If( sCount @= '1');

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

EndIf;


# 1.4 Remove client
# _______________________________________________________________________________

# Check client exists

If( DimIx( sClientsDim, sClientToRemove ) = 0 );

    #If not, error out
    nErrorCount = nErrorCount + 1;
    sErrorMessage = sClientToRemove |' not found in clients dimension' ;

Else;

    # Remove client
    sClienttoRemoveIndex = DimIx( sClientsDim, sClientToRemove );
    sClienttoRemoveID = DimNm( sClientsDim, sClienttoRemoveIndex );

    DeleteClient( sClienttoRemoveID );

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
575,35

#****Begin: Generated Statements***
#****End: Generated Statements****





# _______________________________________________________________________________
# 4.0 Start Epilog
# _______________________________________________________________________________


# 4.1 Log Outcome
# _______________________________________________________________________________

If( nErrorCount = 0 );

    sSuccessMessage = sClientToRemove | ' successfully removed';
    CellPutS( sSuccessMessage, sMessageCube, sCount, sMessageDim2Element );

Else;

    CellPutS( sErrorMessage, sMessageCube, sCount, sMessageDim2Element );

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
