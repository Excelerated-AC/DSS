601,100
602,"flm_Select Lease"
562,"NULL"
586,
585,
564,
565,"aaza>4hxiM_xWG:?50Y?u@jW7v9?=y^T>4oN=RLgjKsonSQa`ve^_Dv2A3>ROZSqcHT3i:zWyB:FfRO6kv6a53Qy=2SVxpk]T_ZLcif>f8cEuivg]8zHsxi;ihhvcOhG^]wzUP4xwTKIJIrEKmXpvhBD>o?ddEDz^6b6dt_WLnPtXUoS:UCuSUY9Bp>lBsd@dwAv?6Sm"
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
560,1
psLease
561,1
2
590,1
psLease,""
637,1
psLease,""
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,43

#****Begin: Generated Statements***
#****End: Generated Statements****

#*********************************************************************************************************************
#**** PROCESS:               
#**** DESCRIPTION:       This process sets the selected Lease Number
#****
#****
#**** MODIFICATION HISTORY:
#****
#****  Date               Initials        Comments
#****  ====              ======      =========
#**** 09/06/2019    NR          Initial Revision
#****
#***********************************************************************************************************************

#--------------------------------------------------------------------------------------------
#    CUBES
#--------------------------------------------------------------------------------------------
cbClientPref = 'sys_Client Preferences';
cbLeaseVariations = 'flm_Finance Lease Variations';

#--------------------------------------------------------------------------------------------
#    DIMENSIONS
#--------------------------------------------------------------------------------------------
dmLease = 'Lease Number';

#--------------------------------------------------------------------------------------------
#    OTHER PARAMETERS
#--------------------------------------------------------------------------------------------
sUser = TM1User;

#--------------------------------------------------------------------------------------------
#    SET PROPOSAL IN CLIENT PREFERENCES
#--------------------------------------------------------------------------------------------
sLease = DIMENSIONELEMENTPRINCIPALNAME(dmLease, psLease);
IF(DIMIX(dmLease, sLease) > 0 & DTYPE(dmLease, sLease) @= 'N');
      CELLPUTS(psLease, cbClientPref, sUser, 'flm_Selected Lease');
      sVariation = CELLGETS(cbLeaseVariations, sLease, 'Latest Variation');
      CELLPUTS(sVariation, cbClientPref, sUser, 'flm_Selected Variation');

ENDIF;
573,3

#****Begin: Generated Statements***
#****End: Generated Statements****
574,3

#****Begin: Generated Statements***
#****End: Generated Statements****
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
