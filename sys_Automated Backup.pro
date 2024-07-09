601,100
602,"sys_Automated Backup"
562,"NULL"
586,
585,
564,
565,"cSHaC]iaznGQDM00c5MCnZlY0G5CW1^yIO=nVEN7wxCK01T^`O<M]YwFZB;BN75@CT9MK^ZDs8Vr:BYbu1C`L?R5kq_d>q\aZI`x[xi6yxW0hl^AFDW_9dbuocVu5hBd0g\8>uDrO;BV8Feez8Dz45fKvM?ZtC4Qt9sZF^;u=VXyzCYDrQNY:Mhfv>>oR\:3i?ki>GEi"
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
pnForce
561,1
1
590,1
pnForce,1
637,1
pnForce,"Force?"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,81

#****Begin: Generated Statements***
#****End: Generated Statements****

#*********************************************************************************************************************
#**** PROCESS:              sys_Automated Backup
#**** DESCRIPTION:       This process does a SaveDataAll, and then calls  a batch file which uses
#****                                  7-zip command line to create a backup of the database directory.
#****                                  This process is designed to only run on weekdays unless the parameter
#****                                  pnForce is set to 1
#****
#**** AUTHOR:                Malcolm MacDonnell (Excelerated Consulting)
#****
#**** MODIFICATION HISTORY:
#****
#****  Date               Initials        Comments
#****  ====              ======      =========
#**** 06/06/2013      MJM        Initial Revision
#****
#***********************************************************************************************************************


#-------------------------------------------------
#    CUBES
#-------------------------------------------------
cbVar = 'sys_Variable';

#-------------------------------------------------
#    OTHER VARIABLES
#-------------------------------------------------
# Make sure it's a weekday
nDay = MOD (DayNo (TimSt (Now, '\Y-\m-\d')), 7);

IF (nDay =1 % nDay = 2);
#--- This is a Saturday or Sunday so don't backup unless forced to
      IF (pnForce = 0);
            PROCESSQUIT;
      ENDIF;
ENDIF;

DataSourceAsciiThousandSeparator = '';

#-------------------------------------------------
#    SAVE DATA TO DISK
#-------------------------------------------------
SAVEDATAALL;

#-------------------------------------------------
#    Create the Timestamp
#-------------------------------------------------
#sTimeStamp = TimSt (Now, '\Y\m\d \h\i');
sTimeStamp = TimSt (Now, '\Y\m\d');
nYear = Numbr (TimSt (Now, '\Y'));
nMonth = Numbr (TimSt (Now, '\m'));

# Build the FinYear for the path
If (nMonth >= 7);
       nYear2 = MOD (nYear + 1, 100);
Else;
       nYear = nYear -1;
       nYear2 = MOD (nYear + 1, 100);
EndIf;

sFinYear = TRIM (STR (nYear, 4, 0)) | '-' | TRIM (STR (nYear2, 4, 0));

#-------------------------------------------------
#    Create the filenames
#-------------------------------------------------
sSourceDir = CELLGETS(cbVar, 'sys_Database Directory', 'sValue');
sBackupFile = sTimestamp | '.zip';

# Build the command line

sCmd = '"' | sSourceDir | 'TM1Backup.bat" "' | sBackupFile | '"';
#ASCIIOUTPUT ('checkcmd.txt', sCmd, sSourceDir, sBackUpFile);

#-------------------------------------------------
#    Run the batch file
#-------------------------------------------------
EXECUTECOMMAND (sCmd, 0);

573,3

#****Begin: Generated Statements***
#****End: Generated Statements****
574,3

#****Begin: Generated Statements***
#****End: Generated Statements****
575,3

#****Begin: Generated Statements***
#****End: Generated Statements****
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
