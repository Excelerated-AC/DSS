601,100
602,"flm_Version Manager - Master"
562,"NULL"
586,
585,
564,
565,"yyB8h3=v3ZFr?[2GKDvUT@MhCa\:lG9NfPCUl9I9oFmxYNoA<xwE:Z9FZ7Y8NDW:>u:54zf^lc63Z29jc^ze_?6uV7>JNBNh8n6hgmQgSyd0VPuh>7_Bx?8yRq7f^RIAI6hjO4XPm`x_ys;jZ^TyIyyeRcfIZE<DnnazB5I8h[Nr<z76Di9?zUo`xVZ_s2Kvi>dxlF=]"
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
560,4
psSourceLease
psSourceVariation
psTargetLease
psTargetVariation
561,4
2
2
2
2
590,4
psSourceLease,"All Lease Numbers"
psSourceVariation,"Estimated Outcome"
psTargetLease,"All Lease Numbers"
psTargetVariation,"Original Budget"
637,4
psSourceLease,""
psSourceVariation,""
psTargetLease,""
psTargetVariation,""
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,127

#****Begin: Generated Statements***
#****End: Generated Statements****

#*******************************************************************************************************************************************#
#
# Process:            flm_Version Manager
#
# Purpose:            This process will copy data from 1 part of a cube to another by callingvm_Version Manager - Slave
#                           It takes a number of parameters in the parameters tab and converts then into the required
#                           parameters for the called processes.
#                           It passes 3 parameters sCube, srcParams and destParams to these processes.
#                           srcParams and destParama are both of the form 'Dim1;Element1|Dim2;Element2|...|Dimn;Elementn'.
#                                  There can only be 1 element selected for each dimension.
#                           The process can work on any cube with 3 to 15 dimensions, but can be modified to work on less or
#                            more if required
#
# Written by:        Malcolm MacDonnell (Excelerated Consulting) (MLL)
#
#*******************************************************************************************************************************************#

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
cbLeaseRep = 'flm_Finance Lease Reporting';
cbClient = 'sys_Client Preferences';

#-----------------------------------------------------------------------------
#    DIMENSION
#-----------------------------------------------------------------------------
dmVariation = 'Lease Variation';

#-----------------------------------------------------------------------------
#    PERFORM COPY
#-----------------------------------------------------------------------------

IF(psSourceVariation @= 'Estimated Outcome' & ELISANC(dmVariation, 'Year End Snapshots', psTargetVariation) = 0);

      sProcess = 'flm_Finance Lease - Create Budget';
      CELLPUTS(psTargetVariation, cbClient, TM1User, 'flm_New Budget Version');
      EXECUTEPROCESS(sProcess, 'psLeaseNbr', psSourceLease, 'psLeaseType', 'All Lease Types', 'psReviewType', 'All Review Types', 'psStatus', 'All Lease Status');
      CELLPUTS('', cbClient, TM1User, 'flm_New Budget Version');

