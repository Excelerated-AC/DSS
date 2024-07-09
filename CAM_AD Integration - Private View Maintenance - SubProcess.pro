601,100
602,"CAM_AD Integration - Private View Maintenance - SubProcess"
562,"NULL"
586,
585,
564,
565,"cWEaT94qMM=<Y9re;KWMVQccKdhIxNGdc2gKq[rLPVJTmqs65:d=R6gznll>_^jE]U7r?80HLZLhE2^CQG6La3>x<1s;>n==9e2Tp9bVhJ@KtgpFI7bJZGXb;]N3>6z_3nLoUoaS[c1^EcyAC8OJJdoO3po6I8mdIyE\7Cj1A<2Ur90fjI[>_D4x:\H1<h6P8ff30^Un"
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
pCamNamespace
pSourceUser
pTargetUser
561,3
2
2
2
590,3
pCamNamespace,""
pSourceUser,""
pTargetUser,""
637,3
pCamNamespace,"Namespace, user to create subfolder"
pSourceUser,"Source user ID"
pTargetUser,"Target user ID (used for folder - i.e. CAM alias, after the namespace)"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,121

#****Begin: Generated Statements***
#****End: Generated Statements****

# Process Name: CAM_AD Integration - Private View Maintenance - SubProcess
#_______________________________________________________________________________

# _______________________________________________________________________________
# 1.0 Start Prolog
# _______________________________________________________________________________

# _______________________________________________________________________________
# Purpose:          This process will copy private views and subsets from existing 
#                   users to new user 
#
# Prerequisites:    Must be run on Windows Server with Robocopy available
#
# Developer:        Excelerated | Andrew Craig | 02 Feb 2021
#
# Update Log:       
# _______________________________________________________________________________



# Parameters
# _______________________________________________________________________________

# pCamNamespace | String |  Namespace, user to create subfolder
# pSourceUser   | String |  Source user ID
# pTargetUser   | String |  Target user ID (used for folder - i.e. CAM alias, after the namespace)


# Variables
# _______________________________________________________________________________

# Nil



# 1.1 Initilisation
# _______________________________________________________________________________

cProcessName = GetProcessName();
cProcessTime = TIMST ( NOW , '\y\m\d\h\i\s');
cProcessReference = 'Integration' | '_' | cProcessTime;

sCamNamespace = pCamNamespace;
# sCamNamespace = 'CAM_AD';

sSourceUser = pSourceUser;
# sSourceUser = 'Admin';

sTargetUser  = pTargetUser;
# sTargetUser = 'Admin, Test';
nTargetUserCommaPosition = SCAN( ',', sTargetUser );
nTargetUserLength = LONG( sTargetUser );
sTargetUserFirstHalf = SUBST( sTargetUser, 1, nTargetUserCommaPosition - 1 );
sTargetUserSecondHalf = SUBST( sTargetUser, nTargetUserCommaPosition + 1, nTargetUserLength );
sTargetUserEscaped = sTargetUserFirstHalf | '","' | sTargetUserSecondHalf;



# 1.3 Create namespace folder if does not exist
# _______________________________________________________________________________

sCamSecurityFolder = sCamNamespace | '\';

If( FileExists( sCamSecurityFolder ) = 0);
    sCommand = 'cmd /c md "' | sCamSecurityFolder | '" ';
    ExecuteCommand( sCommand, 1);
    #LogOutput( 'Info', '1.3 - Passed command ' | sCommand );
EndIf;



# 1.4 Create subfolder if does not exist
# _______________________________________________________________________________

sCamSubFolderCheck = sCamSecurityFolder | sTargetUserEscaped | '\';
sCamSubFolderRobo = sCamSecurityFolder | sTargetUserEscaped;
sCamSubFolderNonRobo = sCamSecurityFolder | sTargetUser;

If( FileExists( sCamSubFolderCheck ) = 0);
    sCommand = 'cmd /c md "' | sCamSubFolderNonRobo | '" ';
    ExecuteCommand( sCommand, 1);
    LogOutput( 'Info', '1.4 - Passed command ' | sCommand );
EndIf;



# 1.5 Copy from source to target folder (if source folder exists)
# _______________________________________________________________________________

sSourceFolder = sSourceUser | '\';
sSourceFolderRobo = sSourceUser;


If( FileExists( sSourceUser ) = 1);
    sCommand = 'cmd /c  robocopy  "' | sSourceFolderRobo | '"  "' | sCamSubFolderRobo | '"  /e   ' ;
    ExecuteCommand( sCommand, 1);
    LogOutput( 'Info', '1.5 - Passed folder copy command: ' | sCommand );
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
575,23

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
