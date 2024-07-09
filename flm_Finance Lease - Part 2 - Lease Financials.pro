601,100
602,"flm_Finance Lease - Part 2 - Lease Financials"
562,"VIEW"
586,"flm_Finance Lease Reporting"
585,"flm_Finance Lease Reporting"
564,
565,"tAA3rf<2Xc@9eYHw[=b`aRIbDx=ahVTsxHgPHSIh0\QzD6Iy\TB2X4WXf<;0yqbx65cHvFkw7Q6g1GG]2i:znweH<0WLHU;g^7@yQ8dbD\dFSD^v`@PWa;;;Brd;ni2kXgdQE;5ap3SwqwfDeorcp9TYLEquE@VckDYlR^Tdpop0M@x_`jZN_haPnBHsv5Tv4dHhvQ>y"
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
570,View1
571,
569,0
592,0
599,1000
560,3
psYear
psVariation
psLeaseNbr
561,3
2
2
2
590,3
psYear,"2022-2023"
psVariation,"Actual"
psLeaseNbr,""
637,3
psYear,""
psVariation,""
psLeaseNbr,""
577,12
vsYear
vsVariation
vsLeaseStatus
vsLeaseType
vsLeaseReviewType
vsLeaseNumber
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
572,168

#****Begin: Generated Statements***
#****End: Generated Statements****

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#
# Process:            flm_Finance Lease - Part 2 - Lease Financials
#
# Purpose:            Exports finance lease financials
#                                                      
# Written by:        Rodney Richardson(Excelerated Consulting)
#
# Date:                 26/05/2023 test
#
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#------------------------------------------------------------------
#    CUBES
#------------------------------------------------------------------
cbLeaseDetails = 'flm_Finance Lease Details';
cbLeaseRep = 'flm_Finance Lease Reporting';
cbLeaseSchedule = 'flm_Finance Lease Schedule';
cbVar = 'sys_Variable';

#------------------------------------------------------------------
#    DIMENSIONS
#------------------------------------------------------------------
dmYear = 'Year';
dmVariation = 'Lease Variation';
dmLeaseStatus = 'Lease Status';
dmLeaseType = 'Lease Type';
dmLeaseReviewType = 'Lease Review Type';
dmLeaseNbr = 'Lease Number';
dmMonth = 'Month';
dmLeaseRep = 'flm_Finance Lease Reporting Measure';

#------------------------------------------------------------------
#    OTHER PARAMETERS
#------------------------------------------------------------------
Object = '$LeaseExport';
nCounter = 0;
sDate = TODAY(1);
IF(psYear @= 'All Years');
      psYear = '';
ENDIF;
IF(psYear @= '');
      sYear = psYear;
ELSE;
      sYear = psYear | ' ';
ENDIF;
IF(psVariation @= '');
      sVariation = 'Estimated Outcome ';
ELSE;
      sVariation = psVariation | ' ';
ENDIF;
IF(psLeaseNbr @= '');
      sLeaseNbr = psLeaseNbr;
ELSE;
      sLeaseNbr = psLeaseNbr | ' ';
ENDIF;
IF(sYear @='' & psLeaseNbr @= '');
      sFileName = 'Lease Financials - ' | sVariation | ' @ ' | sDate | '.csv';
ELSE;
      sFileName = 'Lease Financials - ' | sYear | sVariation | sLeaseNbr | '@ ' | sDate | '.csv';
ENDIF;
sDirectory = CELLGETS(cbVar, 'sys_Import Directory', 'sValue') | '\Finance Leases\Finance Lease Exports\';
sFilePath = sDirectory | sFileName;

#------------------------------------------------------------------
#    CREATE SOURCE VIEW
#------------------------------------------------------------------

# ---- CREATE SUBSETS

# ---- Year
sDim = dmYear;
sEl = psYear;
SUBSETCREATE (sDim, Object, 1);
IF(sEl @= '');
      sMDX = '{TM1FILTERBYLEVEL( {TM1SUBSETALL( [' | sDim | '] )}, 0)}';
      SUBSETMDXSET(sDim, Object, sMDX);
      SUBSETMDXSET(sDim, Object, '');
ELSE;
      SUBSETELEMENTINSERT (sDim, Object, sEl, 1);
ENDIF;

# ---- Lease Variation
sDim = dmVariation;
IF(psVariation @= '');
      sEl = 'Estimated Outcome';
ELSE;
      sEl = psVariation;
ENDIF;
SUBSETCREATE (sDim, Object, 1);
SUBSETELEMENTINSERT (sDim, Object, sEl, 1);

# ---- Lease Status
sDim = dmLeaseStatus;
SUBSETCREATE (sDim, Object, 1);
sMDX = '{TM1FILTERBYLEVEL( {TM1SUBSETALL( [' | sDim | '] )}, 0)}';
SUBSETMDXSET(sDim, Object, sMDX);
SUBSETMDXSET(sDim, Object, '');

