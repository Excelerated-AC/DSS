601,100
602,"flm_Finance Lease - Month End"
562,"VIEW"
586,"flm_Finance Lease Reporting"
585,"flm_Finance Lease Reporting"
564,
565,"cL<agp`M4gAgd`HteMH_`T`rQF1?3u>5[IsOwmo6GvRA2]6VC`WM27zA2`2nmuWSRM5rKukb6LHfdS=Kz3k<bLf;ylPb?hsG=VZH@l3eb>i:rC;j8qD:6KS7MWl`b_;HKjwGdi5AOwOC]aX=8:pWlmFUJ<SE^oILyk@xztn>f:q[oGQo7gSs\1Dh0n`wWpypy^Gyw9RQ"
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
570,$MonthEnd
571,$LeaseCalcs
569,0
592,0
599,1000
560,2
psYear
psMonth
561,2
2
2
590,2
psYear,"2020-2021"
psMonth,"Jun"
637,2
psYear,""
psMonth,""
577,12
vsYear
vsVariation
vsStatus
vsLeaseType
vsReviewType
vsLeaseNbr
vsMonth
vsMeasure
vnValue
NVALUE
SVALUE
VALUE_IS_STRING
578,12
2
2
2
2
2
2
2
2
1
1
2
1
579,12
1
2
3
4
5
6
7
8
9
0
0
0
580,12
0
0
0
0
0
0
0
0
0
0
0
0
581,12
0
0
0
0
0
0
0
0
0
0
0
0
582,9
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=33ColType=827
603,0
572,124

#****Begin: Generated Statements***
#****End: Generated Statements****

#************************************************************************************************************************#
#
# Process:            fin_Finance Lease - Month End

# Purpose:            
#                           
#                           
# Written by:        Rodney Richardson(Excelerated Consulting)
#
# Date:                 17/06/2020
#
#************************************************************************************************************************#

#--------------------------------------------------------------
#    CUBES
#--------------------------------------------------------------
cbLeaseDetails = 'flm_Finance Lease Details';
cbLeaseRep = 'flm_Finance Lease Reporting';
cbLeaseLedger = 'flm_Finance Lease Ledger';
cbLeaseSchedule = 'flm_Finance Lease Schedule';
cbLeaseMenu = 'flm_Finance Lease Menu';
cbLeaseVariations = 'flm_Finance Lease Variations';
cbLeaseCommitment = 'flm_Finance Lease Commitments';
cbCalendar = 'sys_Calendar';
cbVariable = 'sys_Variable';

#--------------------------------------------------------------
#    DIMENSIONS
#--------------------------------------------------------------
dmYear = 'Year';
dmVariation = 'Lease Variation';
dmLeaseType = 'Lease Type';
dmReviewType = 'Lease Review Type';
dmLeaseNbr = 'Lease Number';
dmStatus = 'Lease Status';
dmEntity = 'Entity';
dmCC = 'Cost Centre';
dmProg = 'Program';
dmProj = 'Project';
dmIT = 'Internal Trading';
dmID = 'ID_No';
dmMth = 'Month';
dmLeaseRep = 'flm_Finance Lease Reporting Measure';
dmLeaseDetails = 'flm_Finance Lease Details Measure';

#--------------------------------------------------------------
#    OTHER PARAMETERS
#--------------------------------------------------------------
Object = '$MonthEnd';
sVariation = 'Actual';
sMthYTD = psMonth | ' YTD';
IF(psYear @='');
      sYear = CELLGETS(cbVariable, 'Current Year', 'sValue');
ELSE;
      sYear = psYear;
ENDIF;

#-----------------------------------------------------------------
#    DELETE ANY VIEWS AND SUBSETS
#-----------------------------------------------------------------
VIEWDESTROY(cbLeaseRep, Object);
VIEWDESTROY(cbLeaseLedger, Object);
SUBSETDESTROY(dmYear, Object);
SUBSETDESTROY(dmVariation, Object);

#--------------------------------------------------------------
#    CLEAR TARGET AREA
#--------------------------------------------------------------

# ---- CREATE SUBSETS

# ---- Year
sDim = dmYear;
sEl = sYear;
SUBSETCREATE (sDim, Object);
SUBSETELEMENTINSERT (sDim, Object, sEl, 1);

# ---- Lease Variation
sDim = dmVariation;
sEl = sVariation;
SUBSETCREATE (sDim, Object);
SUBSETELEMENTINSERT (sDim, Object, sEl, 1);

# ---- CREATE VIEWS

