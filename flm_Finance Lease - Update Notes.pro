601,100
602,"flm_Finance Lease - Update Notes"
562,"VIEW"
586,"flm_Finance Lease Notes"
585,"flm_Finance Lease Notes"
564,
565,"clOaVsqr9lF8W2X8x=hLtVoufV]w=6iYPWL`Dc73:Ca^0MiH[BQ`cs_4;tsGw^iu_I0NGqGdy5l>Nr4NlxU`bkpp:Istm1U1dlmyxTAkaZhCST:AJ@v7jDJ8i^LwrSwvs3fsv5TM<Yd]3Rwck=0MyPnRARJ4fZevNIdfE1e2j97ad926GGr8?XLxjnMK;f5L>K=4zYMe"
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
570,$LeaseNotes
571,
569,0
592,0
599,1000
560,1
psLeaseNumber
561,1
2
590,1
psLeaseNumber,"FLM00007"
637,1
psLeaseNumber,""
577,7
vsLeaseNumber
vsID
vsMeasure
vsValue
NVALUE
SVALUE
VALUE_IS_STRING
578,7
2
2
2
2
1
2
1
579,7
1
2
3
4
0
0
0
580,7
0
0
0
0
0
0
0
581,7
0
0
0
0
0
0
0
582,4
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
603,0
572,106

#****Begin: Generated Statements***
#****End: Generated Statements****


#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#
# Process:            flm_Finance Lease - Update Notes
#
# Purpose:            This process performs workflow updates for Notes attached to a lease
#
# Written by:        Rodney Richardson (EC)
#
# Date:                 01 June 2021
#
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#-----------------------------------------------------------------------------
#    CUBES
#-----------------------------------------------------------------------------
cbLeaseNotes = 'flm_Finance Lease Notes';
cbClient = 'sys_Client Preferences';

#-----------------------------------------------------------------------------
#    DIMENSIONS
#-----------------------------------------------------------------------------
dmLeaseNbr = 'Lease Number';
dmID = 'ID_No';
dmLeaseNotes = 'flm_Finance Lease Notes Measure';
dmClient = '}Clients';
dmMonth = 'Month';

#-----------------------------------------------------------------------------
#    PARAMETERS
#-----------------------------------------------------------------------------
Object = '$LeaseNotes';
IF(DIMIX(dmClient, TM1User) = 0);
      sUser = 'Admin';
ELSE;
      sUser = ATTRS(dmClient, TM1User, 'Non_CAM_ID');
ENDIF;
sYear = SUBST(TODAY(1), 1, 4);
sMonth =  SUBST(TODAY(1), 6, 2);
IF(SUBST(sMonth, 1, 1) @= '0');
      sMonth = SUBST(sMonth, 2, 1);
ENDIF;

IF( DIMIX(dmMonth, sMonth) <> 0);
      sMonth =DIMNM(dmMonth, DIMIX(dmMonth, sMonth) + 6);
ENDIF;
sMonth = ATTRS(dmMonth, sMonth, 'Description');
sDay = SUBST(TODAY(1), 9, 2);
sDate = sDay | ' ' | sMonth | ' ' | sYear;

#-----------------------------------------------------------------------------
#    CREATE SOURCE VIEW
#-----------------------------------------------------------------------------

VIEWDESTROY(cbLeaseNotes, Object);

# ---- CREATE SUBSETS

# ---- Lease Number
sDim = dmLeaseNbr;
sParent = psLeaseNumber;
SUBSETDESTROY(sDim, Object);
SUBSETCREATE(sDim, Object);
IF (DTYPE(sDim, sParent) @='N');
      SUBSETELEMENTINSERT (sDim, Object, sParent, 1);
ELSE;
      sMDX = '{TM1FILTERBYLEVEL( {TM1DRILLDOWNMEMBER( {[' | sDim | '].[' | sParent | ']}, ALL, RECURSIVE )}, 0)}';
      SUBSETMDXSET(sDim, Object, sMDX);
      SUBSETMDXSET(sDim, Object, '');
ENDIF;

# ---- ID
sDim = dmID;
sParent = 'Employee Ids';
SUBSETDESTROY(sDim, Object);
SUBSETCREATE(sDim, Object);
sMDX = '{TM1FILTERBYLEVEL( {TM1DRILLDOWNMEMBER( {[' | sDim | '].[' | sParent | ']}, ALL, RECURSIVE )}, 0)}';
SUBSETMDXSET(sDim, Object, sMDX);
SUBSETMDXSET(sDim, Object, '');

# ---- Measure
sDim = dmLeaseNotes;
sEl = 'Status';
SUBSETDESTROY(sDim, Object);
SUBSETCREATE (sDim, Object);
SUBSETELEMENTINSERT (sDim, Object, sEl, 1);

# ---- CREATE VIEW

VIEWCREATE(cbLeaseNotes, Object);
VIEWSUBSETASSIGN(cbLeaseNotes, Object, dmLeaseNbr, Object);
VIEWSUBSETASSIGN(cbLeaseNotes, Object, dmID, Object);
VIEWSUBSETASSIGN(cbLeaseNotes, Object, dmLeaseNotes, Object);
VIEWROWSUPPRESSZEROESSET(cbLeaseNotes, Object, 1);

#-----------------------------------------------------------------------------
#    SET DATASOURCE
#-----------------------------------------------------------------------------
DATASOURCENAMEFORSERVER = cbLeaseNotes;
DATASOURCETYPE = 'VIEW';
DATASOURCECUBEVIEW = Object;

573,3

#****Begin: Generated Statements***
#****End: Generated Statements****
574,46

#****Begin: Generated Statements***
#****End: Generated Statements****



#-----------------------------------------------------------------------------
#    UPDATE WORKFLOW MEASURES
#-----------------------------------------------------------------------------

# ---- Created Date

sCreatedDate = CELLGETS(cbLeaseNotes, vsLeaseNumber, vsID, 'Created Date');

IF(sCreatedDate @= '');
      CELLPUTS(sDate, cbLeaseNotes, vsLeaseNumber, vsID, 'Created Date');
ENDIF;

# ---- Created By

sCreatedBy = CELLGETS(cbLeaseNotes, vsLeaseNumber, vsID, 'Created By');

IF(sCreatedBy @= '');
      CELLPUTS(sUser, cbLeaseNotes, vsLeaseNumber, vsID, 'Created By');
ENDIF;

# ---- Completed By
sCompletedBy = CELLGETS(cbLeaseNotes, vsLeaseNumber, vsID, 'Completed By');
IF(vsValue @= 'Complete');
      IF(sCompletedBy @= '' );
            CELLPUTS(sUser, cbLeaseNotes, vsLeaseNumber, vsID, 'Completed By');
      ENDIF;
ELSE;
      CELLPUTS('', cbLeaseNotes, vsLeaseNumber, vsID, 'Completed By');
ENDIF;

# ---- Completed Date
sCompletedDate = CELLGETS(cbLeaseNotes, vsLeaseNumber, vsID, 'Completed Date');
IF(vsValue @= 'Complete');
      IF(sCompletedDate @= '' );
            CELLPUTS(sDate, cbLeaseNotes, vsLeaseNumber, vsID, 'Completed Date');
      ENDIF;
ELSE;
      CELLPUTS('', cbLeaseNotes, vsLeaseNumber, vsID, 'Completed Date');
ENDIF;

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