# ---- Lease Type
sDim = dmLeaseType;
SUBSETCREATE (sDim, Object, 1);
sMDX = '{TM1FILTERBYLEVEL( {TM1SUBSETALL( [' | sDim | '] )}, 0)}';
SUBSETMDXSET(sDim, Object, sMDX);
SUBSETMDXSET(sDim, Object, '');

# ---- Lease Review Type
sDim = dmLeaseReviewType;
SUBSETCREATE (sDim, Object, 1);
sMDX = '{TM1FILTERBYLEVEL( {TM1SUBSETALL( [' | sDim | '] )}, 0)}';
SUBSETMDXSET(sDim, Object, sMDX);
SUBSETMDXSET(sDim, Object, '');

# ---- Lease Number
sDim = dmLeaseNbr;
SUBSETCREATE (sDim, Object, 1);
sEl = psLeaseNbr;
IF(sEl @= '');
      sMDX = '{TM1FILTERBYLEVEL( {TM1SUBSETALL( [' | sDim | '] )}, 0)}';
      SUBSETMDXSET(sDim, Object, sMDX);
      SUBSETMDXSET(sDim, Object, '');
ELSEIF(DTYPE(sDim, sEl) @= 'C');
      sMDX = '{TM1FILTERBYLEVEL( {TM1DRILLDOWNMEMBER( {[' | sDim | '].[' | sEl | ']}, ALL, RECURSIVE )}, 0)}';
      SUBSETMDXSET(sDim, Object, sMDX);
      SUBSETMDXSET(sDim, Object, '');
ELSE;
      SUBSETELEMENTINSERT (sDim, Object, sEl, 1);
ENDIF;

# ---- Month
sDim = dmMonth;
sParent = 'Jun YTD';
SUBSETCREATE (sDim, Object, 1);
sMDX = '{TM1FILTERBYLEVEL( {TM1SUBSETALL( [' | sDim | '] )}, 0)}';
SUBSETMDXSET(sDim, Object, sMDX);
SUBSETMDXSET(sDim, Object, '');

# ---- Measure
sDim = dmLeaseRep;
sEl = 'Opening Gross Asset Balance';
SUBSETCREATE (sDim, Object, 1);
SUBSETELEMENTINSERT (sDim, Object, sEl, 1);

#------------------------------------------------------------------
#    CREATE REQUIRED VIEW
#------------------------------------------------------------------
VIEWCREATE (cbLeaseRep, Object, 1);
VIEWSUPPRESSZEROESSET(cbLeaseRep, Object, 1);
VIEWEXTRACTSKIPCALCSSET(cbLeaseRep, Object, 0);
VIEWSUBSETASSIGN(cbLeaseRep, Object, dmYear, Object);
VIEWSUBSETASSIGN(cbLeaseRep, Object, dmVariation, Object);
VIEWSUBSETASSIGN(cbLeaseRep, Object, dmLeaseStatus, Object);
VIEWSUBSETASSIGN(cbLeaseRep, Object, dmLeaseType, Object);
VIEWSUBSETASSIGN(cbLeaseRep, Object, dmLeaseReviewType, Object);
VIEWSUBSETASSIGN(cbLeaseRep, Object, dmLeaseNbr, Object);
VIEWSUBSETASSIGN(cbLeaseRep, Object, dmMonth, Object);
VIEWSUBSETASSIGN(cbLeaseRep, Object, dmLeaseRep, Object);

#------------------------------------------------------------------
#    SET DATASOURCE
#------------------------------------------------------------------
DATASOURCETYPE = 'VIEW';
DATASOURCECUBEVIEW = Object;

573,3

#****Begin: Generated Statements***
#****End: Generated Statements****
574,79

#****Begin: Generated Statements***
#****End: Generated Statements****

#----------------------------------------------------------------------------------------------------------
#    ADD HEADER RECORD
#----------------------------------------------------------------------------------------------------------

IF(nCounter = 0);
      ASCIIOUTPUT(sFilePath, 'Lease Number', 'Variation', 'Year', 'Month', 'Liability Opening Balance', 'NPV Payments', 'Lease Payment', 'Lease One-Off Adjustment', 'Rent Abatement Amount', 'Lease Free Amount', 'Interest Expense', 'Liability Closing Balance', 'ROU Opening Balance', 'NPV Lease Payments', 'Direct Lease Costs', 'Makegood Provision', 'Depreciation Charge', 'ROU Closing Balance', 'Lease Revenue');
      nCounter = 1;
ENDIF;

#----------------------------------------------------------------------------------------------------------
#    GET FINANCIAL DATA
#----------------------------------------------------------------------------------------------------------

