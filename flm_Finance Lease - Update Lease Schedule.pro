601,100
602,"flm_Finance Lease - Update Lease Schedule"
562,"VIEW"
586,"flm_Finance Lease Details"
585,"flm_Finance Lease Details"
564,
565,"uAH=XtLfLC5odZ=XMAL86aD38SIhuElYkp0vG^FTwmMxuK1Jd^>cMLgvkBOW2rNT16C4dSQadMfH173p_pOkVzr3`UEH[5=wyZ>7w5qSOdA_M;[LzIIqxZ3u<\h;l`WPtr0y:5Ht3MNdDpp6Ik@b0zE=0DSGrJW51z6dNjf7QuP^U74IY@=nL;K7TplJkpg]Ob_oF58o"
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
570,$LeaseSchedule
571,$LeaseCalcs
569,0
592,0
599,1000
560,2
psLeaseNbr
psVariation
561,2
2
2
590,2
psLeaseNbr,"FLM00017"
psVariation,"Variation 2"
637,2
psLeaseNbr,""
psVariation,""
577,7
vsVariation
vsLeaseNbr
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
572,205

#****Begin: Generated Statements***
#****End: Generated Statements****

#************************************************************************************************************************#
#
# Process:            fin_Finance Lease - Update Lease Schedule
#
# Purpose:            
#                                              
# Written by:        Rodney Richardson(Excelerated Consulting)
#
# Date:                 03/06/2020
#
#************************************************************************************************************************#

#--------------------------------------------------------------
#    CUBES
#--------------------------------------------------------------
cbLeaseDetails = 'flm_Finance Lease Details';
cbLeaseRep = 'flm_Finance Lease Reporting';
cbLeaseComponent = 'flm_Finance Lease Components';
cbLeaseCommitment = 'flm_Finance Lease Commitments';
cbLeaseSchedule = 'flm_Finance Lease Schedule';
cbLeaseMenu = 'flm_Finance Lease Menu';
cbLeaseVariations = 'flm_Finance Lease Variations';
cbLeaseRevenue = 'flm_Finance Lease Revenue';
cbLeaseRevenueRep = 'flm_Finance Lease Revenue Reporting';
cbClientPref = 'sys_Client Preferences';

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
dmLeaseSchedule = 'flm_Finance Lease Schedule Measure';

#--------------------------------------------------------------
#    OTHER PARAMETERS
#--------------------------------------------------------------
Object = '$LeaseSchedules';
sToday = TODAY(1) ;
sCurrentMonth = SUBST ( sToday, 6, 2);
IF(SUBST(sCurrentMonth, 1, 1) @= '0');
      sCurrentMonth = SUBST(sCurrentMonth, 2, 1);
ENDIF;

IF(STRINGTONUMBER(sCurrentMonth) > 6);
      sCurrentMonth = NUMBERTOSTRING(STRINGTONUMBER(sCurrentMonth) - 6);
ELSE;
      sCurrentMonth = NUMBERTOSTRING(STRINGTONUMBER(sCurrentMonth) + 6);
ENDIF;
sCurrentMonth = DIMENSIONELEMENTPRINCIPALNAME(dmMth, sCurrentMonth);

sCurrentYear = SUBST ( sToday, 1, 4);
IF(DIMIX(dmMth, sCurrentMonth) < 11);
      sCurrentYear = NUMBERTOSTRING(STRINGTONUMBER(sCurrentYear) + 1);
ENDIF;
sCurrentYear = DIMENSIONELEMENTPRINCIPALNAME(dmYear, sCurrentYear);
sAllStatus = 'All Lease Status';
sAllLeaseType = 'All Lease Types';
sAllReviewType = 'All Review Types';

#-----------------------------------------------------------------
#    QUIT IF VARIATION IS READ ONLY
#-----------------------------------------------------------------
IF(DTYPE(dmLeaseNbr, psLeaseNbr) @= 'N' & DTYPE(dmVariation, psVariation) @= 'N');

      sEditStatus = CELLGETS(cbLeaseDetails, psVariation, psLeaseNbr, 'Variation Status');
      IF(sEditStatus @= 'READ ONLY');
            PROCESSBREAK;
      ENDIF;

ENDIF;

#-----------------------------------------------------------------
#    DELETE ANY VIEWS AND SUBSETS
#-----------------------------------------------------------------
VIEWDESTROY(cbLeaseDetails, Object);
VIEWDESTROY(cbLeaseRep, Object);
VIEWDESTROY(cbLeaseSchedule, Object);
VIEWDESTROY(cbLeaseCommitment, Object);
VIEWDESTROY(cbLeaseMenu, Object);
VIEWDESTROY(cbLeaseRevenueRep, Object);
SUBSETDESTROY(dmLeaseNbr, Object);
SUBSETDESTROY(dmVariation, Object);
SUBSETDESTROY(dmLeaseDetails, Object);
SUBSETDESTROY(dmLeaseSchedule, Object);

#--------------------------------------------------------------
#    CLEAR TARGET AREAS
#--------------------------------------------------------------

# ---- CREATE SUBSETS

# ---- Lease Number
sDim = dmLeaseNbr;
sParent = psLeaseNbr;
SUBSETCREATE(sDim, Object);
IF (DTYPE(sDim, sParent) @='N');
      SUBSETELEMENTINSERT (sDim, Object, sParent, 1);
ELSE;
      sMDX = '{TM1FILTERBYLEVEL( {TM1DRILLDOWNMEMBER( {[' | sDim | '].[' | sParent | ']}, ALL, RECURSIVE )}, 0)}';
      SUBSETMDXSET(sDim, Object, sMDX);
      SUBSETMDXSET(sDim, Object, '');
ENDIF;

# ---- Lease Variation
sDim = dmVariation;
sParent = psVariation;
SUBSETCREATE(sDim, Object);
IF (DTYPE(sDim, sParent) @='N');
      SUBSETELEMENTINSERT (sDim, Object, sParent, 1);
ELSE;
      IF( DTYPE(dmLeaseNbr, psLeaseNbr) @='N');
            #sMDX = '{FILTER(  {TM1FILTERBYLEVEL( {TM1DRILLDOWNMEMBER( {[' | sDim | '].[' | sParent | ']}, ALL, RECURSIVE )}, 0)}, [[' | cbLeaseDetails | '].([Lease Number].[ ' | psLeaseNbr | ' ],[flm_Finance Lease Details Measure].[Variation Status]) <> "READ ONLY")}';
            sMDX = '{TM1FILTERBYLEVEL( {TM1DRILLDOWNMEMBER( {[' | sDim | '].[' | sParent | ']}, ALL, RECURSIVE )}, 0)}';
      ELSE;
            sMDX = '{TM1FILTERBYLEVEL( {TM1DRILLDOWNMEMBER( {[' | sDim | '].[' | sParent | ']}, ALL, RECURSIVE )}, 0)}';
      ENDIF;
      SUBSETMDXSET(sDim, Object, sMDX);
      SUBSETMDXSET(sDim, Object, '');
ENDIF;

# ---- Schedule Measure
sDim = dmLeaseSchedule;
SUBSETCREATE (sDim, Object);
SUBSETELEMENTINSERT (sDim, Object, 'Lease End', 1);
SUBSETELEMENTINSERT (sDim, Object, 'Rent Abatement Amount', 1);
SUBSETELEMENTINSERT (sDim, Object, 'Lease Free Amount', 1);
SUBSETELEMENTINSERT (sDim, Object, 'Period Count', 1);

# ---- CREATE VIEWS

# --- Reporting
VIEWCREATE(cbLeaseRep, Object);
VIEWSUBSETASSIGN(cbLeaseRep, Object, dmLeaseNbr, Object);
VIEWSUBSETASSIGN(cbLeaseRep, Object, dmVariation, Object);
VIEWROWSUPPRESSZEROESSET(cbLeaseRep, Object, 1);
VIEWZEROOUT(cbLeaseRep, Object);

# --- Commitments
VIEWCREATE(cbLeaseCommitment, Object);
VIEWSUBSETASSIGN(cbLeaseCommitment, Object, dmLeaseNbr, Object);
VIEWSUBSETASSIGN(cbLeaseCommitment, Object, dmVariation, Object);
VIEWROWSUPPRESSZEROESSET(cbLeaseCommitment, Object, 1);
VIEWZEROOUT(cbLeaseCommitment, Object);

