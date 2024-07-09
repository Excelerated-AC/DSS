601,100
602,"flm_Finance Lease - Journal Extract"
562,"VIEW"
586,"flm_Finance Lease Ledger"
585,"flm_Finance Lease Ledger"
564,
565,"qgVEiDrGrIh3HRJZ2apGfuo3jnh<idEE9`wbeSJ5K\Jr@f_@yY<<;TyQ:LVx^VXHw0TW<W;V@3YF@llT1xo]6;9Xf7or]ILA3zqO_qmG=4d4ke2f3:6SUvouFQ7oolKe=RFoBJzvocEwI<OcRZGD`1oj014O>MO8v[5A<C;UIh5gW?`9zKyA=\Buja_a;:;_W4oARH2R"
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
570,$LeaseJournal
571,
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
psMonth,"Aug"
637,2
psYear,""
psMonth,""
577,15
vsYear
vsVariation
vsEntity
vsCC
vsIT
vsProject
vsProgram
vsComponent
vsLeaseNbr
vsMonth
vsMeasure
vnValue
NVALUE
SVALUE
VALUE_IS_STRING
578,15
2
2
2
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
579,15
1
2
3
4
5
6
7
8
9
10
11
12
0
0
0
580,15
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
0
0
0
581,15
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
0
0
0
582,12
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
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
572,172

#****Begin: Generated Statements***
#****End: Generated Statements****

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#
# Process:            flm_Finance Lease - Journal Extract
#
# Purpose:            
#                                                      
# Written by:        Rodney Richardson(Excelerated Consulting)
#
# Date:                 18/06/2020
#
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#------------------------------------------------------------------
#    CUBES
#------------------------------------------------------------------
cbLeaseDetails = 'flm_Finance Lease Details';
cbLeaseLedger = 'flm_Finance Lease Ledger';
cbVar = 'sys_Variable';
cbLeaseVar = 'flm_Finance Lease Variations';
cbComponentMap = 'flm_Finance Lease Component Mapping';

#------------------------------------------------------------------
#    DIMENSIONS
#------------------------------------------------------------------
dmYear = 'Year';
dmVariation = 'Lease Variation';
dmEntity = 'Entity';
dmCC = 'Cost Centre';
dmInTrad = 'Internal Trading';
dmProj = 'Project';
dmProg = 'Program';
dmComponent = 'Lease Component';
dmLeaseType = 'Lease Type';
dmLeaseNbr = 'Lease Number';
dmMonth = 'Month';
dmLeaseDetails = 'flm_Finance Lease Details Measure';
dmLeaseLedger = 'flm_Finance Lease Ledger Measure';

#------------------------------------------------------------------
#    OTHER PARAMETERS
#------------------------------------------------------------------
Object = '$LeaseJournal';
nCounter = 0;
sFileName =psYear | ' ' | psMonth | ' - Lease Journal.csv';
sDirectory = CELLGETS(cbVar, 'sys_Import Directory', 'sValue') | '\Finance Leases\Finance Lease Journals\';
sFilePath = sDirectory | sFileName;
sSpare = '9999';

#--------------------------------------------------------------
#   DELETE VIEWS AND SUBSETS
#--------------------------------------------------------------
VIEWDESTROY(cbLeaseLedger, Object);
SUBSETDESTROY(dmYear, Object);
SUBSETDESTROY(dmVariation, Object);
SUBSETDESTROY(dmEntity, Object);
SUBSETDESTROY(dmCC, Object);
SUBSETDESTROY(dmInTrad, Object);
SUBSETDESTROY(dmProj, Object);
SUBSETDESTROY(dmProg, Object);
SUBSETDESTROY(dmComponent, Object);
SUBSETDESTROY(dmLeaseNbr, Object);
SUBSETDESTROY(dmMonth, Object);
SUBSETDESTROY(dmLeaseLedger, Object);

#--------------------------------------------------------------
#    CREATE SOURCE VIEW
#--------------------------------------------------------------

# ---- CREATE SUBSETS

# ---- Year
sDim = dmYear;
sEl = psYear;
SUBSETCREATE (sDim, Object);
SUBSETELEMENTINSERT (sDim, Object, sEl, 1);

# ---- Lease Variation
sDim = dmVariation;
sEl = 'Actual';
SUBSETCREATE (sDim, Object);
SUBSETELEMENTINSERT (sDim, Object, sEl, 1);

# ---- Entity
sDim = dmEntity;
SUBSETCREATE (sDim, Object);
sMDX = '{TM1FILTERBYLEVEL( {TM1SUBSETALL( [' | sDim | '] )}, 0)}';
SUBSETMDXSET(sDim, Object, sMDX);
SUBSETMDXSET(sDim, Object, '');

# ---- Cost Centre
sDim = dmCC;
SUBSETCREATE (sDim, Object);
sMDX = '{TM1FILTERBYLEVEL( {TM1SUBSETALL( [' | sDim | '] )}, 0)}';
SUBSETMDXSET(sDim, Object, sMDX);
SUBSETMDXSET(sDim, Object, '');

# ---- Internal Trading
sDim = dmInTrad;
SUBSETCREATE (sDim, Object);
sMDX = '{TM1FILTERBYLEVEL( {TM1SUBSETALL( [' | sDim | '] )}, 0)}';
SUBSETMDXSET(sDim, Object, sMDX);
SUBSETMDXSET(sDim, Object, '');