# ---- Liability Opening Balance
sMeasure = 'Opening Liability Balance';
sLiabilityOB = NUMBERTOSTRING( CELLGETN(cbLeaseRep, vsYear, vsVariation, 'All Lease Status', 'All Lease Types', 'All Review Types', vsLeaseNumber, vsMonth, sMeasure));

# ----NPV Lease Payments
sMeasure = 'NPV Lease Payments';
sNPV = NUMBERTOSTRING( CELLGETN(cbLeaseRep, vsYear, vsVariation, 'All Lease Status', 'All Lease Types', 'All Review Types', vsLeaseNumber, vsMonth, sMeasure));

# ---- Lease Payment
sMeasure = 'Lease Payment';
sLeasePayment = NUMBERTOSTRING( CELLGETN(cbLeaseRep, vsYear, vsVariation, 'All Lease Status', 'All Lease Types', 'All Review Types', vsLeaseNumber, vsMonth, sMeasure));

# ---- Lease One-Off Adjustment
sMeasure = 'Lease One-Off Adjustment';
sOneOffAdjustment = NUMBERTOSTRING( CELLGETN(cbLeaseSchedule, vsYear, vsVariation, vsLeaseNumber, vsMonth, sMeasure));

# ---- Rent Abatement Amount
sMeasure = 'Rent Abatement Amount';
sRentAbatement = NUMBERTOSTRING( CELLGETN(cbLeaseSchedule, vsYear, vsVariation, vsLeaseNumber, vsMonth, sMeasure));

# ---- Lease Free Amount
sMeasure = 'Lease Free Amount';
sLeaseFree = NUMBERTOSTRING( CELLGETN(cbLeaseSchedule, vsYear, vsVariation, vsLeaseNumber, vsMonth, sMeasure));

# ---- Interest Expense
sMeasure = 'Interest Expense';
sInterestExpense = NUMBERTOSTRING( CELLGETN(cbLeaseRep, vsYear, vsVariation, 'All Lease Status', 'All Lease Types', 'All Review Types', vsLeaseNumber, vsMonth, sMeasure));

# ---- Liability Closing Balance
sMeasure = 'Closing Liability Balance';
sLiabilityCB = NUMBERTOSTRING( CELLGETN(cbLeaseRep, vsYear, vsVariation, 'All Lease Status', 'All Lease Types', 'All Review Types', vsLeaseNumber, vsMonth, sMeasure));

# ---- Opening Balance Right-of-Use Asset
sMeasure = 'Opening Balance Right-of-Use Asset';
sROUOB = NUMBERTOSTRING( CELLGETN(cbLeaseRep, vsYear, vsVariation, 'All Lease Status', 'All Lease Types', 'All Review Types', vsLeaseNumber, vsMonth, sMeasure));

# ---- Direct Lease Costs
sMeasure = 'Direct Lease Costs';
sDirectCosts = NUMBERTOSTRING( CELLGETN(cbLeaseRep, vsYear, vsVariation, 'All Lease Status', 'All Lease Types', 'All Review Types', vsLeaseNumber, vsMonth, sMeasure));

# ---- Makegood Provision
sMeasure = 'Makegood Provision';
sProvision = NUMBERTOSTRING( CELLGETN(cbLeaseRep, vsYear, vsVariation, 'All Lease Status', 'All Lease Types', 'All Review Types', vsLeaseNumber, vsMonth, sMeasure));

# ---- Depreciation Charge
sMeasure = 'Depreciation Charge';
sDepn = NUMBERTOSTRING( CELLGETN(cbLeaseRep, vsYear, vsVariation, 'All Lease Status', 'All Lease Types', 'All Review Types', vsLeaseNumber, vsMonth, sMeasure));

# ---- Right-of-Use Asset Closing Balance
sMeasure = 'Right-of-Use Asset';
sROUCB = NUMBERTOSTRING( CELLGETN(cbLeaseRep, vsYear, vsVariation, 'All Lease Status', 'All Lease Types', 'All Review Types', vsLeaseNumber, vsMonth, sMeasure));

# ---- Lease Revenue
sMeasure = 'Lease Revenue';
sRevenue = NUMBERTOSTRING( CELLGETN(cbLeaseRep, vsYear, vsVariation, 'All Lease Status', 'All Lease Types', 'All Review Types', vsLeaseNumber, vsMonth, sMeasure));

#----------------------------------------------------------------------------------------------------------
#    EXPORT FINANCIAL DATA
#----------------------------------------------------------------------------------------------------------

ASCIIOUTPUT(sFilePath, vsLeaseNumber, sVariation, vsYear, vsMonth, sLiabilityOB, sNPV, sLeasePayment, sOneOffAdjustment, sRentAbatement, sLeaseFree, sInterestExpense, sLiabilityCB, sROUOB, sNPV, sDirectCosts, sProvision, sDepn, sROUCB, sRevenue);

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
