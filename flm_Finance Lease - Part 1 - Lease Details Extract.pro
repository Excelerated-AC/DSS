601,100
602,"flm_Finance Lease - Part 1 - Lease Details Extract"
562,"SUBSET"
586,"Lease Number"
585,"Lease Number"
564,
565,"e<E6>aOjuW7t6JXbJ6IBepJci_U?IlktjUL25ATC^g\06ZL\2Yi3aXz@6:@3aEPR:\[U0MmsHAC3FAAYimfML:4IVtZJM2fLDPPZOVPSGCt2EBn;2]M5HrHFvR_c8?2Tv0KFLZ=HKf2OMbgJQm1K6PM\vG53YiLZ]J<kIw`8IwP042IegwaM[p@F<yJwZ0v]]Z>rRg:N"
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
571,Pick_N Levels
569,0
592,0
599,1000
560,2
psVariation
psLeaseNbr
561,2
2
2
590,2
psVariation,""
psLeaseNbr,"FLM00001"
637,2
psVariation,""
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
572,88

#****Begin: Generated Statements***
#****End: Generated Statements****


#************************************************************************************************************************#
#
# Process:            fin_Finance Lease - Part 1 - Lease Details Extract
#
# Purpose:           Exports finance lease details
#                                              
# Written by:        Rodney Richardson(Excelerated Consulting)
#
# Date:                 26/05/2023
#
#************************************************************************************************************************#

#------------------------------------------------------------------
#    CUBES
#------------------------------------------------------------------
cbLeaseDetails = 'flm_Finance Lease Details';
cbVar = 'sys_Variable';

#------------------------------------------------------------------
#    DIMENSIONS
#------------------------------------------------------------------
dmLeaseNbr = 'Lease Number';
dmLeaseDetails = 'flm_Finance Lease Details Measure';

#------------------------------------------------------------------
#    OTHER PARAMETERS
#------------------------------------------------------------------
Object = '$LeaseExport';
nCount = 0;
IF(psVariation @= '');
      sVariation = 'Estimated Outcome';
ELSE;
      sVariation = psVariation;
ENDIF;
sDate = TODAY(1);

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

IF(psVariation @= '' & psLeaseNbr @= '');
      sFileName = 'Lease Details @ ' | sDate | '.csv';
ELSE;
      sFileName = 'Lease Details - ' | sVariation | sLeaseNbr | '@ ' | sDate | '.csv';
ENDIF;
sDirectory = CELLGETS(cbVar, 'sys_Import Directory', 'sValue') | '\Finance Leases\Finance Lease Exports\';
sFilePath = sDirectory | sFileName;

#------------------------------------------------------------------
#     CREATE SOURCE SUBSET
#------------------------------------------------------------------

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

#------------------------------------------------------------------
#    SET DATASOURCE
#------------------------------------------------------------------
DATASOURCEASCIIQUOTECHARACTER = '';
DATASOURCENAMEFORSERVER = dmLeaseNbr;
DATASOURCEDIMENSIONSUBSET = Object;


573,3

#****Begin: Generated Statements***
#****End: Generated Statements****
574,61

#****Begin: Generated Statements***
#****End: Generated Statements****


#----------------------------------------------------------------------------------------------------------
#    ADD HEADER RECORD
#----------------------------------------------------------------------------------------------------------
IF(nCount = 0);

      sString = 'Lease Number, Variation';
      nCounter = 1;
      nDimSize = DIMSIZ(dmLeaseDetails);

      WHILE(nCounter <= nDimSize);

            sEl = DIMNM(dmLeaseDetails, nCounter);
            sExport = ATTRS(dmLeaseDetails, sEl, 'Export');

            IF( DTYPE(dmLeaseDetails, sEl) @<> 'C' & sExport @<> 'N');
                  sString = sString | ',' | sEl;
            ENDIF;

            nCounter = nCounter + 1;

      END;

      ASCIIOUTPUT(sFilePath, sString);
      nCount = 1;

ENDIF;

#----------------------------------------------------------------------------------------------------------
#    EXPORT LEASE DETAILS
#----------------------------------------------------------------------------------------------------------
sString = vsLeaseNbr | ',' | sVariation;
nCounter = 1;
nDimSize = DIMSIZ(dmLeaseDetails);

WHILE(nCounter <= nDimSize);

      sEl = DIMNM(dmLeaseDetails, nCounter);
      sExport = ATTRS(dmLeaseDetails, sEl, 'Export');

      IF( DTYPE(dmLeaseDetails, sEl) @<> 'C' & sExport @<> 'N');

            IF( DTYPE(dmLeaseDetails, sEl) @= 'N');
                  sValue = NUMBERTOSTRING( CELLGETN(cbleaseDetails, sVariation, vsLeaseNbr, sEl));
            ELSE;
                  sValue = CELLGETS(cbleaseDetails, sVariation, vsLeaseNbr, sEl);
            ENDIF;

            sString = sString | ',' | sValue;

      ENDIF;

      nCounter = nCounter + 1;

END;

ASCIIOUTPUT(sFilePath, sString);
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
