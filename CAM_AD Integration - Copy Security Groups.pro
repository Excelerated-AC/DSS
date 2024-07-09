601,100
602,"CAM_AD Integration - Copy Security Groups"
562,"NULL"
586,
585,
564,
565,"xanlvs;[rtRv[fPjo1tmMY=4a:ELSKeDo`W38@?YF3geY`uoMZeP3cmnhBZe6mu146EUiaJb9IprIa7E44XED11@50K6=nC:_w@3Xz3ib;yCk1tZ^0wVSJtrp?sh8ovUOU9sOYHnqG@QL6=@=pwNATCEgj:<k`4OfD=9GS:AP33mAMRXJ2=Xqx_DBTX1U68kb>gZP2<p"
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
572,100

#****Begin: Generated Statements***
#****End: Generated Statements****

# Process Name: CAM_AD Integration - Copy Security Groups
#_______________________________________________________________________________

# _______________________________________________________________________________
# 1.0 Start Prolog
# _______________________________________________________________________________

# _______________________________________________________________________________
# Purpose:          This process will copy security group access from previous non-CAM 
#                   clients into the new CAM clients 
#
# Prerequisites:    Must be run on Windows Server with PowerShell and AD commandlets available
#
# Developer:        Excelerated | Andrew Craig | 18 Dec 2020
#
# Update Log:       AC | 22 Dec 2020 | Update file name
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
sSecurityDim = '}Groups';
sTrackingAlias = 'Non_CAM_ID';
sClientGroupsCube = '}ClientGroups';



# 1.2 Loop through client groups and if the client has an attr showing copied 
# from non-CAM client, copy security groups
# _______________________________________________________________________________

# Loop through client group

nClientDimSize = DimSiz( sClientDim );
i = nClientDimSize;

While( i > 0 );

    sClientElement = DimNm( sClientDim , i );
    
    If( AttrS( sClientDim, sClientElement, sTrackingAlias ) @<> '');

        sPreviousID = AttrS( sClientDim, sClientElement, sTrackingAlias );

        # Loop through security groups

        nSecurityDimSize = DimSiz( sSecurityDim );
        x = nSecurityDimSize;

        While( x > 0);

            sSecurityElement = DimNm( sSecurityDim, x);

            sGroup = CellGetS( sClientGroupsCube, sPreviousID, sSecurityElement );

            CellPutS(sGroup, sClientGroupsCube, sClientElement, sSecurityElement );

            x = x-1;

        End;
        
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
575,16

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