# --- Revenue Reporting
VIEWCREATE(cbLeaseRevenueRep, Object);
VIEWSUBSETASSIGN(cbLeaseRevenueRep, Object, dmLeaseNbr, Object);
VIEWSUBSETASSIGN(cbLeaseRevenueRep, Object, dmVariation, Object);
VIEWROWSUPPRESSZEROESSET(cbLeaseRevenueRep, Object, 1);
VIEWZEROOUT(cbLeaseRevenueRep, Object);

# --- Schedule
VIEWCREATE(cbLeaseSchedule, Object);
VIEWSUBSETASSIGN(cbLeaseSchedule, Object, dmLeaseNbr, Object);
VIEWSUBSETASSIGN(cbLeaseSchedule, Object, dmVariation, Object);
VIEWSUBSETASSIGN(cbLeaseSchedule, Object, dmLeaseSchedule, Object);
VIEWROWSUPPRESSZEROESSET(cbLeaseSchedule, Object, 1);
VIEWZEROOUT(cbLeaseSchedule, Object);

# --- Menu
VIEWCREATE(cbLeaseMenu, Object);
VIEWSUBSETASSIGN(cbLeaseMenu, Object, dmLeaseNbr, Object);
VIEWROWSUPPRESSZEROESSET(cbLeaseMenu, Object, 1);
VIEWZEROOUT(cbLeaseMenu, Object);

#--------------------------------------------------------------
#    CREATE SOURCE VIEW
#--------------------------------------------------------------
# ---- Measure
sDim = dmLeaseDetails;
sEl = 'Lease Type';
SUBSETCREATE (sDim, Object);
SUBSETELEMENTINSERT (sDim, Object, sEl, 1);

VIEWCREATE(cbLeaseDetails, Object);
VIEWSUBSETASSIGN(cbLeaseDetails, Object, dmLeaseNbr, Object);
VIEWSUBSETASSIGN(cbLeaseDetails, Object, dmVariation, Object);
VIEWSUBSETASSIGN(cbLeaseDetails, Object, dmLeaseDetails, Object);
VIEWROWSUPPRESSZEROESSET(cbLeaseDetails, Object, 1);

#--------------------------------------------------------------
#    SET DATASOURCE
#--------------------------------------------------------------
DATASOURCENAMEFORSERVER = cbLeaseDetails;
DATASOURCETYPE = 'VIEW';
DATASOURCECUBEVIEW = Object;


573,731

#****Begin: Generated Statements***
#****End: Generated Statements****

#===========================================================
#    ********** POPULATE FINANCE LEASE REPORTING CUBE ********** 
#===========================================================

#--------------------------------------------------------------
#    LEASE PARAMETERS
#--------------------------------------------------------------

# ---- Lease Description
sLeaseDesc = CELLGETS(cbLeaseDetails, vsVariation, vsLeaseNbr, 'Lease Description');
ATTRPUTS(vsLeaseNbr | ' - ' | sLeaseDesc, dmLeaseNbr, vsLeaseNbr, 'Code and Description');
ATTRPUTS(sLeaseDesc | ' {' | vsLeaseNbr | '}', dmLeaseNbr, vsLeaseNbr, 'Description');
sSelectedLease = SUBST(CELLGETS(cbClientPref, TM1User, 'flm_Selected Lease'), 1, 8);
IF(vsLeaseNbr @= sSelectedLease);
      CELLPUTS(vsLeaseNbr | ' - ' | sLeaseDesc, cbClientPref, TM1User, 'flm_Selected Lease');
ENDIF;

# ---- Start Date    
sLeaseStartYr = CELLGETS(cbLeaseDetails, vsVariation, vsLeaseNbr, 'Lease Start Year');
sLeaseStartMth = CELLGETS(cbLeaseDetails, vsVariation, vsLeaseNbr, 'Lease Start Month');
sLeaseStartDay = CELLGETS(cbLeaseDetails, vsVariation, vsLeaseNbr, 'Lease Start Day');

IF(DIMIX(dmMth, sLeaseStartMth) > 10);
      sYear = SUBST(sLeaseStartYr, 6, 4);
ELSE;
      sYear = SUBST(sLeaseStartYr, 1, 4);
ENDIF;
sLeaseStartDate = sLeaseStartDay | ' ' | ATTRS(dmMth, sLeaseStartMth, 'Description') | ' ' | sYear;
CELLPUTS(sLeaseStartDate, cbLeaseDetails, vsVariation, vsLeaseNbr, 'Lease Commencement Date');

# ---- Rent Review Date    
sReviewMth = CELLGETS(cbLeaseDetails, vsVariation, vsLeaseNbr, 'Rent Review Month');
IF(DIMIX(dmMth, sReviewMth) > 0);
      sReviewMth = ATTRS(dmMth, sReviewMth, 'Next');
      sReviewDay = CELLGETS(cbLeaseDetails, vsVariation, vsLeaseNbr, 'Rent Review Day');
      sReviewDate = sReviewDay | ' ' | ATTRS(dmMth, sReviewMth, 'Description');
      CELLPUTS(sReviewDate, cbLeaseDetails, vsVariation, vsLeaseNbr, 'Rent Review Date');
ENDIF;

# ---- Market Review Date    
sReviewMth = CELLGETS(cbLeaseDetails, vsVariation, vsLeaseNbr, 'Market Review Month');
IF(DIMIX(dmMth, sReviewMth) > 0);
      sReviewMth = ATTRS(dmMth, sReviewMth, 'Next');
      sReviewDay = CELLGETS(cbLeaseDetails, vsVariation, vsLeaseNbr, 'Market Review Day');
      sReviewDate = sReviewDay | ' ' | ATTRS(dmMth, sReviewMth, 'Description');
      CELLPUTS(sReviewDate, cbLeaseDetails, vsVariation, vsLeaseNbr, 'Market Review Date');
ENDIF;

# ----  Lease Term and Option
nLeaseTerm = CELLGETN(cbLeaseDetails, vsVariation, vsLeaseNbr, 'Lease Term (Mths)');
nOptionTerm = CELLGETN(cbLeaseDetails, vsVariation, vsLeaseNbr, 'Option Term (Mths)');
sOptionLikely = CELLGETS(cbLeaseDetails, vsVariation, vsLeaseNbr, 'Option Likely');
IF(nOptionTerm <> 0 & sOptionLikely @= '');
      CELLPUTS('No', cbLeaseDetails, vsVariation, vsLeaseNbr, 'Option Likely');
      sOptionLikely = 'No';
ENDIF;
IF(sOptionLikely @= 'Yes');
      nLeaseTerm = nLeaseTerm + nOptionTerm;
ENDIF;

# ----  Interest Rate
nIntRate = CELLGETN(cbLeaseDetails, vsVariation, vsLeaseNbr, 'Interest Rate')  / 12;

# ----  Revenue Margin
nMargin = CELLGETN(cbLeaseDetails, vsVariation, vsLeaseNbr, 'Lease Revenue Margin');

# ----  Building
sBuilding = CELLGETS(cbLeaseVariations, vsLeaseNbr, 'Building');

nCounter = 1;
nComponents = ELPARN(dmLeaseNbr, vsLeaseNbr);

WHILE(nCounter <= nComponents);
      sParent = ELPAR(dmLeaseNbr, vsLeaseNbr, nCounter);
      IF(ELISANC(dmLeaseNbr, 'All Lease Numbers', sEl) = 1 % sParent @= 'All Lease Numbers');
            nCounter = nComponents + 1;
      ENDIF;
      nCounter = nCounter + 1;
END;

IF(sParent @<> sBuilding);
      DIMENSIONELEMENTCOMPONENTDELETE(dmLeaseNbr, sParent, vsLeaseNbr);
ENDIF;

IF(sBuilding @= '' & sParent @<> 'All Lease Numbers');
      sBuilding = sParent;
      CELLPUTS(sBuilding, cbLeaseVariations, vsLeaseNbr, 'Building');
ENDIF;
CELLPUTS(sBuilding, cbLeaseDetails, vsVariation, vsLeaseNbr, 'Building');
IF(sBuilding @= '');
      sBuilding = 'All Lease Numbers';
ENDIF;
DIMENSIONELEMENTCOMPONENTADD(dmLeaseNbr, sBuilding, vsLeaseNbr, 1);