# ---- Reporting Cube
VIEWCREATE(cbLeaseRep, Object);
VIEWSUBSETASSIGN(cbLeaseRep, Object, dmYear, Object);
VIEWSUBSETASSIGN(cbLeaseRep, Object, dmVariation, Object);
VIEWROWSUPPRESSZEROESSET(cbLeaseRep, Object, 1);
VIEWZEROOUT(cbLeaseRep, Object);

# ---- Ledger Cube
VIEWCREATE(cbLeaseLedger, Object);
VIEWSUBSETASSIGN(cbLeaseLedger, Object, dmYear, Object);
VIEWSUBSETASSIGN(cbLeaseLedger, Object, dmVariation, Object);
VIEWROWSUPPRESSZEROESSET(cbLeaseLedger, Object, 1);
VIEWZEROOUT(cbLeaseLedger, Object);

#--------------------------------------------------------------
#    CREATE SOURCE VIEW
#--------------------------------------------------------------

# ---- CREATE SUBSETS

# ---- Lease Variation
sDim = dmVariation;
sParent = 'All Variations';
SUBSETDELETEALLELEMENTS(sDim, Object);
sMDX = '{TM1FILTERBYLEVEL( {TM1DRILLDOWNMEMBER( {[' | sDim | '].[' | sParent | ']}, ALL, RECURSIVE )}, 0)}';
SUBSETMDXSET(sDim, Object, sMDX);
SUBSETMDXSET(sDim, Object, '');

#--------------------------------------------------------------
#    SET DATASOURCE
#--------------------------------------------------------------
DATASOURCENAMEFORSERVER = cbLeaseRep;
DATASOURCETYPE = 'VIEW';
DATASOURCECUBEVIEW = Object;

573,10

#****Begin: Generated Statements***
#****End: Generated Statements****







574,304

#****Begin: Generated Statements***
#****End: Generated Statements****


# ---- Lease Variation
sLatestVariation = CELLGETS(cbLeaseVariations, vsLeaseNbr, 'Latest Variation');
IF(vsVariation @<> sLatestVariation);
      ITEMSKIP;
ENDIF;

# ----  Status
sStatus = CELLGETS(cbLeaseDetails, vsVariation, vsLeaseNbr, 'Status');
IF(sStatus @= 'Estimate Only');
      ITEMSKIP;
ENDIF;

#--------------------------------------------------------------
#    REPORTING CUBE
#--------------------------------------------------------------
# ---- Post Movement
IF(ELISANC(dmMth, sMthYTD, vsMonth) = 1);
      CELLPUTN(vnValue, cbLeaseRep, vsYear, sVariation, vsStatus, vsLeaseType, vsReviewType, vsLeaseNbr, vsMonth, vsMeasure);
ELSE;
      ITEMSKIP;
ENDIF;

#--------------------------------------------------------------
#   LEDGER CUBE
#--------------------------------------------------------------
# Entity
sEntity = CELLGETS(cbLeaseDetails, vsVariation, vsLeaseNbr, 'Entity');

# Cost Centre 
sCC = CELLGETS(cbLeaseDetails, vsVariation, vsLeaseNbr, 'Cost Centre');

#Internal Trading
sIT = CELLGETS(cbLeaseDetails, vsVariation, vsLeaseNbr, 'Internal Trading');

# Project
sProj = SUBST(CELLGETS(cbLeaseDetails, vsVariation, vsLeaseNbr, 'Project'), 1, 5);

# Program
sProg = SUBST(CELLGETS(cbLeaseDetails, vsVariation, vsLeaseNbr, 'Program'), 1, 4);

# Lease Start Month
sLeaseStartMonth = CELLGETS(cbLeaseDetails, vsVariation, vsLeaseNbr, 'Lease Start Month');

# Lease Start Year
sLeaseStartYear = CELLGETS(cbLeaseDetails, vsVariation, vsLeaseNbr, 'Lease Start Year');

#--------------------------------------------------------------
#    VALIDATIONS
#--------------------------------------------------------------
IF(DIMIX(dmEntity, sEntity) = 0);
      nFlag = 1;
ELSEIF(DIMIX(dmCC, sCC) = 0);
     nFlag = 1;
ELSEIF(DIMIX(dmProj, sProj) = 0);
     nFlag = 1;
ELSEIF(DIMIX(dmProg, sProg) = 0);
     nFlag = 1;
ELSEIF(DIMIX(dmIT, sIT) = 0);
     nFlag = 1;
ELSE;
      nFlag = 0;
ENDIF;

nFlag = 0;
IF(nFlag = 1);
      ITEMSKIP;
ENDIF;

#-------------------------------------------------------------------
#    LEASE CAPITALISATION / REVAL
#-------------------------------------------------------------------

