601,100
602,"sys_Stop or Start a TM1 Database"
562,"NULL"
586,
585,
564,
565,"aa<]RdA3iUdgJtgMjtEXMV;OK@9saVw9[TZvQ^91mDs6mzRs`z3XGTb2N]up:t?FGvkqp`IRGhCbR9]BVYpst^_NuN>ZFO<RUBpV:\dDMEuJ];OK7>Bh:I4KK^_7[^]kRxVbcgVp:lxPNo:SdOq]O[HGq5`X72UKynH>f7<;A;EME@4iwm<21;okObcT90wWsn<yoeEf"
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
psServer
psFlag
561,2
2
2
590,2
psServer,"TAMS"
psFlag,"Start"
637,2
psServer,""
psFlag,""
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,20

#****Begin: Generated Statements***
#****End: Generated Statements****


#******************************************************************************************************************************************************************
#**** PROCESS:		sys_Stop or Start a TM1 Database
#****
#**** DESCRIPTION:	This process enables a TM1 service to be stopped or started
#****			
#**** AUTHOR:		Excelerated Consulting
#****
#**** MODIFICATION HISTORY:
#****
#**** Date	Initials	Comments
#**** ====	======	==========
#**** 02/10/2018	RJR	
#******************************************************************************************************************************************************************

# See Epilog
573,3

#****Begin: Generated Statements***
#****End: Generated Statements****
574,3

#****Begin: Generated Statements***
#****End: Generated Statements****
575,15

#****Begin: Generated Statements***
#****End: Generated Statements****


#---------------------------------------------------------------------
#    RUN COMMAND LINE
#---------------------------------------------------------------------
IF(psFlag @= 'Stop');
      sCmd = 'net stop ' | psServer;
ELSE;
      sCmd = 'net start ' | psServer;
ENDIF;

EXECUTECOMMAND (sCmd, 1);
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
