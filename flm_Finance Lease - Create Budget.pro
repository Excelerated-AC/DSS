601,100
602,"flm_Finance Lease - Create Budget"
562,"VIEW"
586,"flm_Finance Lease Menu"
585,"flm_Finance Lease Menu"
564,
565,"oQhuB7hpwTZDZjpaSUIp=g3cO=4HyX73`J=LofyzxoEm`8jel`BNH]gC@6eC]]YUB[:n]P>H::sZmhldV2Z>F<5m3PuUm?Uv1_uRT9;CCQ`?V[l8P5^QeGrcRYs]QyF1eYSNgub`9YayVEWNeCx9f]J2B9p16>XCSDg_Xsy_srYW\0m`n51vdg>z`nCa:iSNigsXcyaL"
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
570,$CreateBudget
571,$CreateBudget
569,0
592,0
599,1000
560,5
psVariation
psLeaseNbr
psLeaseType
psReviewType
psStatus
561,5
2
2
2
2
2
590,5
psVariation,"Test"
psLeaseNbr,"All Lease Numbers"
psLeaseType,"All Lease Types"
psReviewType,"All Review Types"
psStatus,"All Lease Status"
637,5
psVariation,""
psLeaseNbr,""
psLeaseType,""
psReviewType,""
psStatus,""
577,9
vsLeaseStatus
vsLeaseType
vsReviewType
vsLeaseNbr
vsMeasure
vnValue
NVALUE
SVALUE
VALUE_IS_STRING
578,9
2
2
2
2
2
1
1
2
1
579,9
1
2
3
4
5
6
0
0
0
580,9
0
0
0
0
0
0
0
0
0
581,9
0
0
0
0
0
0
0
0
0
582,6
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=33ColType=827
603,0
572,165

#****Begin: Generated Statements***
#****End: Generated Statements****

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#
# Process:            flm_Finance Lease - Create Options
#
# Purpose:            This process creates 4 Lease Options
#
#                           It will copy data from 1 part of a cube to another by calling vm_Version Manager - Slave
#                           It takes a number of parameters in the parameters tab and converts then into the required
#                           parameters for the called processes.
#                           It passes 3 parameters sCube, srcParams and destParams to these processes.
#                           srcParams and destParama are both of the form 'Dim1;Element1|Dim2;Element2|...|Dimn;Elementn'.
#                                  There can only be 1 element selected for each dimension.
#                           The process can work on any cube with 3 to 15 dimensions, but can be modified to work on less or
#                            more if required
#
# Written by:         Rodney Richardson (EC)
#
# Date:                 09 June 2020 
#
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#-----------------------------------------------------------------------------
#    CUBES
#-----------------------------------------------------------------------------
cbLeaseDetails = 'flm_Finance Lease Details';
cbLeaseSchedule = 'flm_Finance Lease Schedule';
cbLeaseVariations = 'flm_Finance Lease Variations';
cbLeaseComponent = 'flm_Finance Lease Components';
cbLeaseMenu = 'flm_Finance Lease Menu';
cbLeaseRevenue = 'flm_Finance Lease Revenue';
cbLeaseRevenueRep = 'flm_Finance Lease Revenue Reporting';
cbClient = 'sys_Client Preferences';

#-----------------------------------------------------------------------------
#    DIMENSIONS
#-----------------------------------------------------------------------------
dmClient = '}Clients';
dmVariation = 'Lease Variation';
dmLeaseNbr = 'Lease Number';
dmStatus = 'Lease Status';
dmLeaseType = 'Lease Type';
dmReviewType = 'Lease Review Type';
dmMonth = 'Month';

#-----------------------------------------------------------------------------
#    OTHER PARAMETERS
#-----------------------------------------------------------------------------
IF(DIMIX(dmClient, TM1User) = 0);
      sUser = 'Admin';
ELSE;
      sUser = ATTRS(dmClient, TM1User, 'Non_CAM_ID');
ENDIF;
sProcess = 'vm_Version Manager - Slave';
Object = '$CreateBudget';

#-----------------------------------------------------------------------------
#    ADD NEW BUDGET VARIATION
#-----------------------------------------------------------------------------
IF(psVariation @= '');
      PROCESSBREAK;
ENDIF;

