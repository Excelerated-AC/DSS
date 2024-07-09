601,100
602,"CAM_AD Integration - Copy Client Preferences"
562,"NULL"
586,
585,
564,
565,"cp9aSqtZNhm2qiq93t6kWIJ]aJSiHDQGjxpqL\AQ[eXmbL6^\\3VgGcQhmR[6S^SYYiSkNxyzL5RnSIsPd3q=8gSx1LlhVqGQbM6RsMA0Lt[n]zVe7wde_hYi4qk^v?vWC1=aZkq<\gciUY]1ULXogkm14oZSj=C2gP:8cPManOa=wUA7Pl`V0IFo1p67Ejhx7C:OT\^"
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
572,120

#****Begin: Generated Statements***
#****End: Generated Statements****

# Process Name: CAM_AD Integration - Copy Client Preferences
#_______________________________________________________________________________

# _______________________________________________________________________________
# 1.0 Start Prolog
# _______________________________________________________________________________

# _______________________________________________________________________________
# Purpose:          This process will copy client preferences from previous non-CAM 
#                   clients into the new CAM clients 
#
# Prerequisites:    New clients must be utilising the Non_CAM_ID attr
#
# Developer:        Excelerated | Andrew Craig | 15 Feb 2021
#
# Update Log:       AC | DD MMM YYYY | narration
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

sClientDim = '}Clients';
sClientPreferencesDim = 'Client Preferences Measure';
sTrackingAlias = 'Non_CAM_ID';
sClientPreferencesCube = 'Client Preferences';



# 1.2 Loop through clients and if the client has an attr showing copied 
# from non-CAM client, copy client preferences
# _______________________________________________________________________________

# A. Loop through client dim

nClientDimSize = DimSiz( sClientDim );
i = nClientDimSize;

While( i > 0 );

    sClientElement = DimNm( sClientDim , i );
    
    If( AttrS( sClientDim, sClientElement, sTrackingAlias ) @<> '');

        sPreviousID = AttrS( sClientDim, sClientElement, sTrackingAlias );

        If( DimIx( sClientDim, sPreviousID ) >0 );

            # B. Loop through client preferences

            nSecondDimSize = DimSiz( sClientPreferencesDim );
            x = nSecondDimSize;

            While( x > 0);

                sElement = DimNm( sClientPreferencesDim, x);

                If( DTYPE( sClientPreferencesDim, sElement ) @= 'N' );
                    nPreference = CellGetN( sClientPreferencesCube, sPreviousID, sElement );
                    If( CellIsUpdateable( sClientPreferencesCube, sClientElement, sElement ) = 1 );
                        CellPutN( nPreference, sClientPreferencesCube, sClientElement, sElement );
                    EndIf;
                EndIf;

                If( DTYPE( sClientPreferencesDim, sElement ) @= 'S' );
                    sPreference = CellGetS( sClientPreferencesCube, sPreviousID, sElement );
                    If( CellIsUpdateable( sClientPreferencesCube, sClientElement, sElement ) = 1 );
                        CellPutS( sPreference, sClientPreferencesCube, sClientElement, sElement );
                    EndIf;
                EndIf;            

                x = x-1;

            End;

        EndIf;

    EndIf;

    i = i-1;

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
