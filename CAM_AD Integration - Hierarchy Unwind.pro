601,100
602,"CAM_AD Integration - Hierarchy Unwind"
562,"SUBSET"
586,"Active Directory Users"
585,"Active Directory Users"
564,
565,"tNd^7EORtO[e2;0Vpi0paqC7Bx3w0j7<ERscb>2uRzW5WQozKmAnJq5X[4qiAr:>oGfxkZJC<<vW=y0i9oLmxQ7?_ZEEa@oLqx@Q@X5xyb>x?xiHq?wtcFebZ2Zg66Rzyk`1[afE9e0OxwUZh8<LqUmnRE@t=>WA:XaeTlUeM]3dYL_In?E5s:sN8N>[7kYt<XHd<u:x"
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
571,All
569,0
592,0
599,1000
560,1
pDimension
561,1
2
590,1
pDimension,""
637,1
pDimension,"Dimension Name"
577,1
vElement
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
572,72

#****Begin: Generated Statements***
#****End: Generated Statements****


#________________________________________________________________________
  # Name: CAM_AD Integration - Hierarchy Unwind
  
  # Purpose: Generic process to unwind dimension in preparation for rebuild
  
  # Developer | Andrew Craig @ Tridant | 11/10/19
#________________________________________________________________________


# ________________________________________________________________________
# 1.0 Source Information
# ________________________________________________________________________

  # 1.1 Data Source: Dimension Subset
  # 1.2 Parameters: pDimension | "Dimension Name" | String
  # 1.3 Variables: vElement | String
  

#________________________________________________________________________
# 2.0 Start Prolog
#________________________________________________________________________

# 2.1 Declarations
#________________________________________________________________________

cProcess = 'Module_Unwind_Hierarchy';
cTimeStamp = TimSt( Now, '\Y\m\d\h\i\s' );
sRandomInt = NumberToString( INT( RAND( ) * 1000 ));


# 2.2 Validations
#________________________________________________________________________

# Validate Parameters
nErrors = 0;

# Validate dimension
If( Trim( pDimension ) @= '' );
  nErrors = 1;
  sMessage = 'No dimension specified';
  DataSourceType = 'NULL';
  ItemReject( sMessage );
EndIf;

If( DimensionExists( pDimension ) = 0 );
  nErrors = 1;
  sMessage = 'Dimension: ' | pDimension | ' does not exist';
  DataSourceType = 'NULL';
  ItemReject( sMessage );
EndIf;


# 2.3 Assign data source
#________________________________________________________________________

DataSourceType = 'SUBSET';
DatasourceNameForServer = pDimension;
DatasourceNameForClient = pDimension;
DatasourceDimensionSubset = 'ALL';


#________________________________________________________________________
# 2.9 End Prolog
#________________________________________________________________________



573,42

#****Begin: Generated Statements***
#****End: Generated Statements****




#________________________________________________________________________
# 3.0 Start Metadata
#________________________________________________________________________

# 3.1 Check for errors in prolog
#________________________________________________________________________

If( nErrors <> 0 );
  ProcessBreak;
EndIf;


# 3.2 Break all parent/child links
#________________________________________________________________________

If( ElLev( pDimension, vElement ) = 0 % ElCompN( pDimension, vElement ) = 0 % DType( pDimension, vElement ) @<> 'C');
  ItemSkip;
EndIf;

nChildren = ElCompN( pDimension, vElement );
While( nChildren > 0 );
  sChild = ElComp( pDimension, vElement, nChildren );
  DimensionElementComponentDelete( pDimension, vElement, sChild );
  nChildren = nChildren - 1;
End;



#________________________________________________________________________
# 3.9 End Metadata
#________________________________________________________________________




574,17

#****Begin: Generated Statements***
#****End: Generated Statements****



#________________________________________________________________________
# 4.0 Start Data
#________________________________________________________________________

#________________________________________________________________________
# 4.9 End Data
#________________________________________________________________________




575,19

#****Begin: Generated Statements***
#****End: Generated Statements****



#________________________________________________________________________
# 5.0 Start Epilog
#________________________________________________________________________

# If errors occurred terminate process with a major error status

If( nErrors <> 0 );
  ProcessQuit;
EndIf;

#________________________________________________________________________
# 5.9 End Epilog
#________________________________________________________________________
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
