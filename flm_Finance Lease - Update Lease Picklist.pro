601,100
602,"flm_Finance Lease - Update Lease Picklist"
562,"NULL"
586,"flm_Finance Lease Menu"
585,"flm_Finance Lease Menu"
564,
565,"d5OBah==_F;gp2X[_ZwqqrBs41_mqPkj?5jcGsPTNw:L_VCiv<z2VG<XNZjG3abhSLZ9kFRY\Qv[tuZsscuXAK@2ntSuOrPbmK;Z\>j=\dTurg;0x:pztguj0AHJTuC@i@;2gZXmpHTh\vF@yI^@2aXe]bWsIWxeh6mUY?5y1cnF`eiphdi^^y?z9J50l=11U5zsL?1f"
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
560,4
psLeaseNbr
psLeaseType
psReviewType
psStatus
561,4
2
2
2
2
590,4
psLeaseNbr,"All Lease Numbers"
psLeaseType,"All Lease Types"
psReviewType,"All Review Types"
psStatus,"All Lease Status"
637,4
psLeaseNbr,""
psLeaseType,""
psReviewType,""
psStatus,""
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,82

#****Begin: Generated Statements***
#****End: Generated Statements****

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#
# Process:            flm_Finance Lease - Update Lease Picklist
#
# Purpose:            This process creates a picklist based on the selections on the main menu
#
# Written by:         Rodney Richardson (EC)
#
# Date:                 25 May 2021
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
cbClient = 'sys_Client Preferences';

#-----------------------------------------------------------------------------
#    DIMENSIONS
#-----------------------------------------------------------------------------
dmVariation = 'Lease Variation';
dmLeaseNbr = 'Lease Number';
dmStatus = 'Lease Status';
dmLeaseType = 'Lease Type';
dmReviewType = 'Lease Review Type';
dmMonth = 'Month';
dmClient = '}Clients';

#-----------------------------------------------------------------------------
#    OTHER PARAMETERS
#-----------------------------------------------------------------------------
IF(DIMIX(dmClient, TM1User) = 0);
      sUser = 'Admin';
ELSE;
      sUser = TM1User;
ENDIF;
Object = '$CreatePicklist';

#--------------------------------------------------------
#    CREATE LEASE PICKLIST
#--------------------------------------------------------
sDim = dmLeaseNbr ;
sParent = psLeaseNbr;
sMeasure = 'flm_Lease Picklist';
sString = 'static::';
CELLPUTS('', cbClient, sUser, 'flm_Lease Picklist');

SUBSETDESTROY ( sDim, Object );
SUBSETCREATE ( sDim, Object );
sMDX = '{TM1FILTERBYLEVEL( {TM1DRILLDOWNMEMBER( {[' | sDim | '].[' | sParent | ']}, ALL, RECURSIVE )}, 0)}';
SUBSETMDXSET(sDim, Object, sMDX);
SUBSETMDXSET(sDim, Object, '');
SUBSETALIASSET(sDim, Object, 'Code and Description');

nSubSize = SUBSETGETSIZE ( sDim, Object );
nCounter = 1;

WHILE (nCounter <= nSubSize);

      sEl = SUBSETGETELEMENTNAME ( sDim, Object, nCounter );
      sCodeDesc = ATTRS(dmLeaseNbr, sEl, 'Code and Description');

      nValue = CELLGETN ( cbLeaseMenu, psStatus, psLeaseType, psReviewType, sEl, 'Count');
      IF ( nValue >  0 );  
            sString = sString | ':' | sCodeDesc;
            CELLPUTS(sString, cbClient, sUser, 'flm_Lease Picklist');
      ENDIF;
       nCounter = nCounter + 1;

END;

SUBSETDESTROY ( sDim, Object );

573,6

#****Begin: Generated Statements***
#****End: Generated Statements****



574,5

#****Begin: Generated Statements***
#****End: Generated Statements****


575,8

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