# ----  Lease Type
sLeaseType = CELLGETS(cbLeaseDetails, vsVariation, vsLeaseNbr, 'Lease Type');
IF( ELISANC(dmVariation, 'Budget Variations', vsVariation) = 1 & sLeaseType @<> 'Operating Lease');
      sLeaseType = 'Finance Lease';
ENDIF;

# ----  Review Type
sReviewType = CELLGETS(cbLeaseDetails, vsVariation, vsLeaseNbr, 'Lease Review Type');

# ----  Period Count
sMth = sLeaseStartMth;
sYear = sLeaseStartYr;
nCounter = 1;

WHILE(nCounter <= nLeaseTerm );

      CELLPUTN(nCounter, cbLeaseSchedule, sYear, vsVariation, vsLeaseNbr, sMth, 'Period Count'); 

      #Get next month and year
      IF(sMth @= 'Jun');
            sMth = 'Jul';
            sYear = ATTRS(dmYear, sYear, 'Next');
      ELSE;
            sMth = ATTRS(dmMth, sMth, 'Next');
      ENDIF;      

      nCounter = nCounter + 1;
      
END;

# ----  Status
sStatus = CELLGETS(cbLeaseDetails, vsVariation, vsLeaseNbr, 'Status');
IF(sStatus @<> 'Estimate Only');
      nRemainingTerm = nLeaseTerm - CELLGETN(cbLeaseSchedule, sCurrentYear, vsVariation, vsLeaseNbr, sCurrentMonth, 'Period Count');
      sRentReviewMth = CELLGETS(cbLeaseDetails, vsVariation, vsLeaseNbr, 'Rent Review Month');
      sMarketMth = CELLGETS(cbLeaseDetails, vsVariation, vsLeaseNbr, 'Market Review Month');
      nReviewDate = DIMIX(dmMth, sRentReviewMth) - DIMIX(dmMth, sCurrentMonth);
      nMarketDate = DIMIX(dmMth, sMarketMth) - DIMIX(dmMth, sCurrentMonth);

      IF(nRemainingTerm < 7 & sStatus @<> 'Terminated');
            sStatus = 'Active - Due for Renewal';
      ELSEIF(nReviewDate < 4 & nReviewDate > -1);
            sStatus = 'Active - Due for Rent Review';
      ELSE;
            sStatus = 'Active';
      ENDIF;
      CELLPUTS(sStatus, cbLeaseDetails, vsVariation, vsLeaseNbr, 'Status');
ENDIF;

# ---- Previous Variation
IF(vsVariation @= 'Variation 1');
      sPrevVariation = '';
ELSEIF(ELISANC(dmVariation, 'Budget Variations', vsVariation) = 1);
      sPrevVariation = CELLGETS(cbLeaseDetails, vsVariation, vsLeaseNbr, 'Previous Variation');
ELSE;
      sPrevVariation = ATTRS(dmVariation, vsVariation, 'Prev');
ENDIF;

# ---- Variation Period
nVarPeriod = CELLGETN(cbLeaseDetails, vsVariation, vsLeaseNbr, 'Variation Period');

# ---- Rent Increases
sAutoInc = CELLGETS(cbLeaseDetails, vsVariation, vsLeaseNbr, 'Automatic Rent Increases');
nRate = CELLGETN(cbLeaseDetails, vsVariation, vsLeaseNbr, 'Review Increase Percentage');
sReviewMth = CELLGETS(cbLeaseDetails, vsVariation, vsLeaseNbr, 'Rent Review Month'); 
nReviewInterval = CELLGETN(cbLeaseDetails, vsVariation, vsLeaseNbr, 'Rent Review Interval'); 

IF(sAutoInc @= 'Yes');

      IF(sLeaseStartMth @= 'Jul');
            sMth = 'Jun';
            sYear = ATTRS(dmYear, sLeaseStartYr, 'Prev');
      ELSE;
            sMth = ATTRS(dmMth, sLeaseStartMth, 'Prev');
            sYear = sLeaseStartYr;
      ENDIF;  

      #------------------------------------------------------------------------------------
      #    POPULATE ANNUAL CPI INCREASES
      #------------------------------------------------------------------------------------
      nCounter = 1;
      nCount = 0;
      nIntervalCount = 0;

      WHILE(nCounter <= nLeaseTerm);

            IF(sMth @= ATTRS(dmMth, sReviewMth, 'Prev') & sYear @= sLeaseStartYr);
                 nIntervalCount = nReviewInterval;
            ENDIF;

            IF(nCounter >= nVarPeriod);
 
                  IF(sYear @= sLeaseStartYr & DIMIX(dmMth, sMth) > DIMIX(dmMth, sLeaseStartMth) & sMth @= ATTRS(dmMth, sReviewMth, 'Prev') );
                        CELLPUTN(nRate, cbLeaseSchedule, sYear, vsVariation, vsLeaseNbr, sMth, 'Lease Increase %');
                        nCount = 0;
                  #ELSEIF(nReviewInterval = 0 & sMth @= sReviewMth & nCounter > 1);
                    #    CELLPUTN(nRate, cbLeaseSchedule, sYear, vsVariation, vsLeaseNbr, sMth, 'Lease Increase %');
                  ELSEIF(nReviewInterval = 12 & sMth @= ATTRS(dmMth, sReviewMth, 'Prev') & nCounter > 1);
                        CELLPUTN(nRate, cbLeaseSchedule, sYear, vsVariation, vsLeaseNbr, sMth, 'Lease Increase %');
                  ELSEIF(nIntervalCount = 0 & nCounter > 1);
                        CELLPUTN(nRate, cbLeaseSchedule, sYear, vsVariation, vsLeaseNbr, sMth, 'Lease Increase %');
                        nIntervalCount = nReviewInterval;
                  ELSE;
                        CELLPUTN(0, cbLeaseSchedule, sYear, vsVariation, vsLeaseNbr, sMth, 'Lease Increase %'); 
                  ENDIF;

            ENDIF;

            nIntervalCount = nIntervalCount - 1;

            # ---- Get next month and year
            IF(sMth @= 'Jun');
                  sMth = 'Jul';
                  sYear = ATTRS(dmYear, sYear, 'Next');
            ELSE;
                  sMth = ATTRS(dmMth, sMth, 'Next');
            ENDIF;      

            nCounter = nCounter + 1;
            nCount = nCount + 1;

      
      END;

ENDIF;

#--------------------------------------------------------------
#    FLEXFIELD PARAMETERS
#--------------------------------------------------------------
# ---- Entity
sEntity = CELLGETS(cbLeaseDetails, vsVariation, vsLeaseNbr, 'Entity');
IF(DIMIX(dmEntity, sEntity) = 0);
      sEntity = '144';
      sEntity = ATTRS(dmEntity, sEntity, 'Code and Description');
       CELLPUTS(sEntity, cbLeaseDetails, vsVariation, vsLeaseNbr, 'Entity');
ENDIF;

# ---- Cost Centre 
sCC = CELLGETS(cbLeaseDetails, vsVariation, vsLeaseNbr, 'Cost Centre');
IF(DIMIX(dmCC, sCC) = 0);
      sCC = '14425';
      sCC = ATTRS(dmCC, sCC, 'Code and Description');
       CELLPUTS(sCC, cbLeaseDetails, vsVariation, vsLeaseNbr, 'Cost Centre');
ENDIF;

# ---- Internal Trading
sIT = CELLGETS(cbLeaseDetails, vsVariation, vsLeaseNbr, 'Internal Trading');
IF(DIMIX(dmIT, sIT) = 0);
      sIT = '99';
      sIT = ATTRS(dmIT, sIT, 'Code and Description');
       CELLPUTS(sIT, cbLeaseDetails, vsVariation, vsLeaseNbr, 'Internal Trading');
ENDIF;

# ---- Project
sProj = CELLGETS(cbLeaseDetails, vsVariation, vsLeaseNbr, 'Project');
IF(DIMIX(dmProj, sProj) = 0);
      sProj = '99999';
      sProj = ATTRS(dmProj, sProj, 'Code and Description');
       CELLPUTS(sProj, cbLeaseDetails, vsVariation, vsLeaseNbr, 'Project');
ENDIF;

