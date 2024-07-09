601,100
602,"CAM_AD Integration - Add Groups"
562,"NULL"
586,
585,
564,
565,"fPGwhdaKHgiQKc]Vf4:AjHSOT5o_IC>ir66t[ui:G^GCiy3mP>SMH]E^E1v3TegsTWht^m6Os]3:Vfv_>6q6qA1FMEumXRpa>xfBNy7;yAPmd^y:ilWVHshKMn`^I9hdfegDJ:24affi[A?C14yY^9WWP6<`KRPzCJ>enuqppmDxbq?OhuEPIwl@hHC\Y<RCc_0o^JTc"
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
560,1
psGroup
561,1
2
590,1
psGroup,"OIRWS"
637,1
psGroup,"Enter a Group name?"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,30

#****Begin: Generated Statements***
#****End: Generated Statements****

# Process Name: CAM_AD Integration - Add Groups
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
# Developer:        Excelerated | Khristian Gimena | 06 October 2021
#
# Update Log:       KG | DD MMM YYYY | narration
# _______________________________________________________________________________


dmGroups = '}Groups';

IF (DIMIX (dmGroups, psGroup) = 0);
	ADDGROUP (psGroup);
ELSE;
	PROCESSQUIT;
ENDIF;
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
