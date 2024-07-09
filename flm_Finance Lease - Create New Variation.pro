601,100
602,"flm_Finance Lease - Create New Variation"
562,"NULL"
586,
585,
564,
565,"poVm3nQXT8mT4O6ba\\SIjpoT:p28d1m>A>jPtp6xrwZLjRhDoT^d75]VVlWb<0WRv^>v`5v;_eOVhSSzb64t]B>xNajhqXdErHWzkp>rsRO3zP5fGga1l1Fpl?qgh>9P7=RY@dQ\12K3oi>YwwRRq@mM^a>g8I901rTG@hf5Q^0e^s:DZ>Vn8nLndeCQiamR`B\ke=q"
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
560,1
psLeaseNumber
561,1
2
590,1
psLeaseNumber,"FLM00006"
637,1
psLeaseNumber,""
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,126

#****Begin: Generated Statements***
#****End: Generated Statements****

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#
# Process:            flm_Finance Lease - Create New Variation
#
# Purpose:            This process creates a new lease variation.
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
# Written by:        Nathanael Riches (EC)
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
cbLeaseRevenue = 'flm_Finance Lease Revenue';
cbLeaseRevenueRep = 'flm_Finance Lease Revenue Reporting';
cbClient = 'sys_Client Preferences';

#-----------------------------------------------------------------------------
#    DIMENSIONS
#-----------------------------------------------------------------------------
dmClient = '}Clients';
dmMonth = 'Month';

#-----------------------------------------------------------------------------
#    PARAMETERS
#-----------------------------------------------------------------------------
nLatestVariation = CELLGETN(cbLeaseVariations, psLeaseNumber, 'Number of variations');
sLatestVariation = 'Variation ' | NUMBERTOSTRING(nLatestVariation);
nNextVariation = nLatestVariation + 1;
sNextVariation = 'Variation ' | NumberToString(nNextVariation);
IF(DIMIX(dmClient, TM1User) = 0);
      sUser = 'Admin';
ELSE;
      sUser = ATTRS(dmClient, TM1User, 'Non_CAM_ID');
ENDIF;
sDate = TIMST(NOW, '\d \M \Y');
sDay = SUBST(sDate, 1, 2);
sMonth = SUBST(sDate, 4, 1) | LOWER(SUBST(sDate, 5, 2));
sYear = SUBST(sDate, 8, 4);
sDate = sDay | ' ' | sMonth | ' ' | sYear;
sProcess = 'vm_Version Manager - Slave';

#-----------------------------------------------------------------------------
#    COPY FINANCE LEASE DETAILS
#-----------------------------------------------------------------------------
sCube = cbLeaseDetails;
EXECUTEPROCESS(sProcess,  'sCube', sCube, 'srcParams', 'Lease Variation;' | sLatestVariation | '|Lease Number;' | psLeaseNumber, 'destParams', 'Lease Variation;' | sNextVariation | '|Lease Number;' | psLeaseNumber | '|');

#-----------------------------------------------------------------------------
#    COPY FINANCE LEASE SCHEDULE
#-----------------------------------------------------------------------------
sCube = cbLeaseSchedule;
EXECUTEPROCESS(sProcess, 'sCube', sCube, 'srcParams', 'LeaseVariation;' | sLatestVariation | '|Lease Number;' | psLeaseNumber, 'destParams', 'Lease Variation;' | sNextVariation | '|Lease Number;' | psLeaseNumber | '|');

#-----------------------------------------------------------------------------
#    COPY FINANCE LEASE REVENUE
#-----------------------------------------------------------------------------
sCube = cbLeaseRevenue;
EXECUTEPROCESS(sProcess, 'sCube', sCube, 'srcParams', 'LeaseVariation;' | sLatestVariation | '|Lease Number;' | psLeaseNumber, 'destParams', 'Lease Variation;' | sNextVariation | '|Lease Number;' | psLeaseNumber | '|');

#-----------------------------------------------------------------------------
#    COPY FINANCE LEASE COMPONENTS
#-----------------------------------------------------------------------------
sCube = cbLeaseComponent;
EXECUTEPROCESS(sProcess,  'sCube', sCube, 'srcParams', 'Lease Variation;' | sLatestVariation | '|Lease Number;' | psLeaseNumber, 'destParams', 'Lease Variation;' | sNextVariation | '|Lease Number;' | psLeaseNumber | '|');

#-----------------------------------------------------------------------------
#    POPULATE LEASE SCHEDULE
#-----------------------------------------------------------------------------
sProcess = 'flm_Finance Lease - Update Lease Schedule';
EXECUTEPROCESS(sProcess, 'psLeaseNbr', psLeaseNumber, 'psVariation', sNextVariation );

#-----------------------------------------------------------------------------
#    UPDATE FINANCE LEASE VARIATIONS
#-----------------------------------------------------------------------------
# ---- PickList
sCurrentPicklist = CELLGETS(cbLeaseVariations, psLeaseNumber, 'Picklist');
nLength1 = LONG(sLatestVariation);
nLength2 = LONG(sNextVariation);
nPos = SCAN(sLatestVariation, sCurrentPicklist);
IF(sLatestVariation @= 'Variation 1');
      sNewPicklist = SUBST(sCurrentPicklist, 1, nPos + nLength1) | ':' | sNextVariation | ':' | SUBST(sCurrentPicklist, nPos + nLength1 + nLength2 + 1, 300);
ELSE;
      sNewPicklist = SUBST(sCurrentPicklist, 1, nPos + nLength1) | sNextVariation | ':' | SUBST(sCurrentPicklist, nPos + nLength1 + nLength2 + 1, 300);
ENDIF;
CELLPUTS(sNewPicklist, cbLeaseVariations, psLeaseNumber, 'Picklist');

# ---- Number of Variations
CELLPUTN(nNextVariation, cbLeaseVariations, psLeaseNumber, 'Number of Variations');

# ---- Latest Variation
CELLPUTS(sNextVariation, cbLeaseVariations, psLeaseNumber, 'Latest Variation');

# ---- Lock previous variation
CELLPUTS('Read Only', cbLeaseDetails, sLatestVariation, psLeaseNumber, 'Variation Status');

# ---- Created By
CELLPUTS(sUser, cbLeaseDetails, sNextVariation, psLeaseNumber, 'Created By');

# ---- Date Created
CELLPUTS(sDate, cbLeaseDetails, sNextVariation, psLeaseNumber, 'Date Created');

# ---- Variation Status
CELLPUTS('Latest', cbLeaseDetails, sNextVariation, psLeaseNumber, 'Variation Status');

# ---- Client Preferences
CELLPUTS(sNextVariation, cbClient, TM1User, 'flm_Selected Variation');
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