# ---- Program
sProg = CELLGETS(cbLeaseDetails, vsVariation, vsLeaseNbr, 'Program');
IF(DIMIX(dmProg, sProg) = 0);
      sProg = '9999';
      sProg = ATTRS(dmProg, sProg, 'Code and Description');
       CELLPUTS(sProg, cbLeaseDetails, vsVariation, vsLeaseNbr, 'Program');
ENDIF;

#------------------------------------------------------------------------------
#    UPDATE MENU
#------------------------------------------------------------------------------
IF( DIMIX(dmStatus, sStatus) <> 0 & DIMIX(dmLeaseType, sLeaseType) <> 0 & DIMIX(dmReviewType, sReviewType) <> 0);
      CELLPUTN(1, cbLeaseMenu, sStatus, sLeaseType, sReviewType, vsLeaseNbr, 'Count');
ENDIF;

#--------------------------------------------------------------
#    VALIDATIONS
#--------------------------------------------------------------
IF(sStatus @= 'Deleted');
      nFlag = 1;
      CELLPUTS('Lease has been flagged as deleted', cbLeaseDetails, vsVariation, vsLeaseNbr, 'Validation');
ELSEIF(DIMIX(dmStatus, sStatus) = 0);
      nFlag = 1;
      CELLPUTS('Status is blank or invalid', cbLeaseDetails, vsVariation, vsLeaseNbr, 'Validation');
ELSE;
     nFlag = 0;
    CELLPUTS('PASS',cbLeaseDetails, vsVariation, vsLeaseNbr, 'Validation');
ENDIF;

IF(nFlag = 1);
      ITEMSKIP;
ENDIF;

#----------------------------------------------------------------------------------
#    POPULATE LEASE SCHEDULE
#----------------------------------------------------------------------------------

#--------------------------------------------------------------
#    RENT FREE PERIOD
#--------------------------------------------------------------
sRentFreePeriod = CELLGETS(cbLeaseDetails, vsVariation, vsLeaseNbr, 'Lease Free Period');
nRentFreeTerm = CELLGETN(cbLeaseDetails, vsVariation, vsLeaseNbr, 'Lease Free Period (Mths)') - 1;
IF(sRentFreePeriod @= 'Yes');

      sMth = sLeaseStartMth;
      sYear = sLeaseStartYr;
      nCounter = 1;

      WHILE(nCounter <= nRentFreeTerm);

            # ---- Lease Free Amount
            IF(nVarPeriod <= nCounter & sPrevVariation @<> '');
                  sEl = sPrevVariation;
            ELSE;
                  sEl = vsVariation;
            ENDIF; 
            nLeaseAmount = CELLGETN(cbLeaseSchedule, sYear, sEl, vsLeaseNbr, sMth, 'Lease Amount') + CELLGETN(cbLeaseSchedule, sYear, sEl, vsLeaseNbr, sMth, 'Lease One-Off Adjustment');
            CELLPUTN(nLeaseAmount * -1, cbLeaseSchedule, sYear, vsVariation, vsLeaseNbr, sMth, 'Lease Free Amount');
  
            #Get next month and year
            IF(sMth @= 'Jun');
                  sMth = 'Jul';
                  sYear = ATTRS(dmYear, sYear, 'Next');
            ELSE;
                  sMth = ATTRS(dmMth, sMth, 'Next');
            ENDIF;      

            nCounter = nCounter + 1;
      
      END;

ENDIF;

#--------------------------------------------------------------
#    RENT ABATEMENT
#--------------------------------------------------------------
sRentAbatement = CELLGETS(cbLeaseDetails, vsVariation, vsLeaseNbr, 'Rent Abatement');
nRentAbatement = CELLGETN(cbLeaseDetails, vsVariation, vsLeaseNbr, 'Rent Abatement Per Month');
nRentAbatementStart = CELLGETN(cbLeaseDetails, vsVariation, vsLeaseNbr, 'Rent Abatement Lease Start Month Number');
nRentAbatementTerm = CELLGETN(cbLeaseDetails, vsVariation, vsLeaseNbr, 'Rent Abatement Term (Mths)');
nRentAbatementEnd = nRentAbatementStart + nRentAbatementTerm - 1;

IF(sRentAbatement @= 'Yes');

      sMth = sLeaseStartMth;
      sYear = sLeaseStartYr;
      nCounter = 1;

      WHILE(nCounter <= nLeaseTerm);

            IF(nCounter >= nRentAbatementStart & nCounter <= nRentAbatementEnd);
                  CELLPUTN(nRentAbatement * -1, cbLeaseSchedule, sYear, vsVariation, vsLeaseNbr, sMth, 'Rent Abatement Amount');
            ENDIF;

            #Get next month and year
            IF(sMth @= 'Jun');
                  sMth = 'Jul';
                  sYear = ATTRS(dmYear, sYear, 'Next');
            ELSE;
                  sMth = ATTRS(dmMth, sMth, 'Next');
            ENDIF;      

            nCounter = nCounter + 1;
      
      END;

ENDIF;

#--------------------------------------------------------------
#    INITIAL ASSET AND LIABILITY
#--------------------------------------------------------------
sMth = sLeaseStartMth;
sYear = sLeaseStartYr;
nCounter = 1;
nLiability = 0;

WHILE(nCounter <= nLeaseTerm - 1 );

      # ---- Liability
      nLeaseAmount = CELLGETN(cbLeaseSchedule, sYear, vsVariation, vsLeaseNbr, sMth, 'Total Lease Amount'); 
      IF(nCounter < nVarPeriod & sPrevVariation @<> '');
            nNPV = CELLGETN( cbLeaseRep, sYear, sPrevVariation,sAllStatus, sAllLeaseType, sAllReviewType, vsLeaseNbr, sMth, 'NPV Nominal Payment');
      ELSE;
            IF(sPrevVariation @<> '' & nVarPeriod <> 0);
                  nNPV = ROUNDP(nLeaseAmount \ ((1 + nIntRate) ^ (nCounter - nVarPeriod + 1)), 2);
             ELSE;
                  nNPV = ROUNDP(nLeaseAmount \ ((1 + nIntRate) ^ nCounter), 2);
            ENDIF; 
      ENDIF;
      
      IF(sLeaseType @= 'Finance Lease');
            CELLPUTN(nNPV, cbLeaseRep, sYear, vsVariation, sStatus, sLeaseType, sReviewType, vsLeaseNbr, sMth, 'NPV Nominal Payment');
            nLiability = ROUNDP(nLiability + nNPV, 2);
      ELSE;
            nLiability = 0;
      ENDIF;

      # ---- Lease Payment
      CELLPUTN(nLeaseAmount * -1, cbLeaseRep, sYear, vsVariation, sStatus, sLeaseType, sReviewType, vsLeaseNbr, sMth, 'Lease Payment');

      # ---- Prior Variation NPV Revaluations
      IF(nCounter < nVarPeriod & sPrevVariation @<> '');
            nNPVReval = CELLGETN( cbLeaseRep, sYear, sPrevVariation,sAllStatus, sAllLeaseType, sAllReviewType, vsLeaseNbr, sMth, 'NPV Lease Payments');
            CELLPUTN(nNPVReval, cbLeaseRep, sYear, vsVariation, sStatus, sLeaseType, sReviewType, vsLeaseNbr, sMth, 'NPV Lease Payments');
      ENDIF;

      # ---- Lease Revenue
      nLeaseRevenue = nLeaseAmount * (1 + nMargin);
      nTotalRevenueAllocation = CELLGETN(cbLeaseRevenue, vsVariation, vsLeaseNbr, 'Employee Ids', 'Revenue Percentage');

      IF(nTotalRevenueAllocation > 0);

            CELLPUTN(nLeaseRevenue, cbLeaseRep, sYear, vsVariation, sStatus, sLeaseType, sReviewType, vsLeaseNbr, sMth, 'Lease Revenue');

            nComponents = ELCOMPN(dmID, 'Employee Ids');
            nCounter2 = 1;
            nTotalPerc = 0;

            WHILE(nCounter2 <= nComponents);

                  sID = ELCOMP(dmID, 'Employee Ids', nCounter2);
                  nPerc = CELLGETN(cbLeaseRevenue, vsVariation, vsLeaseNbr, sID, 'Revenue Percentage');

                  IF(nPerc > 0);

                        sInternalTrading = SUBST( CELLGETS(cbLeaseRevenue, vsVariation, vsLeaseNbr, sID, 'Internal Trading'), 1, 2);
                        nAllocation = nPerc * nLeaseRevenue;
                        CELLPUTN(nAllocation, cbLeaseRevenueRep, sYear, vsVariation, sStatus, sLeaseType, sReviewType, vsLeaseNbr, sInternalTrading, sMth, 'Lease Revenue');
                        nTotalPerc = nTotalPerc + nPerc;
                        IF(nTotalPerc >= 1);
                              nCounter2 = nComponents + 1;
                        ENDIF;     
                  ENDIF;

                  nCounter2 = nCounter2 + 1;

            END;

      ENDIF;

      # ---- Get next month and year
      IF(sMth @= 'Jun');
            sMth = 'Jul';
            sYear = ATTRS(dmYear, sYear, 'Next');
      ELSE;
            sMth = ATTRS(dmMth, sMth, 'Next');
      ENDIF;      

      nCounter = nCounter + 1;
      