IF(vsMeasure @= 'NPV Lease Payments');

      # ---- Asset
      IF(vsYear @= sLeaseStartYear & vsMonth @= sLeaseStartMonth);
            sComponent = 'Asset - Lease Capitalisation';
      ELSE;
            sComponent = 'Asset - Lease Revaluation';
      ENDIF;

      IF(vnValue < 0);
            sMeasure = 'Credit';
      ELSE;
            sMeasure = 'Debit';
      ENDIF;

      CELLPUTN(ABS(vnValue), cbLeaseLedger, vsYear, sVariation, sEntity, sCC, sIT, sProj, sProg, sComponent, vsLeaseNbr, vsMonth, sMeasure);

      # ---- Liability
      IF(vsYear @= sLeaseStartYear & vsMonth @= sLeaseStartMonth);
            sComponent = 'Liability - Lease Capitalisation';
      ELSE;
            sComponent = 'Liability - Lease Revaluation';
      ENDIF;

      IF(vnValue < 0);
            sMeasure = 'Debit';
      ELSE;
            sMeasure = 'Credit';
      ENDIF;

      CELLPUTN(ABS(vnValue), cbLeaseLedger, vsYear, sVariation, sEntity, sCC, sIT, sProj, sProg, sComponent, vsLeaseNbr, vsMonth, sMeasure);

ENDIF;

#-------------------------------------------------------------------
#    LEASE PAYMENT
#-------------------------------------------------------------------

IF(vsMeasure @= 'Lease Payment');

      # ---- Liability - Lease Payment
      sComponent = 'Liability - Lease Payment';

      IF(vnValue < 0);
            sMeasure = 'Debit';
      ELSE;
            sMeasure = 'Credit';
      ENDIF;

      CELLPUTN(ABS(vnValue), cbLeaseLedger, vsYear, sVariation, sEntity, sCC, sIT, sProj, sProg, sComponent, vsLeaseNbr, vsMonth, sMeasure);

      # ---- Cash - Lease Payment
      sComponent = 'Cash - Lease Payment';

      IF(vnValue < 0);
            sMeasure = 'Credit';
      ELSE;
            sMeasure = 'Debit';
      ENDIF;

      CELLPUTN(ABS(vnValue), cbLeaseLedger, vsYear, sVariation, sEntity, sCC, sIT, sProj, sProg, sComponent, vsLeaseNbr, vsMonth, sMeasure);

ENDIF;

#-------------------------------------------------------------------
#    INTEREST EXPENSE
#-------------------------------------------------------------------

IF(vsMeasure @= 'Interest Expense');

      # ---- Interest Expense
      sComponent = 'Interest Expense';

      IF(vnValue < 0);
            sMeasure = 'Credit';
      ELSE;
            sMeasure = 'Debit';
      ENDIF;

      CELLPUTN(ABS(vnValue), cbLeaseLedger, vsYear, sVariation, sEntity, sCC, sIT, sProj, sProg, sComponent, vsLeaseNbr, vsMonth, sMeasure);

      # ---- Liability - Interest Expense
      sComponent = 'Liability - Interest Expense';

      IF(vnValue < 0);
            sMeasure = 'Debit';
      ELSE;
            sMeasure = 'Credit';
      ENDIF;

      CELLPUTN(ABS(vnValue), cbLeaseLedger, vsYear, sVariation, sEntity, sCC, sIT, sProj, sProg, sComponent, vsLeaseNbr, vsMonth, sMeasure);

ENDIF;

#-------------------------------------------------------------------
#    DEPRECIATION EXPENSE
#-------------------------------------------------------------------

IF(vsMeasure @= 'Depreciation Charge');

      # ---- Depreciation Expense
      sComponent = 'Depreciation Expense';

      IF(vnValue < 0);
            sMeasure = 'Debit';
      ELSE;
            sMeasure = 'Credit';
      ENDIF;

      CELLPUTN(ABS(vnValue), cbLeaseLedger, vsYear, sVariation, sEntity, sCC, sIT, sProj, sProg, sComponent, vsLeaseNbr, vsMonth, sMeasure);

      # ---- Accumulated Depreciation
      sComponent = 'Accumulated Depreciation';

      IF(vnValue < 0);
            sMeasure = 'Credit';
      ELSE;
            sMeasure = 'Debit';
      ENDIF;

      CELLPUTN(ABS(vnValue), cbLeaseLedger, vsYear, sVariation, sEntity, sCC, sIT, sProj, sProg, sComponent, vsLeaseNbr, vsMonth, sMeasure);

ENDIF;

#-------------------------------------------------------------------
#   DIRECT LEASE COSTS
#-------------------------------------------------------------------

