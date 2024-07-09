601,100
602,"flm_Update Menu"
562,"SUBSET"
586,"Lease Number"
585,"Lease Number"
564,
565,"pMDLcEjvHgqLuqFdaAaBO;NY>Jy@lxsqLlhi:??zx7<F:@wPpJhLbohVzu>i]s_PLUV`4tx;p`hSw_vzPTDgVI@1>TGy^Z]TMDMAcm:DE:Qc1>Z=1\0hv;GBI?=UeF2Yofr?pSs=kuZe[SW`c]TgUs>T:3aUk`i1[PF3;u2hfOq2Ng:4R_SQ8Rie6DkqsVGWJgTRJ<mG"
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
571,}Admin
569,0
592,0
599,1000
560,1
psLeaseNbr
561,1
2
590,1
psLeaseNbr,"All Lease Numbers"
637,1
psLeaseNbr,""
577,1
vsLeaseNbr
578,1
2
579,1
1
580,1
0
581,1
0
582,1
VarType=32ColType=827
603,0
572,81

#****Begin: Generated Statements***
#****End: Generated Statements****

#*********************************************************************************************************************
#**** PROCESS:               
#**** DESCRIPTION:       This process updates the Lease Menu cube
#****
#****
#**** MODIFICATION HISTORY:
#****
#****  Date               Initials        Comments
#****  ====              ======      =========
#**** 05/06/2020    RJR          Initial Revision
#****
#***********************************************************************************************************************

#=-----------------------------------------------------------------------------
#    CUBES
#=-----------------------------------------------------------------------------
cbLeaseMenu = 'flm_Finance Lease Menu';
cbLeaseDetails = 'flm_Finance Lease Details';
cbLeaseVariations = 'flm_Finance Lease Variations';
cbClientPref = 'sys_Client Preferences';

#=-----------------------------------------------------------------------------
#    DIMENSIONS
#=-----------------------------------------------------------------------------
dmVariation = 'Lease Variation';
dmStatus = 'Lease Status';
dmLeaseType = 'Lease Type';
dmReviewType = 'Lease Review Type';
dmLeaseNbr = 'Lease Number';
dmLeaseMenu = 'flm_Finance Lease Menu Measure';
dmClient = '}Clients';

#=-----------------------------------------------------------------------------
#    OTHER VARIABLES
#=-----------------------------------------------------------------------------
IF(DIMIX(dmClient, TM1User) = 0);
      sUser = 'Admin';
ELSE;
      sUser = ATTRS(dmClient, TM1User, 'Non_CAM_ID');
ENDIF;
Object = '}' | sUser;

#=-----------------------------------------------------------------------------
#    CLEAR TARGET AREA
#=-----------------------------------------------------------------------------
VIEWDESTROY(cbLeaseMenu, Object);

# ---- Lease Number
sDim = dmLeaseNbr;
sParent = psLeaseNbr;
SUBSETDESTROY(sDim, Object);
SUBSETCREATE(sDim, Object);
IF (DTYPE(sDim, sParent) @='N');
      SUBSETELEMENTINSERT (sDim, Object, sParent, 1);
ELSE;
      sMDX = '{TM1FILTERBYLEVEL( {TM1DRILLDOWNMEMBER( {[' | sDim | '].[' | sParent | ']}, ALL, RECURSIVE )}, 0)}';
      SUBSETMDXSET(sDim, Object, sMDX);
      SUBSETMDXSET(sDim, Object, '');
ENDIF;

# CREATE VIEW AND ASSIGN SUBETS
VIEWCREATE(cbLeaseMenu, Object);
VIEWSUBSETASSIGN(cbLeaseMenu, Object, dmLeaseNbr, Object);

# ZERO OUT TARGET VIEWS
VIEWZEROOUT(cbLeaseMenu, Object);
VIEWDESTROY(cbLeaseMenu, Object);

#--------------------------------------------------------------
#    SET DATASOURCE
#--------------------------------------------------------------
DATASOURCENAMEFORSERVER = dmLeaseNbr;
DATASOURCETYPE = 'SUBSET';
DATASOURCEDIMENSIONSUBSET = Object;



573,3

#****Begin: Generated Statements***
#****End: Generated Statements****
574,17

#****Begin: Generated Statements***
#****End: Generated Statements****


#=-----------------------------------------------------------------------------
#    UPDATE MENU
#=-----------------------------------------------------------------------------
sVariation = CELLGETS(cbLeaseVariations, vsLeaseNbr, 'Latest Variation');

sStatus = CELLGETS(cbLeaseDetails, sVariation, vsLeaseNbr, 'Status');
sLeaseType = CELLGETS(cbLeaseDetails, sVariation, vsLeaseNbr, 'Lease Type');
sReviewType = CELLGETS(cbLeaseDetails, sVariation, vsLeaseNbr, 'Lease Review Type');

IF( DIMIX(dmStatus, sStatus) <> 0 & DIMIX(dmLeaseType, sLeaseType) <> 0 & DIMIX(dmReviewType, sReviewType) <> 0);
      CELLPUTN(1, cbLeaseMenu, sStatus, sLeaseType, sReviewType, vsLeaseNbr, 'Count');
ENDIF;
575,5

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