END;

# ---- Create Liability
IF(nVarPeriod <> 0 & sPrevVariation @<> '');
      nLiability = CELLGETN(cbLeaseRep, sLeaseStartYr, sPrevVariation, sAllStatus, sAllLeaseType, sAllReviewType, vsLeaseNbr, sLeaseStartMth, 'NPV Lease Payments');
ENDIF;
CELLPUTN(nLiability, cbLeaseRep, sLeaseStartYr, vsVariation, sStatus, sLeaseType, sReviewType, vsLeaseNbr, sLeaseStartMth, 'NPV Lease Payments');

# ---- Lease End
CELLPUTS('Yes', cbLeaseSchedule, sYear, vsVariation, vsLeaseNbr, sMth, 'Lease End');

# ----  Provision for Makegood
IF(sLeaseType @= 'Finance Lease');

      nCounter = 1;
      sMeasure = 'Makegood Provision';

      WHILE(nCounter <= 10);
            sID = ELCOMP(dmID, 'Employee Ids', nCounter);
            sYr = CELLGETS(cbLeaseComponent, vsVariation, vsLeaseNbr, sMeasure,  sID, 'Year');
            sMth = CELLGETS(cbLeaseComponent, vsVariation, vsLeaseNbr, sMeasure,  sID, 'Month');
            nAmt = CELLGETN(cbLeaseComponent, vsVariation, vsLeaseNbr, sMeasure,  sID, 'Amount');
            IF(DIMIX(dmYear, sYr) <> 0 & DIMIX(dmMth, sMth) <> 0);
                  CELLINCREMENTN(nAmt, cbLeaseRep, sYr, vsVariation, sStatus, sLeaseType, sReviewType, vsLeaseNbr, sMth, sMeasure);
            ENDIF;
            nCounter = nCounter + 1;
      END;

ENDIF;

# ----  Direct Costs
nCounter = 1;
sMeasure = 'Direct Costs';

WHILE(nCounter <= 10);
      sID = ELCOMP(dmID, 'Employee Ids', nCounter);
      sYr = CELLGETS(cbLeaseComponent, vsVariation, vsLeaseNbr, sMeasure,  sID, 'Year');
      sMth = CELLGETS(cbLeaseComponent, vsVariation, vsLeaseNbr, sMeasure,  sID, 'Month');
      nAmt = CELLGETN(cbLeaseComponent, vsVariation, vsLeaseNbr, sMeasure,  sID, 'Amount');
      IF(DIMIX(dmYear, sYr) <> 0 & DIMIX(dmMth, sMth) <> 0);
            CELLINCREMENTN(nAmt, cbLeaseRep, sYr, vsVariation, sStatus, sLeaseType, sReviewType, vsLeaseNbr, sMth, 'Direct Lease Costs');
      ENDIF;
      nCounter = nCounter + 1;
END;


#--------------------------------------------------------------
#   ITEMSKIP IF NOT FINANCE LEASE
#--------------------------------------------------------------
IF(sLeaseType @<> 'Finance Lease');
      ITEMSKIP;
ENDIF;

#--------------------------------------------------------------
#   INTEREST EXPENSE
#--------------------------------------------------------------

sMth = sLeaseStartMth;
sYear = sLeaseStartYr;
nCounter = 1;

nIntExpense = ROUNDP(nIntRate * nLiability, 2);
CELLPUTN(nIntExpense, cbLeaseRep, sLeaseStartYr, vsVariation, sStatus, sLeaseType, sReviewType, vsLeaseNbr, sLeaseStartMth, 'Interest Expense');

WHILE(nCounter <= nLeaseTerm - 1);

      nClosingLiability = CELLGETN(cbLeaseRep, sYear, vsVariation, sAllStatus, sAllLeaseType, sAllReviewType, vsLeaseNbr, sMth, 'Closing Liability Balance');
     
      #Get next month and year
      IF(sMth @= 'Jun');
            sMth = 'Jul';
            sYear = ATTRS(dmYear, sYear, 'Next');
      ELSE;
            sMth = ATTRS(dmMth, sMth, 'Next');
      ENDIF;      

      # ---- Opening Liability
      CELLPUTN(nClosingLiability, cbLeaseRep, sYear, vsVariation, sStatus, sLeaseType, sReviewType, vsLeaseNbr, sMth, 'Opening Liability Balance');      

      # ---- Interest Exense
      IF(nCounter = nLeaseTerm);
            nIntExpense = CELLGETN(cbLeaseRep, sYear, vsVariation, sAllStatus, sAllLeaseType, sAllReviewType, vsLeaseNbr, sMth, 'Closing Liability Balance') * -1;
      ELSE;
            IF( nCounter < nVarPeriod & sPrevVariation @<> '');
                  nIntExpense = CELLGETN(cbLeaseRep, sYear, sPrevVariation, sAllStatus, sAllLeaseType, sAllReviewType, vsLeaseNbr, sMth, 'Interest Expense');
            ELSE;
                  nIntExpense = ROUNDP(nIntRate * (nClosingLiability), 2);
            ENDIF;
      ENDIF;
      CELLPUTN(nIntExpense, cbLeaseRep, sYear, vsVariation, sStatus, sLeaseType, sReviewType, vsLeaseNbr, sMth, 'Interest Expense');      

      nCounter = nCounter + 1;
      
END;

#--------------------------------------------------------------
#    NPV ADJUSTMENTS
#--------------------------------------------------------------
sMonth = sLeaseStartMth;
sYear = sLeaseStartYr;
nCounter = 1;

WHILE(nCounter <= nLeaseTerm);

      nOpeningLiability = CELLGETN(cbLeaseRep, sYear, vsVariation, sStatus, sLeaseType, sReviewType, vsLeaseNbr, sMonth, 'Opening Liability Balance');

      nTotalNPV = 0;
      sMth = sMonth;
      sYr = sYear;
      nRemainingTerm = nLeaseTerm - nCounter + 1;

      WHILE(nRemainingTerm > 0);

            nNPV = CELLGETN(cbLeaseRep, sYr, vsVariation, sAllStatus, sAllLeaseType, sAllReviewType, vsLeaseNbr, sMth, 'NPV Nominal Payment');
            nTotalNPV = nTotalNPV + nNPV;

            #Get next month and year
            IF(sMth @= 'Jun');
                  sMth = 'Jul';
                  sYr = ATTRS(dmYear, sYr, 'Next');
            ELSE;
                  sMth = ATTRS(dmMth, sMth, 'Next');
            ENDIF;      

            nRemainingTerm = nRemainingTerm - 1;

      END;      

      IF(nCounter >=  nVarPeriod & sPrevVariation @<> '');
            CELLPUTN(nTotalNPV, cbLeaseRep, sYear, vsVariation, sStatus, sLeaseType, sReviewType, vsLeaseNbr, sMonth, 'NPV Total Liability');
      ELSE;
            CELLPUTN(nOpeningLiability, cbLeaseRep, sYear, vsVariation, sStatus, sLeaseType, sReviewType, vsLeaseNbr, sMonth, 'NPV Total Liability');
      ENDIF;

      # ---- Get next month and year
      IF(sMonth @= 'Jun');
            sMonth = 'Jul';
            sYear = ATTRS(dmYear, sYear, 'Next');
      ELSE;
            sMonth = ATTRS(dmMth, sMonth, 'Next');
      ENDIF;      

      nCounter = nCounter + 1;
      
END;