IF(vsMeasure @= 'Direct Lease Costs');

      # ---- Asset - Direct Lease Costs
      sComponent = 'Asset - Direct Lease Costs';

      IF(vnValue < 0);
            sMeasure = 'Credit';
      ELSE;
            sMeasure = 'Debit';
      ENDIF;

      CELLPUTN(ABS(vnValue), cbLeaseLedger, vsYear, sVariation, sEntity, sCC, sIT, sProj, sProg, sComponent, vsLeaseNbr, vsMonth, sMeasure);

      # ---- Clearing Account - Direct Lease Costs
      sComponent = 'Clearing Account - Direct Lease Costs';

      IF(vnValue < 0);
            sMeasure = 'Debit';
      ELSE;
            sMeasure = 'Credit';
      ENDIF;

      CELLPUTN(ABS(vnValue), cbLeaseLedger, vsYear, sVariation, sEntity, sCC, sIT, sProj, sProg, sComponent, vsLeaseNbr, vsMonth, sMeasure);

ENDIF;

#-------------------------------------------------------------------
#   MAKEGOOD PROVISION
#-------------------------------------------------------------------

IF(vsMeasure @= 'Makegood Provision');

      # ---- Asset - Direct Lease Costs
      sComponent = 'Asset - Makegood Provision';

      IF(vnValue < 0);
            sMeasure = 'Credit';
      ELSE;
            sMeasure = 'Debit';
      ENDIF;

      CELLPUTN(ABS(vnValue), cbLeaseLedger, vsYear, sVariation, sEntity, sCC, sIT, sProj, sProg, sComponent, vsLeaseNbr, vsMonth, sMeasure);

      # ---- Clearing Account - Makegood Provision
      sComponent = 'Clearing Account - Makegood Provision';

      IF(vnValue < 0);
            sMeasure = 'Debit';
      ELSE;
            sMeasure = 'Credit';
      ENDIF;

      CELLPUTN(ABS(vnValue), cbLeaseLedger, vsYear, sVariation, sEntity, sCC, sIT, sProj, sProg, sComponent, vsLeaseNbr, vsMonth, sMeasure);

ENDIF;

#-------------------------------------------------------------------
#    CURRENT / NON-CURRENT LIABILITY
#-------------------------------------------------------------------
IF(vsMonth @= 'Jul');
      sPriorYear = ATTRS(dmYear, vsYear, 'Prev');
      sPriorMth = 'Jun';
ELSE;
      sPriorYear = vsYear;
      sPriorMth = ATTRS(dmMth, vsMonth, 'Prev');
ENDIF;

IF(CELLGETN(cbLeaseCommitment, sPriorYear, 'Estimated Outcome', 'All Lease Status', 'All Lease Types', 'All Review Types', 'Non-Current Liability', vsLeaseNbr, sPriorMth, 'Total') <> 0);
      nFactor = -1;
ELSE;
      nFactor = 1;
ENDIF;
nMovement = (CELLGETN(cbLeaseCommitment, vsYear, 'Estimated Outcome', 'All Lease Status', 'All Lease Types', 'All Review Types', 'Non-Current Liability', vsLeaseNbr, vsMonth, 'Total') - CELLGETN(cbLeaseCommitment, sPriorYear,'Estimated Outcome', 'All Lease Status', 'All Lease Types', 'All Review Types', 'Non-Current Liability', vsLeaseNbr, sPriorMth, 'Total')) * -1;
nAdjMovement = ABS(nMovement);

# ----Non-Current Liability Movement

sComponent = 'Non-Current Liability - Split';

IF(nMovement > 0);
     sMeasure = 'Debit';
ELSE;
      sMeasure = 'Credit';
ENDIF;

CELLPUTN(nAdjMovement, cbLeaseLedger, vsYear, sVariation, sEntity, sCC, sIT, sProj, sProg, sComponent, vsLeaseNbr, vsMonth, sMeasure);

# ---- Current Liability Movement

sComponent = 'Current Liability - Split';

IF(nMovement > 0);
      sMeasure = 'Credit';
ELSE;
      sMeasure = 'Debit';
ENDIF;

CELLPUTN(nAdjMovement, cbLeaseLedger, vsYear, sVariation, sEntity, sCC, sIT, sProj, sProg, sComponent, vsLeaseNbr, vsMonth, sMeasure);

575,11

#****Begin: Generated Statements***
#****End: Generated Statements****

#--------------------------------------------------------------------------
#    DELETE TEMPORARY VIEWS AND SUBSETS
#--------------------------------------------------------------------------
VIEWDESTROY(cbLeaseRep, Object);
VIEWDESTROY(cbLeaseLedger, Object);
SUBSETDESTROY(dmYear, Object);
SUBSETDESTROY(dmVariation, Object);
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