IF(DIMIX(dmVariation, psVariation) = 0);
      DIMENSIONELEMENTCOMPONENTADD(dmVariation, 'Budget Variations', psVariation, 1);
ENDIF;

#-----------------------------------------------------------------------------
#    GET TODAYS DATE
#-----------------------------------------------------------------------------
sYear = SUBST(TODAY(1), 1, 4);
sMonth =  SUBST(TODAY(1), 6, 2);
IF(SUBST(sMonth, 1, 1) @= '0');
      sMonth = SUBST(sMonth, 2, 1);
ENDIF;

IF( DIMIX(dmMonth, sMonth) <> 0);
      sMonth =DIMNM(dmMonth, DIMIX(dmMonth, sMonth) + 6);
ENDIF;
sDay = SUBST(TODAY(1), 9, 2);
sDate = sDay | ' ' | sMonth | ' ' | sYear;

#-----------------------------------------------------------------
#    DELETE ANY VIEWS AND SUBSETS
#-----------------------------------------------------------------
VIEWDESTROY(cbLeaseMenu, Object);
SUBSETDESTROY(dmStatus, Object);
SUBSETDESTROY(dmLeaseType, Object);
SUBSETDESTROY(dmReviewType, Object);
SUBSETDESTROY(dmLeaseNbr, Object);

#-----------------------------------------------------------------------------
#    CREATE SOURCE VIEW
#-----------------------------------------------------------------------------

# ---- CREATE REQUIRED SUBSETS

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

# ---- Lease Type
sDim = dmLeaseType;
sParent = psLeaseType;
SUBSETCREATE(sDim, Object);
IF (DTYPE(sDim, sParent) @='N');
      SUBSETELEMENTINSERT (sDim, Object, sParent, 1);
ELSE;
      sMDX = '{TM1FILTERBYLEVEL( {TM1DRILLDOWNMEMBER( {[' | sDim | '].[' | sParent | ']}, ALL, RECURSIVE )}, 0)}';
      SUBSETMDXSET(sDim, Object, sMDX);
      SUBSETMDXSET(sDim, Object, '');
ENDIF;

# ---- Review Type
sDim = dmReviewType;
sParent = psReviewType;
SUBSETCREATE(sDim, Object);
IF (DTYPE(sDim, sParent) @='N');
      SUBSETELEMENTINSERT (sDim, Object, sParent, 1);
ELSE;
      sMDX = '{TM1FILTERBYLEVEL( {TM1DRILLDOWNMEMBER( {[' | sDim | '].[' | sParent | ']}, ALL, RECURSIVE )}, 0)}';
      SUBSETMDXSET(sDim, Object, sMDX);
      SUBSETMDXSET(sDim, Object, '');
ENDIF;

# ---- Lease Status
sDim = dmStatus;
sParent = psStatus;
SUBSETCREATE(sDim, Object);
IF (DTYPE(sDim, sParent) @='N');
      SUBSETELEMENTINSERT (sDim, Object, sParent, 1);
ELSE;
      sMDX = '{TM1FILTERBYLEVEL( {TM1DRILLDOWNMEMBER( {[' | sDim | '].[' | sParent | ']}, ALL, RECURSIVE )}, 0)}';
      SUBSETMDXSET(sDim, Object, sMDX);
      SUBSETMDXSET(sDim, Object, '');
ENDIF;

# ---- CREATE VIEW

VIEWCREATE(cbLeaseMenu, Object);
VIEWSUPPRESSZEROESSET(cbLeaseMenu, Object, 1);
VIEWSUBSETASSIGN(cbLeaseMenu, Object, dmLeaseNbr, Object);
VIEWSUBSETASSIGN(cbLeaseMenu, Object, dmLeaseType, Object);
VIEWSUBSETASSIGN(cbLeaseMenu, Object, dmReviewType, Object);
VIEWSUBSETASSIGN(cbLeaseMenu, Object, dmStatus, Object);

#--------------------------------------------------------------------
#    SET DATASOURCE
#--------------------------------------------------------------------
DATASOURCENAMEFORSERVER = cbLeaseMenu;
DATASOURCENAMEFORCLIENT = cbLeaseMenu;
DATASOURCETYPE = 'VIEW';
DATASOURCECUBEVIEW = Object; 

573,6

#****Begin: Generated Statements***
#****End: Generated Statements****