sMonth = sLeaseStartMth;
sYear = sLeaseStartYr;
nCounter = 1;

WHILE(nCounter <= nLeaseTerm);

      nOpeningLiability = CELLGETN(cbLeaseRep, sYear, vsVariation, sAllStatus, sAllLeaseType, sAllReviewType, vsLeaseNbr, sMonth, 'Opening Liability Balance');
      nTotalNPV = CELLGETN(cbLeaseRep, sYear, vsVariation, sStatus, sLeaseType, sReviewType, vsLeaseNbr, sMonth, 'NPV Total Liability');
      nVariance = nTotalNPV - nOpeningLiability;

      IF(nCounter >=  nVarPeriod & sPrevVariation @<> '');
            CELLPUTN(nVariance, cbLeaseRep, sYear, vsVariation, sStatus, sLeaseType, sReviewType, vsLeaseNbr, sMonth, 'NPV Lease Payments');
            nCounter = nLeaseTerm + 1;
      ENDIF;

      # ---- Get next month and year
      IF(sMonth @= 'Jun');
            sMonth = 'Jul';
            sYear = ATTRS(dmYear, sYear, 'Next');
      ELSE;
            sMonth = ATTRS(dmMth, sMonth, 'Next');
      ENDIF;      

      nCounter = nCounter + 1;
      
END;

#--------------------------------------------------------------
#   RECALCULATE INTEREST EXPENSE
#--------------------------------------------------------------

sMth = sLeaseStartMth;
sYear = sLeaseStartYr;
nCounter = 1;

nIntExpense = ROUNDP(nIntRate * nLiability, 2);
CELLPUTN(nIntExpense, cbLeaseRep, sLeaseStartYr, vsVariation, sStatus, sLeaseType, sReviewType, vsLeaseNbr, sLeaseStartMth, 'Interest Expense');

WHILE(nCounter <= nLeaseTerm - 1);

      nClosingLiability = CELLGETN(cbLeaseRep, sYear, vsVariation,sAllStatus, sAllLeaseType, sAllReviewType, vsLeaseNbr, sMth, 'Closing Liability Balance');
     
      # ---- Get next month and year
      IF(sMth @= 'Jun');
            sMth = 'Jul';
            sYear = ATTRS(dmYear, sYear, 'Next');
      ELSE;
            sMth = ATTRS(dmMth, sMth, 'Next');
      ENDIF;      

      # ---- Opening Liability
      CELLPUTN(nClosingLiability, cbLeaseRep, sYear, vsVariation, sStatus, sLeaseType, sReviewType, vsLeaseNbr, sMth, 'Opening Liability Balance');      

      # ---- NPV Lease Payments
      nNPV = CELLGETN(cbLeaseRep, sYear, vsVariation, sAllStatus, sAllLeaseType, sAllReviewType, vsLeaseNbr, sMth, 'NPV Lease Payments');

      # ---- Interest Exense
      IF(nCounter = nLeaseTerm);
            nIntExpense = CELLGETN(cbLeaseRep, sYear, vsVariation, sAllStatus, sAllLeaseType, sAllReviewType, vsLeaseNbr, sMth, 'Closing Liability Balance') * -1;
      ELSE;
            IF( nCounter < nVarPeriod - 1 & sPrevVariation @<> '');
                  nIntExpense = CELLGETN(cbLeaseRep, sYear, sPrevVariation,sAllStatus, sAllLeaseType, sAllReviewType, vsLeaseNbr, sMth, 'Interest Expense');
            ELSE;
                  nIntExpense = ROUNDP(nIntRate * (nClosingLiability + nNPV), 2);
            ENDIF;
      ENDIF;

      CELLPUTN(nIntExpense, cbLeaseRep, sYear, vsVariation, sStatus, sLeaseType, sReviewType, vsLeaseNbr, sMth, 'Interest Expense');      

      nCounter = nCounter + 1;
      
END;

#--------------------------------------------------------------
#    DEPRECIATION
#--------------------------------------------------------------

sMth = sLeaseStartMth;
sYear = sLeaseStartYr;
nMths = nLeaseTerm;
nCounter = 1;
nAccDepn = 0;
nCount = nLeaseTerm;

WHILE(nCounter <= nLeaseTerm);   

      nAssetValue = CELLGETN(cbLeaseRep, sYear, vsVariation, sAllStatus, sAllLeaseType, sAllReviewType, vsLeaseNbr, sMth, 'Right-of-Use Asset');
  
      IF(nCounter < nVarPeriod & sPrevVariation @<> '');
            sEl = sPrevVariation;
      ELSE;
            sEl = vsVariation;
      ENDIF; 

      nTerm = CELLGETN(cbLeaseDetails, sEl, vsLeaseNbr, 'Lease Term (Mths)');
      nOption = CELLGETN(cbLeaseDetails, sEl, vsLeaseNbr, 'Option Term (Mths)');
      sOptionLikely = CELLGETS(cbLeaseDetails, sEl, vsLeaseNbr, 'Option Likely');
      IF(sOptionLikely @= 'Yes');
            nTerm = nTerm + nOption;
      ENDIF;
      nCount = nTerm - (nCounter - 1);

      # ---- Depreciation Charge

      IF(nCounter < nVarPeriod & sPrevVariation @<> '');
            nDepn = CELLGETN( cbLeaseRep, sYear, sPrevVariation, sAllStatus, sAllLeaseType, sAllReviewType, vsLeaseNbr, sMth, 'Depreciation Charge'); 
      ELSE;
           nDepn = ROUNDP(nAssetValue \ nCount, 2) * -1;
      ENDIF; 

      CELLPUTN(nDepn, cbLeaseRep, sYear, vsVariation, sStatus, sLeaseType, sReviewType, vsLeaseNbr, sMth, 'Depreciation Charge'); 

      nClosingAsset = CELLGETN(cbLeaseRep, sYear, vsVariation, sAllStatus, sAllLeaseType, sAllReviewType, vsLeaseNbr, sMth, 'Closing Gross Asset Balance');
      nAccDepn = CELLGETN(cbLeaseRep, sYear, vsVariation, sAllStatus, sAllLeaseType, sAllReviewType, vsLeaseNbr, sMth, 'Closing Balance Accumulated Depreciation');

      # ---- Get next month and year
      IF(sMth @= 'Jun');
            sMth = 'Jul';
            sYear = ATTRS(dmYear, sYear, 'Next');
      ELSE;
            sMth = ATTRS(dmMth, sMth, 'Next');
      ENDIF;      

      IF(nCounter < nLeaseTerm);
            # ---- Opening Asset
            CELLPUTN(nClosingAsset, cbLeaseRep, sYear, vsVariation, sStatus, sLeaseType, sReviewType, vsLeaseNbr, sMth, 'Opening Gross Asset Balance');     

            # ---- Opening Accumulated Depreciation
            CELLPUTN(nAccDepn, cbLeaseRep, sYear, vsVariation, sStatus, sLeaseType, sReviewType, vsLeaseNbr, sMth,  'Opening Balance Accumulated Depreciation');    
      ENDIF;

      nCounter = nCounter + 1;
     # nCount = nCount - 1;
      
END;

574,359

#****Begin: Generated Statements***
#****End: Generated Statements****

#============================================================
#    ********** POPULATE FINANCE LEASE COMMITMENTS CUBE ********** 
#============================================================

#--------------------------------------------------------------
#    LEASE PARAMETERS
#--------------------------------------------------------------
# ---- Execution Date    
sCommitmentStartYr = CELLGETS(cbLeaseDetails, vsVariation, vsLeaseNbr, 'Commitment Start Year');
sCommitmentStartMth = CELLGETS(cbLeaseDetails, vsVariation, vsLeaseNbr, 'Commitment Start Month');
sCommitmentStartDay = CELLGETS(cbLeaseDetails, vsVariation, vsLeaseNbr, 'Commitment Start Day');

# ---- Start Date    
sLeaseStartYr = CELLGETS(cbLeaseDetails, vsVariation, vsLeaseNbr, 'Lease Start Year');
sLeaseStartMth = CELLGETS(cbLeaseDetails, vsVariation, vsLeaseNbr, 'Lease Start Month');
sLeaseStartDay = CELLGETS(cbLeaseDetails, vsVariation, vsLeaseNbr, 'Lease Start Day');

