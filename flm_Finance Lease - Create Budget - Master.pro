601,100
602,"flm_Finance Lease - Create Budget - Master"
562,"SUBSET"
586,"Lease Number"
585,"Lease Number"
564,
565,"bTaTSkncE@oI=?6RT7CC09d^75cu3UsjX2vl7gWFR:kbWsu1n8w;7W3@zd;@8BH`vR\Ya<kFi7nDe5b=GTJ\Lruq=Au4vuWjw_0HDGcnNZXS8Gr_hT6vG?`p=joOHS3@SN\lxg3lU_[\zLrRO[De20zpG?M`sb2Ha4IdIeWJY7Z^xw[FAewglab9>P6_Nc6>0YIhRHME"
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
571,$CreateBudget
569,0
592,0
599,1000
560,2
psYear
psLeaseNbr
561,2
2
2
590,2
psYear,"2019-2020"
psLeaseNbr,"All Lease Numbers"
637,2
psYear,""
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
572,63

#****Begin: Generated Statements***
#****End: Generated Statements****

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#
# Process:             flm_Finance Lease - Create Budget - Master
#
# Purpose:            This process creates a lease budget
#
# Written by:          Rodney Richardson (EC)
#
# Date:                  23 June 2020 
#
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#-----------------------------------------------------------------------------
#    CUBES
#-----------------------------------------------------------------------------
cbLeaseDetails = 'flm_Finance Lease Details';
cbLeaseSchedule = 'flm_Finance Lease Schedule';
cbLeaseVariations = 'flm_Finance Lease Variations';
cbLeaseComponent = 'flm_Finance Lease Components';
cbClient = 'sys_Client Preferences';

#-----------------------------------------------------------------------------
#    DIMENSIONS
#-----------------------------------------------------------------------------
dmClient = '}Clients';
dmMonth = 'Month';
dmVariation = 'Lease Variation';
dmLeaseNbr = 'Lease Number';

#-----------------------------------------------------------------------------
#    PARAMETERS
#-----------------------------------------------------------------------------
sUser = TM1User;
IF(DIMIX(dmClient, TM1User) = 0);
      sUser = 'Admin';
ELSE;
      sUser = TM1User;
ENDIF;
sProcess = 'flm_Finance Lease - Create Budget';
Object = '$CreateBudget';

#-----------------------------------------------------------------------------
#    CREATE SUBSET
#-----------------------------------------------------------------------------

# ---- Lease Number
sDim = dmLeaseNbr;
sParent = psLeaseNbr;
SUBSETDESTROY(dmLeaseNbr, Object);
SUBSETCREATE(sDim, Object);
IF (DTYPE(sDim, sParent) @='N');
      SUBSETELEMENTINSERT (sDim, Object, sParent, 1);
ELSE;
      sMDX = '{TM1FILTERBYLEVEL( {TM1DRILLDOWNMEMBER( {[' | sDim | '].[' | sParent | ']}, ALL, RECURSIVE )}, 0)}';
      SUBSETMDXSET(sDim, Object, sMDX);
      SUBSETMDXSET(sDim, Object, '');
ENDIF;


573,3

#****Begin: Generated Statements***
#****End: Generated Statements****
574,9

#****Begin: Generated Statements***
#****End: Generated Statements****


#-----------------------------------------------------------------------------
#    CREATE BUDGET
#-----------------------------------------------------------------------------
EXECUTEPROCESS(sProcess, 'psYear', psYear, 'psLeaseNumber', vsLeaseNbr);
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