# ---- Project
sDim = dmProj;
SUBSETCREATE (sDim, Object);
sMDX = '{TM1FILTERBYLEVEL( {TM1SUBSETALL( [' | sDim | '] )}, 0)}';
SUBSETMDXSET(sDim, Object, sMDX);
SUBSETMDXSET(sDim, Object, '');

# ---- Program
sDim = dmProg;
SUBSETCREATE (sDim, Object);
sMDX = '{TM1FILTERBYLEVEL( {TM1SUBSETALL( [' | sDim | '] )}, 0)}';
SUBSETMDXSET(sDim, Object, sMDX);
SUBSETMDXSET(sDim, Object, '');

# ---- Lease Component
sDim = dmComponent;
SUBSETCREATE (sDim, Object);
sMDX = '{TM1FILTERBYLEVEL( {TM1SUBSETALL( [' | sDim | '] )}, 0)}';
SUBSETMDXSET(sDim, Object, sMDX);
SUBSETMDXSET(sDim, Object, '');

# ---- Lease Number
sDim = dmLeaseNbr;
SUBSETCREATE (sDim, Object);
sMDX = '{TM1FILTERBYLEVEL( {TM1SUBSETALL( [' | sDim | '] )}, 0)}';
SUBSETMDXSET(sDim, Object, sMDX);
SUBSETMDXSET(sDim, Object, '');

# ---- Month
sDim = dmMonth;
sEl = psMonth | ' YTD';
SUBSETCREATE (sDim, Object);
SUBSETELEMENTINSERT (sDim, Object, sEl, 1);

# ---- Measure
sDim = dmLeaseLedger;
SUBSETCREATE (sDim, Object);
sMDX = '{TM1FILTERBYLEVEL( {TM1SUBSETALL( [' | sDim | '] )}, 0)}';
SUBSETMDXSET(sDim, Object, sMDX);
SUBSETMDXSET(sDim, Object, '');

#--------------------------------------------------------------
#    CREATE REQUIRED VIEW
#--------------------------------------------------------------
VIEWCREATE (cbLeaseLedger, Object);
VIEWSUPPRESSZEROESSET(cbLeaseLedger, Object, 1);
VIEWEXTRACTSKIPCALCSSET(cbLeaseLedger, Object, 0);
VIEWSUBSETASSIGN(cbLeaseLedger, Object, dmYear, Object);
VIEWSUBSETASSIGN(cbLeaseLedger, Object, dmVariation, Object);
VIEWSUBSETASSIGN(cbLeaseLedger, Object, dmEntity, Object);
VIEWSUBSETASSIGN(cbLeaseLedger, Object, dmCC, Object);
VIEWSUBSETASSIGN(cbLeaseLedger, Object, dmInTrad, Object);
VIEWSUBSETASSIGN(cbLeaseLedger, Object, dmProj, Object);
VIEWSUBSETASSIGN(cbLeaseLedger, Object, dmProg, Object);
VIEWSUBSETASSIGN(cbLeaseLedger, Object, dmComponent, Object);
VIEWSUBSETASSIGN(cbLeaseLedger, Object, dmLeaseNbr, Object);
VIEWSUBSETASSIGN(cbLeaseLedger, Object, dmMonth, Object);
VIEWSUBSETASSIGN(cbLeaseLedger, Object, dmLeaseLedger, Object);

#--------------------------------------------------------------
#    SET DATASOURCE
#--------------------------------------------------------------
DATASOURCETYPE = 'VIEW';
DATASOURCECUBEVIEW = Object;

573,3

#****Begin: Generated Statements***
#****End: Generated Statements****
574,37

#****Begin: Generated Statements***
#****End: Generated Statements****

#----------------------------------------------------------------------------------------------------------
#    ADD HEADER RECORD
#----------------------------------------------------------------------------------------------------------
IF(nCounter = 0);
      ASCIIOUTPUT(sFilePath, 'Entity', 'Cost Centre', 'Account', 'Internal Trading', 'Project', 'Agency', 'Spare', 'Debit', 'Credit', 'Line Description');
      nCounter = 1;
ENDIF;

# Description
sLeaseNbr = ATTRS(dmLeaseNbr, vsLeaseNbr, 'Code and Description');
sDescription =  vsComponent | ' - ' | psMonth | ' ' | psYear | ' - ' | sLeaseNbr;

#----------------------------------------------------------------------------------------------------------
#    SKIP LEASE PAYMENT (removed on 7/6/2023 RR)
#----------------------------------------------------------------------------------------------------------
IF(ELISANC(dmComponent, 'Lease Payment', vsComponent) = 1);
#      ITEMSKIP;
ENDIF;

#----------------------------------------------------------------------------------------------------------
#    JOURNAL AMOUNTS
#----------------------------------------------------------------------------------------------------------
sLatestVariation = CELLGETS(cbLeaseVar, vsLeaseNbr, 'Latest Variation');
sLeaseType = CELLGETS(cbLeaseDetails, sLatestVariation, vsLeaseNbr, 'Lease Type');
sAccount = CELLGETS(cbComponentMap, sLeaseType, vsComponent, 'Account');
sAccount = SUBST( sAccount, 1, 6);
sValue = NUMBERTOSTRING(vnValue);

IF(vsMeasure @= 'Debit');
      ASCIIOUTPUT(sFilePath, vsEntity, vsCC, sAccount, vsIT, vsProject, vsProgram, sSpare, sValue, '', sDescription);
ELSE;
      ASCIIOUTPUT(sFilePath, vsEntity, vsCC, sAccount, vsIT, vsProject, vsProgram, sSpare, '', sValue, sDescription);
ENDIF;
575,6

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