# ----  Lease Term and Option
nLeaseTerm = CELLGETN(cbLeaseDetails, vsVariation, vsLeaseNbr, 'Lease Term (Mths)');
nOptionTerm = CELLGETN(cbLeaseDetails, vsVariation, vsLeaseNbr, 'Option Term (Mths)');
sOptionLikely = CELLGETS(cbLeaseDetails, vsVariation, vsLeaseNbr, 'Option Likely');
IF(sOptionLikely @= 'Yes');
      nLeaseTerm = nLeaseTerm + nOptionTerm;
ENDIF;
#nTermYrs = (ROUNDP(nLeaseTerm / 12, 0)) + 1;
nTermYrs = (ROUNDP(nLeaseTerm / 12, 0)) + 1 + DIMIX(dmYear, sLeaseStartYr) - DIMIX(dmYear, sCommitmentStartYr);

# ----  Interest Rate
nIntRate = CELLGETN(cbLeaseDetails, vsVariation, vsLeaseNbr, 'Interest Rate')  / 12;

# ----  Lease Type
sLeaseType = CELLGETS(cbLeaseDetails, vsVariation, vsLeaseNbr, 'Lease Type');
IF( ELISANC(dmVariation, 'Budget Variations', vsVariation) = 1 & sLeaseType @<> 'Operating Lease');
      sLeaseType = 'Finance Lease';
ENDIF;

# ----  Review Type
sReviewType = CELLGETS(cbLeaseDetails, vsVariation, vsLeaseNbr, 'Lease Review Type');

# ----  Status
sStatus = CELLGETS(cbLeaseDetails, vsVariation, vsLeaseNbr, 'Status');

# ---- Previous Variation
IF(vsVariation @= 'Variation 1');
      sPrevVariation = '';
ELSEIF(ELISANC(dmVariation, 'Budget Variations', vsVariation) = 1);
      sPrevVariation = CELLGETS(cbLeaseDetails, vsVariation, vsLeaseNbr, 'Previous Variation');
ELSE;
      sPrevVariation = ATTRS(dmVariation, vsVariation, 'Prev');
ENDIF;

# ---- Variation Period
nVarPeriod = CELLGETN(cbLeaseDetails, vsVariation, vsLeaseNbr, 'Variation Period');

# ---- Revenue Allocation
nTotalRevenueAllocation = CELLGETN(cbLeaseRevenue, vsVariation, vsLeaseNbr, 'Employee Ids', 'Revenue Percentage');

#--------------------------------------------------------------
#    POPULATE LEASE SCHEDULE
#--------------------------------------------------------------

sHLYear = sCommitmentStartYr;
nHLCounter = 1;

