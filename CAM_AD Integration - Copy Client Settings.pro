601,100
602,"CAM_AD Integration - Copy Client Settings"
562,"NULL"
586,
585,
564,
565,"voLg@JMebx?ny1:ja_TwZta7<e[Xd`c8bE<R>1kV6c_21<__7xQtp2nZ@Ef4qnp?atzO0Ljz1vL`Uj9wuGQlypMV>GYs=l?Sm_5KkgHWpyDEY6xXPxF^FliDAEe_Iru45vdDHjertH<@kihE;4Hlcvo>SBCSo6JZ6kyPI]E63o?p>r>_QRT4^\HEy[N_0s6kRTWPYx\>"
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

# Process Name: CAM_AD Integration - Copy Client Settings
#_______________________________________________________________________________

# _______________________________________________________________________________
# 1.0 Start Prolog
# _______________________________________________________________________________

# _______________________________________________________________________________
# Purpose:          This process will copy client settings from previous non-CAM 
#                   clients into the new CAM clients 
#
# Prerequisites:    New clients must be utilising the Non_CAM_ID attr
#
# Developer:        Excelerated | Andrew Craig | 15 Feb 2021
#
# Update Log:       AC | 15 Feb 2021 | Add error handling for missing clients
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
sClientSettingsDim = '}ClientSettings';
sTrackingAlias = 'Non_CAM_ID';
sClientSettingsCube = '}ClientSettings';



# 1.2 Loop through clients and if the client has an attr showing copied 
# from non-CAM client, copy client settings
# _______________________________________________________________________________

# A. Loop through client dim

nClientDimSize = DimSiz( sClientDim );
i = nClientDimSize;

While( i > 0 );

    sClientElement = DimNm( sClientDim , i );
    
    If( AttrS( sClientDim, sClientElement, sTrackingAlias ) @<> '');

        sPreviousID = AttrS( sClientDim, sClientElement, sTrackingAlias );

        If( DimIx( sClientDim, sPreviousID ) > 0 );

            # B. Loop through client settings

            nSecondDimSize = DimSiz( sClientSettingsDim );
            x = nSecondDimSize;

            While( x > 0);

                sElement = DimNm( sClientSettingsDim, x);

                sSetting = CellGetS( sClientSettingsCube, sPreviousID, sElement );

                If( CellIsUpdateable( sClientSettingsCube, sClientElement, sElement ) = 1 );

                    CellPutS(sSetting, sClientSettingsCube, sClientElement, sElement );
                
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
