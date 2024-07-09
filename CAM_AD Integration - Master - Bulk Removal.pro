601,100
602,"CAM_AD Integration - Master - Bulk Removal"
562,"NULL"
586,
585,
564,
565,"yZ>7m]J3@LmjtfX4Tr]pZuUsMaxMf?ViBJFr2=BE2fTjuC3F8Gs:7^A6ja39Krx_?NhP7;Olu[?TRgwiW\jO?HN99sWbTOK6?0]eFLJZB1ThlTYx5Wz50bE_K]lG3u]ULyEzk_DPOSz_tpKvJr^F^1rhh:M[4B04@3I[h1bswrzl]]kAwchgxE<gAIUPUKd@h<3UB>39"
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
560,0
561,0
590,0
637,0
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,126

#****Begin: Generated Statements***
#****End: Generated Statements****


# Process Name: CAM_AD Integration - Master - Bulk Removal
#_______________________________________________________________________________

# _______________________________________________________________________________
# 1.0 Start Prolog
# _______________________________________________________________________________

# _______________________________________________________________________________
# Purpose:          This process will loop through the }clients dimension and if the 
#                   user was created from a non-CAM account, delete the non-CAM account.
#
# Prerequisites:    Must be run on Windows Server with PowerShell and AD commandlets available
#
# Developer:        Excelerated | Andrew Craig | 08 Jan 2021
#
# Update Log:       
# _______________________________________________________________________________



# Parameters
# _______________________________________________________________________________

# Nil



# Variables
# _______________________________________________________________________________

# Nil



# 1.1 Initilisation
# _______________________________________________________________________________

cProcessName = GetProcessName();
cProcessTime = TIMST ( NOW , '\y\m\d\h\i\s');
cProcessReference = 'Integration' | '_' | cProcessTime;

sClientLoopSub = cProcessReference;
sClientRemoveProcess = 'CAM_AD Integration - Delete User';

sClientDim = '}Clients';
sClientAttrDim = '}ElementAttributes_}Clients';
sCamTrackingAttrName = 'Non_CAM_ID';

nTempObject = 1;


# 1.3 Create Temp Sub of all CAM IDs created with a linked tracking ID
# _______________________________________________________________________________

SubsetCreate( sClientDim, sClientLoopSub, nTempObject );

sDim = sClientDim;

nDimSize = DimSiz( sDim );
i = nDimSize;
nCount = 1;

While( i > 0 );

    sElement = DimNm( sDim , i );

    If( ATTRS( sDim, sElement, sCamTrackingAttrName ) @<> '' );
        SubsetElementInsert( sDim, sClientLoopSub, sElement, 1 );
    EndIf;

    i = i - 1;

End;



# 1.4 Loop through sub remove non-CAM clients
# _______________________________________________________________________________

sDim = sClientDim;

nSubSize = SubsetGetSize( sDim, sClientLoopSub );
i = nSubSize;
nCount = 1;

While( i > 0 );

    sElement = SubsetGetElementName( sDim, sClientLoopSub, i );
    
    sClientRemove = AttrS( sDim, sElement, sCamTrackingAttrName );

    sCount = NumberToString( nCount );

    ExecuteProcess( sClientRemoveProcess, 'pClient', sClientRemove, 'pCount', sCount );

    i = i - 1;

    nCount = nCount + 1;

End;






# _______________________________________________________________________________
# 1.9 End Prolog
# _______________________________________________________________________________












573,3

#****Begin: Generated Statements***
#****End: Generated Statements****
574,3

#****Begin: Generated Statements***
#****End: Generated Statements****
575,25

#****Begin: Generated Statements***
#****End: Generated Statements****




# _______________________________________________________________________________
# 4.0 Start Epilog
# _______________________________________________________________________________

# 4.1 Refresh Security
# _______________________________________________________________________________

SecurityRefresh;






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