WHILE(nHLCounter <= nTermYrs);

      IF(DIMIX(dmYear, sHLYear) <> 0 & DIMIX(dmYear, ATTRS(dmYear, sHLYear, 'Next')) <> 0);

            #--------------------------------------------------------------
            #    Within 1 Year
            #--------------------------------------------------------------

            IF( sHLYear @= sCommitmentStartYr);
                  nCounter = ATTRN(dmMth, sCommitmentStartMth, 'Period Number');
            ELSE;
                  nCounter = 1;
            ENDIF;
            nComponents = ELCOMPN(dmMth, 'Jun YTD');

            WHILE(nCounter <= nComponents);

                  sPeriod = sHLYear;
                  sRepMonth = ELCOMP(dmMth, 'Jun YTD', nCounter);

                  IF(sRepMonth @= 'Jun');
                        sMonth = 'Jul';
                        sPeriod = ATTRS(dmYear, sPeriod, 'Next');
                  ENDIF;   

                  IF(nCounter <=  nVarPeriod - 1  & sPrevVariation @<> '');
                        sEl = vsVariation;
                        #sEl = sPrevVariation;
                  ELSE;
                        sEl = vsVariation;
                  ENDIF; 

                  nLeasePmt =  CELLGETN(cbLeaseRep, sPeriod,  sEl, sAllStatus, sAllLeaseType, sAllReviewType, vsLeaseNbr, sRepMonth, 'Lease Payment');

                  IF(nLeasePmt <> 0);

                        sStartMonth = sRepMonth;
                        nLeasePmt = 0;
                        nIntExpense = 0;
                        nLeaseRevenue = 0;
                        sMonth = sRepMonth;
                        nCounter2 = 0;

                        WHILE(nCounter2 <= 11);

                              IF(sMonth @= 'Jun');
                                    sPeriod = ATTRS(dmYear, sHLYear, 'Next');
                                    sMonth = 'Jul';
                              ELSE;
                                      sMonth = ATTRS(dmMth, sMonth, 'Next');
                              ENDIF; 

                              # Lease Payment
                              nPmt = CELLGETN(cbLeaseRep, sPeriod,  sEl, sAllStatus, sAllLeaseType, sAllReviewType, vsLeaseNbr, sMonth, 'Lease Payment');

                              nLeasePmt = nLeasePmt + nPmt;

                              # Interest Expense
                              nInt = CELLGETN(cbLeaseRep,  sPeriod,  sEl, sAllStatus, sAllLeaseType, sAllReviewType, vsLeaseNbr, sMonth, 'Interest Expense');
                              nIntExpense = nIntExpense + nInt;

                              # Lease Revenue
                              nRevenue = CELLGETN(cbLeaseRep, sPeriod,  sEl, sAllStatus, sAllLeaseType, sAllReviewType, vsLeaseNbr, sMonth, 'Lease Revenue');
                              nLeaseRevenue = nLeaseRevenue + nRevenue;

                              nCounter2 = nCounter2 + 1; 

                        END;
                                     
                    ENDIF;

                    IF(DIMIX(dmYear, sPeriod) <> 0);

                        # Lease Payment
                        nLeasePmt = nLeasePmt * -1;
                        CELLPUTN(nLeasePmt, cbLeaseCommitment, sHLYear, vsVariation, sStatus, sLeaseType, sReviewType, 'Lease Payments', vsLeaseNbr, sRepMonth, 'Within 1 year');

                        # Interest Expense
                        nIntExpense = nIntExpense * -1;
                        CELLPUTN(nIntExpense, cbLeaseCommitment, sHLYear,  vsVariation, sStatus, sLeaseType, sReviewType, 'Finance Lease Charges', vsLeaseNbr, sRepMonth, 'Within 1 year');

                        # Lease Revenue
                        IF( nTotalRevenueAllocation > 0);
                              CELLPUTN(nLeaseRevenue, cbLeaseCommitment, sHLYear,  vsVariation, sStatus, sLeaseType, sReviewType, 'Lease Revenue', vsLeaseNbr, sRepMonth, 'Within 1 year');
                        ENDIF;

                  ENDIF;

                  IF(sLeaseType @= 'Finance Lease');
                        # Current Liability
                        nLiability = CELLGETN( cbLeaseCommitment, sHLYear,  vsVariation, sStatus, sLeaseType, sReviewType, 'Present Value Lease Payments', vsLeaseNbr, sRepMonth, 'Within 1 year');
                        CELLPUTN(nLiability, cbLeaseCommitment, sHLYear, vsVariation, sStatus, sLeaseType, sReviewType, 'Current Liability', vsLeaseNbr, sRepMonth, 'Within 1 year');
                  ENDIF;

                  nCounter = nCounter + 1;

            END;

            #--------------------------------------------------------------
            #    1 - 5 Years
            #--------------------------------------------------------------

            IF(nHLCounter = 1);
                  nCounter = ATTRN(dmMth, sCommitmentStartMth, 'Period Number');
            ELSE;
                  nCounter = 1;
            ENDIF;

            nComponents = ELCOMPN(dmMth, 'Jun YTD');
            sMonth = ATTRS(dmMth, sLeaseStartMth, 'Next');
            sPeriod = ATTRS(dmYear, sHLYear, 'Next');

            WHILE(nCounter <= nComponents);

                  sRepMonth = ELCOMP(dmMth, 'Jun YTD', nCounter);
                  sPeriod = ATTRS(dmYear, sHLYear, 'Next');
                  sMonth = ATTRS(dmMth, sRepMonth, 'Next');
                  IF(sRepMonth @= 'Jun');
                        sMonth = 'Jul';
                        sPeriod = ATTRS(dmYear, sPeriod, 'Next');
                  ENDIF;   

                  IF(nCounter <= nVarPeriod - 1  & sPrevVariation @<> '');
                        sEl = vsVariation;
                        #sEl = sPrevVariation;
                  ELSE;
                        sEl = vsVariation;
                  ENDIF; 

                  nCounter2 = 1;
                  nLeasePmt = 0;
                  nIntExpense = 0;
                  nLeaseRevenue = 0;

                  WHILE(nCounter2 <= 48); 

                        # Lease Payment
                        nPmt = CELLGETN(cbLeaseRep, sPeriod,  sEl,sAllStatus, sAllLeaseType, sAllReviewType, vsLeaseNbr, sMonth, 'Lease Payment');
                        nLeasePmt = nLeasePmt + nPmt;

                        # Interest Expense
                        nInt = CELLGETN(cbLeaseRep,  sPeriod,  sEl, sAllStatus, sAllLeaseType, sAllReviewType, vsLeaseNbr, sMonth, 'Interest Expense');
                        nIntExpense = nIntExpense + nInt;

                        # Lease Revenue
                        nRevenue = CELLGETN(cbLeaseRep, sPeriod,  sEl, sAllStatus, sAllLeaseType, sAllReviewType, vsLeaseNbr, sMonth, 'Lease Revenue');
                        nLeaseRevenue = nLeaseRevenue + nRevenue;

                        IF(sMonth @= 'Jun');
                              sPeriod = ATTRS(dmYear, sPeriod, 'Next');
                              sMonth = 'Jul';
                        ELSE;
                              sMonth = ATTRS(dmMth, sMonth, 'Next');
                        ENDIF; 

                        nCounter2 = nCounter2 + 1;

                  END;

                  # Lease Payment
                  nLeasePmt = nLeasePmt * -1;
                  CELLPUTN(nLeasePmt, cbLeaseCommitment, sHLYear, vsVariation, sStatus, sLeaseType, sReviewType,  'Lease Payments', vsLeaseNbr, sRepMonth, '1 - 5 years');

                  # Interest Expense
                  nIntExpense = nIntExpense * -1;
                  CELLPUTN(nIntExpense, cbLeaseCommitment, sHLYear,  vsVariation, sStatus, sLeaseType, sReviewType,  'Finance Lease Charges', vsLeaseNbr, sRepMonth, '1 - 5 years');

                  # Lease Revenue
                  IF( nTotalRevenueAllocation > 0);
                        CELLPUTN(nLeaseRevenue, cbLeaseCommitment, sHLYear,  vsVariation, sStatus, sLeaseType, sReviewType,  'Lease Revenue', vsLeaseNbr, sRepMonth, '1 - 5 years');
                  ENDIF;

                  # Current Liability
                  IF(sLeaseType @= 'Finance Lease');
                        nLiability = CELLGETN( cbLeaseCommitment, sHLYear,  vsVariation, sAllStatus, sAllLeaseType, sAllReviewType,  'Present Value Lease Payments', vsLeaseNbr, sRepMonth, '1 - 5 years');
                        CELLPUTN(nLiability, cbLeaseCommitment, sHLYear, vsVariation, sStatus, sLeaseType, sReviewType, 'Non-Current Liability', vsLeaseNbr, sRepMonth, '1 - 5 years');
                  ENDIF;

                  nCounter = nCounter + 1;

            END;

           #--------------------------------------------------------------
           #    More than 5 Years
            #--------------------------------------------------------------

            IF(nHLCounter = 1);
                  nCounter = ATTRN(dmMth, sCommitmentStartMth, 'Period Number');
            ELSE;
                  nCounter = 1;
            ENDIF;

            nComponents = ELCOMPN(dmMth, 'Jun YTD');

            WHILE(nCounter <= nComponents);

                  sRepMonth = ELCOMP(dmMth, 'Jun YTD', nCounter);
                  sPeriod = sHLYear; 

                  nYr = 1;
                  WHILE(nYr <= 5);
                        sPeriod = ATTRS(dmYear, sPeriod, 'Next');
                        nYr = nYr + 1;
                  END;
                  sMonth = ATTRS(dmMth, sRepMonth, 'Next');
                  IF(sRepMonth @= 'Jun');
                        sMonth = 'Jul';
                        sPeriod = ATTRS(dmYear, sPeriod, 'Next');
                  ENDIF;   

                  IF(nCounter <= nVarPeriod - 1 & sPrevVariation @<> '');
                        #sEl = sPrevVariation;
                        sEl = vsVariation;
                  ELSE;
                        sEl = vsVariation;
                  ENDIF; 

                  IF( nHLCounter = 1);
                        sPeriod = ATTRS(dmYear, sPeriod, 'Prev');
                        nPeriod = CELLGETN(cbLeaseSchedule, sPeriod, vsVariation, vsLeaseNbr, sRepMonth, 'Period Count'); 
                        sPeriod = ATTRS(dmYear, sPeriod, 'Next');
                  ELSE;
                        nPeriod = CELLGETN(cbLeaseSchedule, sHLYear, vsVariation, vsLeaseNbr, sRepMonth, 'Period Count'); 
                  ENDIF;

                  nCounter2 = nPeriod; 
                  IF(nPeriod = 0);
                        nCounter2 = nLeaseTerm + 1;
                  ENDIF; 
                  #nCounter2 = 1;
                  nLeasePmt = 0;
                  nIntExpense = 0;
                  nLeaseRevenue = 0;

                  WHILE(nCounter2 <= nLeaseTerm);

                        # Lease Payment
                        nPmt = CELLGETN(cbLeaseRep, sPeriod, sEl, sAllStatus, sAllLeaseType, sAllReviewType, vsLeaseNbr, sMonth, 'Lease Payment');
                        nLeasePmt = nLeasePmt + nPmt;

                        # Interest Expense
                        nInt = CELLGETN(cbLeaseRep,  sPeriod, sEl, sAllStatus, sAllLeaseType, sAllReviewType, vsLeaseNbr, sMonth, 'Interest Expense');
                        nIntExpense = nIntExpense + nInt;

                        # Lease Revenue
                        nRevenue = CELLGETN(cbLeaseRep, sPeriod,  sEl, sAllStatus, sAllLeaseType, sAllReviewType, vsLeaseNbr, sMonth, 'Lease Revenue');
                        nLeaseRevenue = nLeaseRevenue + nRevenue;

                        IF(sMonth @= 'Jun');
                              sPeriod = ATTRS(dmYear, sPeriod, 'Next');
                              sMonth = 'Jul';
                        ELSE;
                              sMonth = ATTRS(dmMth, sMonth, 'Next');
                        ENDIF; 

                        nCounter2 = nCounter2 + 1;

                  END;

                  # Lease Payment
                  nLeasePmt = nLeasePmt * -1;
                  CELLPUTN(nLeasePmt, cbLeaseCommitment, sHLYear, vsVariation, sStatus, sLeaseType, sReviewType,  'Lease Payments', vsLeaseNbr, sRepMonth, 'More than 5 years');


                  # Interest Expense
                  nIntExpense = nIntExpense * -1;
                  CELLPUTN(nIntExpense, cbLeaseCommitment, sHLYear, vsVariation, sStatus, sLeaseType, sReviewType,  'Finance Lease Charges', vsLeaseNbr, sRepMonth, 'More than 5 years');

                  # Lease Revenue
                  IF( nTotalRevenueAllocation > 0);
                        CELLPUTN(nLeaseRevenue, cbLeaseCommitment, sHLYear,  vsVariation, sStatus, sLeaseType, sReviewType,  'Lease Revenue', vsLeaseNbr, sRepMonth, 'More than 5 years');
                  ENDIF;

                  # Non-Current Liability
                  IF(sLeaseType @= 'Finance Lease');
                        nLiability = CELLGETN( cbLeaseCommitment, sHLYear, vsVariation, sAllStatus, sAllLeaseType, sAllReviewType,  'Present Value Lease Payments', vsLeaseNbr, sRepMonth, 'More than 5 years');
                        CELLPUTN(nLiability, cbLeaseCommitment, sHLYear, vsVariation, sStatus, sLeaseType, sReviewType, 'Non-Current Liability', vsLeaseNbr, sRepMonth, 'More than 5 years');
                  ENDIF;

                  nCounter = nCounter + 1;

            END;

            sHLYear = ATTRS(dmYear, sHLYear, 'Next');

      ENDIF;

      nHLCounter = nHLCounter + 1;

END;

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