ELSEIF(psSourceVariation @= 'Estimated Outcome' & ELISANC(dmVariation, 'Year End Snapshots', psTargetVariation) = 1);

      sProcess = 'flm_Version Manager - Slave';

      #-----------------------------------------------------------------------------
      #    COPY FINANCE LEASE DETAILS
      #-----------------------------------------------------------------------------
      sCube = cbLeaseDetails;
      EXECUTEPROCESS(sProcess,  'sCube', sCube, 'srcParams', 'Lease Variation;' |psSourceVariation | '|Lease Number;' | psSourceLease, 'destParams', 'Lease Variation;' | psTargetVariation | '|Lease Number;' | psTargetLease | '|');

      #-----------------------------------------------------------------------------
      #    COPY FINANCE LEASE SCHEDULE
      #-----------------------------------------------------------------------------
      sCube = cbLeaseSchedule;
      EXECUTEPROCESS(sProcess,  'sCube', sCube, 'srcParams', 'Lease Variation;' |psSourceVariation | '|Lease Number;' | psSourceLease, 'destParams', 'Lease Variation;' | psTargetVariation | '|Lease Number;' | psTargetLease | '|');

      #-----------------------------------------------------------------------------
      #    COPY FINANCE LEASE REVENUE
      #-----------------------------------------------------------------------------
      sCube = cbLeaseRevenue;
      EXECUTEPROCESS(sProcess,  'sCube', sCube, 'srcParams', 'Lease Variation;' |psSourceVariation | '|Lease Number;' | psSourceLease, 'destParams', 'Lease Variation;' | psTargetVariation | '|Lease Number;' | psTargetLease | '|');

      #-----------------------------------------------------------------------------
      #    COPY FINANCE LEASE COMPONENTS
      #-----------------------------------------------------------------------------
      sCube = cbLeaseComponent;
      EXECUTEPROCESS(sProcess,  'sCube', sCube, 'srcParams', 'Lease Variation;' |psSourceVariation | '|Lease Number;' | psSourceLease, 'destParams', 'Lease Variation;' | psTargetVariation | '|Lease Number;' | psTargetLease | '|');

      #-----------------------------------------------------------------------------
      #    COPY FINANCE LEASE REPORTING
      #-----------------------------------------------------------------------------
      sCube = cbLeaseRep;
      EXECUTEPROCESS(sProcess,  'sCube', sCube, 'srcParams', 'Lease Variation;' |psSourceVariation | '|Lease Number;' | psSourceLease, 'destParams', 'Lease Variation;' | psTargetVariation | '|Lease Number;' | psTargetLease | '|');

      #-----------------------------------------------------------------------------
      #    COPY FINANCE LEASE REVENUE REPORTING
      #-----------------------------------------------------------------------------
      sCube = cbLeaseRevenueRep;
      EXECUTEPROCESS(sProcess,  'sCube', sCube, 'srcParams', 'Lease Variation;' |psSourceVariation | '|Lease Number;' | psSourceLease, 'destParams', 'Lease Variation;' | psTargetVariation | '|Lease Number;' | psTargetLease | '|');

ELSE;

      sProcess = 'flm_Version Manager - Slave';

      #-----------------------------------------------------------------------------
      #    COPY FINANCE LEASE DETAILS
      #-----------------------------------------------------------------------------
      sCube = cbLeaseDetails;
      EXECUTEPROCESS(sProcess,  'sCube', sCube, 'srcParams', 'Lease Variation;' |psSourceVariation | '|Lease Number;' | psSourceLease, 'destParams', 'Lease Variation;' | psTargetVariation | '|Lease Number;' | psTargetLease | '|');

      #-----------------------------------------------------------------------------
      #    COPY FINANCE LEASE SCHEDULE
      #-----------------------------------------------------------------------------
      sCube = cbLeaseSchedule;
      EXECUTEPROCESS(sProcess,  'sCube', sCube, 'srcParams', 'Lease Variation;' |psSourceVariation | '|Lease Number;' | psSourceLease, 'destParams', 'Lease Variation;' | psTargetVariation | '|Lease Number;' | psTargetLease | '|');

      #-----------------------------------------------------------------------------
      #    COPY FINANCE LEASE REVENUE
      #-----------------------------------------------------------------------------
      sCube = cbLeaseRevenue;
      EXECUTEPROCESS(sProcess,  'sCube', sCube, 'srcParams', 'Lease Variation;' |psSourceVariation | '|Lease Number;' | psSourceLease, 'destParams', 'Lease Variation;' | psTargetVariation | '|Lease Number;' | psTargetLease | '|');

      #-----------------------------------------------------------------------------
      #    COPY FINANCE LEASE COMPONENTS
      #-----------------------------------------------------------------------------
      sCube = cbLeaseComponent;
      EXECUTEPROCESS(sProcess,  'sCube', sCube, 'srcParams', 'Lease Variation;' |psSourceVariation | '|Lease Number;' | psSourceLease, 'destParams', 'Lease Variation;' | psTargetVariation | '|Lease Number;' | psTargetLease | '|');

      #-----------------------------------------------------------------------------
      #    POPULATE LEASE SCHEDULE
      #-----------------------------------------------------------------------------
      sProcess = 'flm_Finance Lease - Update Lease Schedule';
      EXECUTEPROCESS(sProcess, 'psLeaseNbr', psTargetLease, 'psVariation', psTargetVariation );

ENDIF;


573,3

#****Begin: Generated Statements***
#****End: Generated Statements****
574,3

#****Begin: Generated Statements***
#****End: Generated Statements****
575,7

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
