601,100
602,"flm_Finance Lease - Create New Lease"
562,"NULL"
586,
585,
564,
565,"kPq_uhDruwYa59q1C7il_L\ZmkgvERHwXZDUHQsoV<E<:OAAmW\;ygeNF^KqeP7@Mie3VMrx5l;Bh2>Nic>ai@Ll0I@10rTkU8u[Oh<@eNxaFJo@zp@ulpYOKSU[EbOk;lrkHmc>DE=Nev7ZyElb9589cR:jn>Uvy[LMBjm7m4uhjL]g?Ag`MotY?5Mm<=\c3q3FB;`6"
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
589,","
568,""""
570,
571,
569,0
592,0
599,1000
560,0
561,0
590,0
637,0
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,168

#****Begin: Generated Statements***
#****End: Generated Statements****

#*********************************************************************************************************************
#**** PROCESS:               
#**** DESCRIPTION:       This process creates a new Lease element and populates the lease schedule
#****
#****
#**** MODIFICATION HISTORY:
#****
#****  Date               Initials        Comments
#****  ====              ======      =========
#**** 05/06/2020    RJR          Initial Revision
#****
#***********************************************************************************************************************

#-------------------------------------------------------------------------------------------
#    CUBES
#-------------------------------------------------------------------------------------------
cbLeaseMenu = 'flm_Finance Lease Menu';
cbLeaseDetails = 'flm_Finance Lease Details';
cbLeaseVariations = 'flm_Finance Lease Variations';
cbLeaseSchedule = 'flm_Finance Lease Schedule';
cbClientPref = 'sys_Client Preferences';
cbVariable = 'sys_Variable';

#-------------------------------------------------------------------------------------------
#      DIMENSIONS
#-------------------------------------------------------------------------------------------
dmYear = 'Year';
dmVariation = 'Lease Variation';
dmLeaseNbr = 'Lease Number';
dmStatus = 'Lease Status';
dmLeaseType = 'Lease Type';
dmReviewType = 'Lease Review Type';
dmMonth = 'Month';
dmGroup = '}Groups';
dmClient = '}Clients';

#-------------------------------------------------------------------------------------------
#    OTHER PARAMETERS
#-------------------------------------------------------------------------------------------
sUser = TM1User;
sCreatedBy = ATTRS(dmClient, TM1User, 'Non_CAM_ID');
sLeaseDescription = CELLGETS(cbClientPref, sUser, 'flm_Lease Description');
sVariation = 'Variation 1';
sBuildingParent = CELLGETS(cbClientPref, sUser, 'flm_Building Parent');
sNewBuildingParent = CELLGETS(cbClientPref, sUser, 'flm_New Building Parent');
sLeaseType = CELLGETS(cbClientPref, sUser, 'flm_Lease Type');
sReviewType = CELLGETS(cbClientPref, sUser, 'flm_Lease Review Type');
sStartYr = CELLGETS(cbClientPref, sUser, 'flm_Lease Start Year');
sStartMth = CELLGETS(cbClientPref, sUser, 'flm_Lease Start Month');
sStartDay = CELLGETS(cbClientPref, sUser, 'flm_Lease Start Day');
sCommitmentYr = CELLGETS(cbClientPref, sUser, 'flm_Commitment Start Year');
sCommitmentMth = CELLGETS(cbClientPref, sUser, 'flm_Commitment Start Month');
sCommitmentDay = CELLGETS(cbClientPref, sUser, 'flm_Commitment Start Day');
nStartAmount = ROUNDP(CELLGETN(cbClientPref, sUser, 'flm_Lease Start Amount') / 12, 2);
nLeaseTerm = CELLGETN(cbClientPref, sUser, 'flm_Lease Term (Mths)');
nInterestRate = CELLGETN(cbClientPref, sUser, 'flm_Interest Rate');
nCPIRate = CELLGETN(cbClientPref, sUser, 'flm_CPI Rate');
sStatus = CELLGETS(cbClientPref, sUser, 'flm_Status');
sYear = SUBST(TODAY(1), 1, 4);
sMonth =  SUBST(TODAY(1), 6, 2);
IF(SUBST(sMonth, 1, 1) @= '0');
      sMonth = SUBST(sMonth, 2, 1);
ENDIF;

IF( DIMIX(dmMonth, sMonth) <> 0);
      sMonth = DIMNM(dmMonth, DIMIX(dmMonth, sMonth) + 6);
ENDIF;
sDay = SUBST(TODAY(1), 9, 2);
sDate = sDay | ' ' | sMonth | ' ' | sYear;

#-------------------------------------------------------------------------------------------
#    ASSIGN LEASE NUMBER
#-------------------------------------------------------------------------------------------
sNextLeaseNumber = CELLGETS(cbVariable, 'flm_Next Lease Number', 'sValue');

IF(LONG(sNextLeaseNumber) = 1);
      sLeaseNbr = 'FLM0000' | sNextLeaseNumber;
ELSEIF(LONG(sNextLeaseNumber) = 2);
      sLeaseNbr = 'FLM000' | sNextLeaseNumber;
ELSEIF(LONG(sNextLeaseNumber) = 3);
      sLeaseNbr = 'FLM00' | sNextLeaseNumber;
ELSEIF(LONG(sNextLeaseNumber) = 4);
      sLeaseNbr = 'FLM0' | sNextLeaseNumber;
ELSEIF(sNextLeaseNumber @= '');
      sNextLeaseNumber = '1';
      sLeaseNbr = 'FLM0000' | sNextLeaseNumber;
ELSE;
      sLeaseNbr = 'FLM' | sNextLeaseNumber;
ENDIF;

#-------------------------------------------------------------------------------------------
#    SYNCHRONISATION
#-------------------------------------------------------------------------------------------
SYNCHRONIZED(cbLeaseDetails);
SYNCHRONIZED(cbClientPref);
SYNCHRONIZED(cbLeaseMenu);

#-----------------------------------------------------------------------------------------------------------------------
#    VALIDATIONS
#-----------------------------------------------------------------------------------------------------------------------
CELLPUTS('', cbClientPref, sUser, 'flm_Validation Message');
IF(DIMIX(dmLeaseNbr, sLeaseDescription) <> 0);
      nFlag = 1;
      CELLPUTS('Lease Name already exists', cbClientPref, sUser, 'flm_Validation Message');
ELSEIF(sLeaseDescription @= '');
      nFlag = 1;
      CELLPUTS('Lease Name is blank', cbClientPref, sUser, 'flm_Validation Message');
ELSEIF(DIMIX(dmLeaseNbr, sLeaseNbr) <> 0);
      nFlag = 1;
      CELLPUTS('Lease Number already exists', cbClientPref, sUser, 'flm_Validation Message');
ELSEIF(DIMIX(dmReviewType, sReviewType) = 0);
      nFlag = 1;
      CELLPUTS('The Review Type is blank or does not exist', cbClientPref, sUser, 'flm_Validation Message');
ELSEIF(DIMIX(dmLeaseType, sLeaseType) = 0);
      nFlag = 1;
      CELLPUTS('The Lease Type is blank or does not exist', cbClientPref, sUser, 'flm_Validation Message');
ELSEIF(DIMIX(dmYear, sCommitmentYr) = 0);
      nFlag = 1;
      CELLPUTS('The Lease Execution Year is blank or does not exist', cbClientPref, sUser, 'flm_Validation Message');
ELSEIF(DIMIX(dmMonth, sCommitmentMth) = 0);
      nFlag = 1;
      CELLPUTS('The Lease Execution Month is blank or does not exist', cbClientPref, sUser, 'flm_Validation Message');
ELSEIF(sCommitmentDay @= '');
      nFlag = 1;
      CELLPUTS('The Lease Execution Day is blank', cbClientPref, sUser, 'flm_Validation Message');
ELSEIF(DIMIX(dmYear, sStartYr) = 0);
      nFlag = 1;
      CELLPUTS('The Start Year is blank or does not exist', cbClientPref, sUser, 'flm_Validation Message');
ELSEIF(DIMIX(dmMonth, sStartMth) = 0);
      nFlag = 1;
      CELLPUTS('The Start Month is blank or does not exist', cbClientPref, sUser, 'flm_Validation Message');
ELSEIF(sStartDay @= '');
      nFlag = 1;
      CELLPUTS('The Start Day is blank', cbClientPref, sUser, 'flm_Validation Message');
ELSEIF(nLeaseTerm = 0);
      nFlag = 1;
      CELLPUTS('The Lease Term is blank', cbClientPref, sUser, 'flm_Validation Message');
ELSEIF(nInterestRate = 0 & sLeaseType @= 'Finance Lease');
      nFlag = 1;
      CELLPUTS('The Interest Rate  is blank', cbClientPref, sUser, 'flm_Validation Message');
ELSEIF(DIMIX(dmStatus, sStatus) = 0);
      nFlag = 1;
      CELLPUTS('The Status is blank or does not exist', cbClientPref, sUser, 'flm_Validation Message');
ELSE;
      nFlag = 0;
      CELLPUTS('', cbClientPref, sUser, 'flm_Validation Message');
ENDIF;

#-----------------------------------------------------------------------------------------------------------------------
#    CREATE LEASE
#-----------------------------------------------------------------------------------------------------------------------
IF(sNewBuildingParent @<> '');
      sBuildingParent = sNewBuildingParent;
      IF(DIMIX(dmLeaseNbr, sNewBuildingParent) = 0);
            DIMENSIONELEMENTINSERT(dmLeaseNbr, '', sNewBuildingParent, 'C');
            DIMENSIONELEMENTCOMPONENTADD(dmLeaseNbr, 'All Lease Numbers', sNewBuildingParent, 1);
      ENDIF;
ELSEIF(DIMIX(dmLeaseNbr, sBuildingParent) = 0);
      sBuildingParent = 'All Lease Numbers';
ENDIF;
IF(nFlag = 0 & sLeaseNbr @<> '');
      DIMENSIONELEMENTCOMPONENTADD(dmLeaseNbr, sBuildingParent, sLeaseNbr, 1);
ENDIF;

573,3

#****Begin: Generated Statements***
#****End: Generated Statements****
574,3

#****Begin: Generated Statements***
#****End: Generated Statements****
575,126

#****Begin: Generated Statements***
#****End: Generated Statements****


#-------------------------------------------------------------------------------------------
#    POPULATE LEASE DETAILS
#-------------------------------------------------------------------------------------------

IF(nFlag = 0);

      #------------------------------------------------------------------------------------
      #    ADD METADATA
      #------------------------------------------------------------------------------------
      ATTRPUTS(sLeaseNbr | ' - ' | sLeaseDescription, dmLeaseNbr, sLeaseNbr, 'Code and Description');
      ATTRPUTS(sLeaseDescription | ' {' | sLeaseNbr | '}', dmLeaseNbr, sLeaseNbr, 'Description');
      CELLPUTS(sLeaseDescription, cbLeaseVariations, sLeaseNbr, 'Lease Description');
      CELLPUTS(sLeaseDescription, cbLeaseDetails, sVariation, sLeaseNbr, 'Lease Description');

      CELLPUTS(sBuildingParent, cbLeaseVariations, sLeaseNbr, 'Building');
      CELLPUTS(sBuildingParent, cbLeaseDetails, sVariation, sLeaseNbr, 'Building');
      CELLPUTS(sLeaseType, cbLeaseDetails, sVariation, sLeaseNbr, 'Lease Type');
      CELLPUTS(sReviewType, cbLeaseDetails, sVariation, sLeaseNbr, 'Lease Review Type');
      CELLPUTS(sStatus, cbLeaseDetails, sVariation, sLeaseNbr, 'Status');
      CELLPUTS('Latest', cbLeaseDetails, sVariation, sLeaseNbr, 'Variation Status');
      CELLPUTN(nLeaseTerm, cbLeaseDetails, sVariation, sLeaseNbr, 'Lease Term (Mths)');
      CELLPUTS(sStartYr, cbLeaseDetails, sVariation, sLeaseNbr, 'Lease Start Year');
      CELLPUTS(sStartMth, cbLeaseDetails, sVariation, sLeaseNbr, 'Lease Start Month');

      IF(sStartMth @= 'Jul');
            sMth = 'Jun';
            sYear = ATTRS(dmYear, sStartYr, 'Prev');
      ELSE;
            sMth = ATTRS(dmMonth, sStartMth, 'Prev');
            sYear = sStartYr;
      ENDIF;      

      CELLPUTS(sMth, cbLeaseDetails, sVariation, sLeaseNbr, 'Lease Payment Start Month');
      CELLPUTS(sYear, cbLeaseDetails, sVariation, sLeaseNbr, 'Lease Payment Start Year');
      CELLPUTS(sStartDay, cbLeaseDetails, sVariation, sLeaseNbr, 'Lease Start Day');

      CELLPUTS(sCommitmentYr , cbLeaseDetails, sVariation, sLeaseNbr, 'Commitment Start Year');
      CELLPUTS(sCommitmentMth, cbLeaseDetails, sVariation, sLeaseNbr, 'Commitment Start Month');
      CELLPUTS(sCommitmentDay, cbLeaseDetails, sVariation, sLeaseNbr, 'Commitment Start Day');

      CELLPUTN(nInterestRate, cbLeaseDetails, sVariation, sLeaseNbr, 'Interest Rate');
      CELLPUTN(1, cbLeaseVariations, sLeaseNbr, 'Number of Variations');
      CELLPUTS(sVariation, cbLeaseVariations, sLeaseNbr, 'Latest Variation');
      CELLPUTS('Estimated Outcome:' | sVariation, cbLeaseVariations, sLeaseNbr, 'Picklist');
      CELLPUTN(nStartAmount, cbLeaseSchedule, sStartYr, 'Variation1', sLeaseNbr, sStartMth, 'Lease Value');

      sReviewDate = sStartDay | ' ' | ATTRS(dmMonth, sStartMth, 'Description');
      CELLPUTS(sReviewDate, cbLeaseDetails, sVariation, sLeaseNbr, 'Rent Review Date');
      CELLPUTN(12, cbLeaseDetails, sVariation, sLeaseNbr, 'Rent Review Interval');
      CELLPUTS('Yes', cbLeaseDetails, sVariation, sLeaseNbr, 'Automatic Rent Increases');
      CELLPUTS(ATTRS(dmMonth, sStartMth, 'Prev'), cbLeaseDetails, sVariation, sLeaseNbr, 'Rent Review Month');
      CELLPUTS(sStartDay, cbLeaseDetails, sVariation, sLeaseNbr, 'Rent Review Day');
      CELLPUTN(nCPIRate, cbLeaseDetails, sVariation, sLeaseNbr, 'Review Increase Percentage');

      CELLPUTS(sCreatedBy, cbLeaseDetails, sVariation, sLeaseNbr, 'Created By');
      CELLPUTS(sDate, cbLeaseDetails, sVariation, sLeaseNbr, 'Date Created');

      #------------------------------------------------------------------------------------
      #    CLEAR CLIENT PREFERENCES
      #------------------------------------------------------------------------------------
      CELLPUTS('', cbClientPref, sUser, 'flm_Lease Description');
      CELLPUTS('', cbClientPref, sUser, 'flm_Lease Classification');
      CELLPUTS('', cbClientPref, sUser, 'flm_Lease Type');
      CELLPUTS('', cbClientPref, sUser, 'flm_Lease Review Type');
      CELLPUTS('', cbClientPref, sUser, 'flm_Lease Start Year');
      CELLPUTS('', cbClientPref, sUser, 'flm_Lease Start Month');
      CELLPUTS('', cbClientPref, sUser, 'flm_Lease Start Day');
      CELLPUTS('', cbClientPref, sUser, 'flm_Commitment Start Year');
      CELLPUTS('', cbClientPref, sUser, 'flm_Commitment Start Month');
      CELLPUTS('', cbClientPref, sUser, 'flm_Commitment Start Day');
      CELLPUTS('', cbClientPref, sUser, 'flm_Building Parent');
      CELLPUTS('', cbClientPref, sUser, 'flm_New Building Parent');
      CELLPUTN(0, cbClientPref, sUser, 'flm_Lease Start Amount');
      CELLPUTN(0, cbClientPref, sUser, 'flm_Lease Term (Mths)');
      CELLPUTN(0, cbClientPref, sUser, 'flm_Interest Rate');
      CELLPUTN(0, cbClientPref, sUser, 'flm_CPI Rate');
      CELLPUTS('', cbClientPref, sUser, 'flm_Status');

      #------------------------------------------------------------------------------------
      #    SET NEW LEASE AS CURRENT IN CLIENT PREFERENCES
      #------------------------------------------------------------------------------------
      CELLPUTS(sLeaseNbr | ' - ' | sLeaseDescription, cbClientPref, sUser, 'flm_Selected Lease');
      CELLPUTS(sLeaseNbr | ' - ' | sLeaseDescription, cbClientPref, sUser, 'flm_Source Lease');
      CELLPUTS(sLeaseNbr | ' - ' | sLeaseDescription, cbClientPref, sUser, 'flm_Target Lease');
      CELLPUTS('Variation 1', cbClientPref, sUser, 'flm_Selected Variation');

      #------------------------------------------------------------------------------------
      #    UPDATE NEXT LEASE NUMBER
      #------------------------------------------------------------------------------------
      sNextLeaseNumber = NUMBERTOSTRING(STRINGTONUMBER(sNextLeaseNumber) + 1);
      CELLPUTS(sNextLeaseNumber, cbVariable, 'flm_Next Lease Number', 'sValue');

      #------------------------------------------------------------------------------------
      #    SET VARIATION IN CLIENT PREFERENCES
      #------------------------------------------------------------------------------------
      CELLPUTS(sVariation, cbClientPref, TM1User, 'flm_Selected Variation');

      #------------------------------------------------------------------------------------
      #    PICK LIST MAINTENANCE
      #------------------------------------------------------------------------------------
      sProcess = 'sys_Pick List Maintenance';
      EXECUTEPROCESS(sProcess);

      #------------------------------------------------------------------------------------
      #    POPULATE LEASE SCHEDULE
      #------------------------------------------------------------------------------------
      sProcess = 'flm_Finance Lease - Update Lease Schedule';
      EXECUTEPROCESS(sProcess, 'psLeaseNbr', sLeaseNbr, 'psVariation', sVariation );

      #------------------------------------------------------------------------------------
      #    CLEAR VALIDATION MESSAGE
      #------------------------------------------------------------------------------------
      CELLPUTS('', cbClientPref, sUser, 'flm_Validation Message');

ENDIF;






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