574,61

#****Begin: Generated Statements***
#****End: Generated Statements****


#-----------------------------------------------------------------------------
#    GET LATEST VARIATION
#-----------------------------------------------------------------------------
nLatestVariation = CELLGETN(cbLeaseVariations, vsLeaseNbr, 'Number of variations');
sLatestVariation = 'Variation ' | NUMBERTOSTRING(nLatestVariation);

sProcess = 'vm_Version Manager - Slave';

#-----------------------------------------------------------------------------
#    COPY FINANCE LEASE DETAILS
#-----------------------------------------------------------------------------
sCube = cbLeaseDetails;
EXECUTEPROCESS(sProcess,  'sCube', sCube, 'srcParams', 'Lease Variation;' | sLatestVariation | '|Lease Number;' | vsLeaseNbr, 'destParams', 'Lease Variation;' | psVariation | '|Lease Number;' | vsLeaseNbr | '|');

#-----------------------------------------------------------------------------
#    COPY FINANCE LEASE SCHEDULE
#-----------------------------------------------------------------------------
sCube = cbLeaseSchedule;
EXECUTEPROCESS(sProcess, 'sCube', sCube, 'srcParams', 'LeaseVariation;' | sLatestVariation | '|Lease Number;' | vsLeaseNbr, 'destParams', 'Lease Variation;' | psVariation | '|Lease Number;' | vsLeaseNbr | '|');

#-----------------------------------------------------------------------------
#    COPY FINANCE LEASE REVENUE
#-----------------------------------------------------------------------------
sCube = cbLeaseRevenue;
EXECUTEPROCESS(sProcess, 'sCube', sCube, 'srcParams', 'LeaseVariation;' | sLatestVariation | '|Lease Number;' | vsLeaseNbr, 'destParams', 'Lease Variation;' | psVariation | '|Lease Number;' | vsLeaseNbr | '|');

#-----------------------------------------------------------------------------
#    COPY FINANCE LEASE COMPONENTS
#-----------------------------------------------------------------------------
sCube = cbLeaseComponent;
EXECUTEPROCESS(sProcess,  'sCube', sCube, 'srcParams', 'Lease Variation;' | sLatestVariation | '|Lease Number;' | vsLeaseNbr, 'destParams', 'Lease Variation;' | psVariation | '|Lease Number;' | vsLeaseNbr | '|');

#-----------------------------------------------------------------------------
#    UPDATE FINANCE LEASE VARIATIONS
#-----------------------------------------------------------------------------
# ---- PickList
sCurrentPicklist = CELLGETS(cbLeaseVariations, vsLeaseNbr, 'Picklist');
IF(SCAN(psVariation, sCurrentPicklist) = 0);
      sNewPicklist = sCurrentPicklist | ':' | psVariation;
      CELLPUTS(sNewPicklist, cbLeaseVariations, vsLeaseNbr, 'Picklist');
ENDIF;

# ---- Created By
CELLPUTS(sUser, cbLeaseDetails, psVariation, vsLeaseNbr, 'Created By');

# ---- Date Created
CELLPUTS(sDate, cbLeaseDetails, psVariation, vsLeaseNbr, 'Date Created');

# ---- Variation Status
CELLPUTS('Current', cbLeaseDetails, psVariation, vsLeaseNbr, 'Variation Status');

# ---- Previous Variation
CELLPUTS(sLatestVariation, cbLeaseDetails, psVariation, vsLeaseNbr, 'Previous Variation');



575,19

#****Begin: Generated Statements***
#****End: Generated Statements****


#-----------------------------------------------------------------
#    DELETE VIEWS AND SUBSETS
#-----------------------------------------------------------------
VIEWDESTROY(cbLeaseMenu, Object);
SUBSETDESTROY(dmStatus, Object);
SUBSETDESTROY(dmLeaseType, Object);
SUBSETDESTROY(dmReviewType, Object);
SUBSETDESTROY(dmLeaseNbr, Object);

#-----------------------------------------------------------------------------
#    POPULATE LEASE SCHEDULE
#-----------------------------------------------------------------------------
sProcess = 'flm_Finance Lease - Update Lease Schedule';
EXECUTEPROCESS(sProcess, 'psLeaseNbr', psLeaseNbr, 'psVariation', psVariation);
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
