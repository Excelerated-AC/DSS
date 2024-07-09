601,100
602,"sys_Pick List Maintenance"
562,"NULL"
586,"}Dimensions"
585,"}Dimensions"
564,
565,"s]a>0H=FB:_qA_i2t45a`LZfl3:]uquINc?9RPnCDy<RrJV2[WKX2fwU2d4n^d1?znXEuaogQ4ki2vq_J9[qxBCBEuDyu[Z3n=>]9?>lC=[g16Bc2KJD6sBjT_Q12S9^[lMThNB^8GqbAn[u0`hTsmptVWK5L@ZIV?dqxy7fQv_`GaE2\5\s3lTV^Lot^D:i_o=WSWQ@"
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
571,All
569,1
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
572,140

#****Begin: Generated Statements***
#****End: Generated Statements****


#***********************************************************************************************************************************************
#**** PROCESS:		sys_Pick List Maintenance
#****
#**** DESCRIPTION:	This process builds subsets that are used as pick lists
#****
#****
#**** AUTHOR:		Excelerated Consulting
#****
#**** MODIFICATION HISTORY:
#****
#**** Date	Initials	Comments
#**** ====	======	==========
#**** 10/01/2019	RJR	
#***********************************************************************************************************************************************

#--------------------------------------------------------------------------------------------------
#    CUBES
#--------------------------------------------------------------------------------------------------
cbVar = 'sys_Variable'; 

#--------------------------------------------------------------------------------------------------
#    BUILD SUBSETS
#--------------------------------------------------------------------------------------------------

#--------------------------------------------------------------------
#    LEASE NUMBER
#--------------------------------------------------------------------
sDim = 'Lease Number';
sParent = 'All Lease Numbers';

sSubset = 'Pick_N Levels';
SUBSETDESTROY(sDim, sSubset);
SUBSETCREATE(sDim, sSubset);
sMDX = '{TM1SORT( {TM1FILTERBYLEVEL( {TM1DRILLDOWNMEMBER( {[' | sDim | '].[' | sParent | ']}, ALL, RECURSIVE )}, 0)}, ASC)}';
SUBSETMDXSET(sDim, sSubset, sMDX);
SUBSETMDXSET(sDim, sSubset, '');
SUBSETELEMENTINSERT(sDim, sSubset, sParent, 1);

#--------------------------------------------------------------------
#    LEASE VARIATION (BUDGET)
#--------------------------------------------------------------------
sDim = 'Lease Variation';
sParent = 'Budget Variations';

sSubset = 'Pick_Budget Version';
SUBSETDESTROY(sDim, sSubset);
SUBSETCREATE(sDim, sSubset);
sMDX = '{TM1FILTERBYLEVEL( {TM1DRILLDOWNMEMBER( {[' | sDim | '].[' | sParent | ']}, ALL, RECURSIVE )}, 0)}';
SUBSETMDXSET(sDim, sSubset, sMDX);
SUBSETMDXSET(sDim, sSubset, '');

#--------------------------------------------------------------------
#    MONTH
#--------------------------------------------------------------------
sDim = 'Month';
sParent = 'Jun YTD';

# ---- N Levels
sSubset = 'Pick_N Levels';
SUBSETDESTROY(sDim, sSubset);
SUBSETCREATE(sDim, sSubset);
sMDX = '{TM1FILTERBYLEVEL( {TM1DRILLDOWNMEMBER( {[' | sDim | '].[' | sParent | ']}, ALL, RECURSIVE )}, 0)}';
SUBSETMDXSET(sDim, sSubset, sMDX);
SUBSETMDXSET(sDim, sSubset, '');

#--------------------------------------------------------------------
#    PROGRAM
#--------------------------------------------------------------------
sDim = 'Program';
sParent = 'All Programs';

# ---- All
sSubset = 'Pick All';
SUBSETDESTROY(sDim, sSubset);
SUBSETCREATE(sDim, sSubset);
SUBSETALIASSET(sDim, sSubset, 'Code and Description');
sMDX = '{TM1SUBSETALL( [' | sDim | '] )}';
SUBSETMDXSET(sDim, sSubset, sMDX);
SUBSETMDXSET(sDim, sSubset, '');

# ---- N Levels
sSubset = 'Pick_N Levels';
SUBSETDESTROY(sDim, sSubset);
SUBSETCREATE(sDim, sSubset);
SUBSETALIASSET(sDim, sSubset, 'Code and Description');
sMDX = '{TM1FILTERBYLEVEL( {TM1DRILLDOWNMEMBER( {[' | sDim | '].[' | sParent | ']}, ALL, RECURSIVE )}, 0)}';
SUBSETMDXSET(sDim, sSubset, sMDX);
SUBSETMDXSET(sDim, sSubset, '');

#--------------------------------------------------------------------
#    YEAR
#--------------------------------------------------------------------
sDim ='Year';

# ---- N Levels
sParent = 'All Years';
sSubset = 'Pick_N Levels';
SUBSETDESTROY(sDim, sSubset);
SUBSETCREATE(sDim, sSubset);
sMDX = '{TM1FILTERBYLEVEL( {TM1DRILLDOWNMEMBER( {[' | sDim | '].[' | sParent | ']}, ALL, RECURSIVE )}, 0)}';
SUBSETMDXSET(sDim, sSubset, sMDX);
SUBSETMDXSET(sDim, sSubset, '');

# ---- Default
sSubset = 'Default';
sRepYear = CELLGETS(cbVar, 'Current Year', 'sValue');
sYear = DIMNM(sDim, DIMIX(sDim, sRepYear) - 4);

SUBSETDELETEALLELEMENTS(sDim, sSubset);
SUBSETELEMENTINSERT(sDim, sSubset, sYear, 1);

nCounter = 1;

WHILE(nCounter <= 5);
      sYear = ATTRS(sDim, sYear, 'Next');
      SUBSETELEMENTINSERT(sDim, sSubset, sYear, 1);
      nCounter = nCounter + 1;
END;

















573,5

#****Begin: Generated Statements***
#****End: Generated Statements****


574,4

#****Begin: Generated Statements***
#****End: Generated Statements****

575,9

#****Begin: Generated Statements***
#****End: Generated Statements****






576,CubeAction=1511DataAction=1503CubeLogChanges=0
930,0
638,1
804,0
1217,1
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
