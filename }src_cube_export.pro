601,100
602,"}src_cube_export"
562,"NULL"
586,
585,
564,
565,"nUo3E]36@[j^dPa0JZ[JcnDYPtFC<K_116[\^HUaBpY6KX4:lT`=ck6Z4:Edj8RbeOen?CU4c9lO1plhHM;CXsXwmRGhNTSk><sgr@q`evQ0<L]SJKJ<R`nikgqi?kU;X`2coSKjzjHHo`xYT0JwnsRrP0^DctwiOk3C6:r_FvbO_JDyii1>MJQ@EN2;fXkSZ2`gzmUt"
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
pCubeName
pStructureOnly
pIncludeSecurity
pPath
561,4
2
1
1
2
590,4
pCubeName,""
pStructureOnly,1
pIncludeSecurity,1
pPath,""
637,4
pCubeName,"Name of the Cube to Export"
pStructureOnly,"Do not export data"
pIncludeSecurity,"Include the security of the cube"
pPath,"Path to file"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,105

#****Begin: Generated Statements***
#****End: Generated Statements****

####  Notes
##  20240105 - I found that this process was run at 18:09 on 4 Jan when I was not logged on.  My login is in Pulse so for the documenter so I can only conclude that PULSE for TM1 is calling this process.  - IRR 

nFill = 1;

sFileName = pPath;

DatasourceASCIIQuoteCharacter = '';
DatasourceASCIIDelimiter = CHAR(9);
SetOutputCharacterSet( sFileName, 'TM1CS_UTF8'  );

sSectionName = 'Dimensions:=';
TEXTOUTPUT(sFileName, sSectionName);
nCount = 1;
nDimensionIndex = 0;
While( TabDim( pCubeName, nCount ) @<> '' );
  sDimension = TabDim( pCubeName, nCount );
  TEXTOUTPUT(sFileName, Fill(' ', nFill) | sDimension);
  nCount = nCount + 1;
End;
TEXTOUTPUT(sFileName, '');

sControlName = '}CubeProperties';
If( DimensionExists(sControlName) = 1 & CubeExists(sControlName) = 1);
  sSectionName = 'CubeProperties:=';
  TEXTOUTPUT(sFileName, sSectionName);
  nPropCount = DIMSIZ( sControlName );
  p = 1;
  WHILE (p <= nPropCount);
      sProp = DIMNM( sControlName , p);
      If(DTYPE(sControlName, sProp) @= 'S');
        sValue = CellGetS(sControlName, pCubeName, sProp);
      Else;
        sValue = NumberToString(CellGetN(sControlName, pCubeName, sProp));
      EndIf;
      sValue = sProp | ':=' | sValue;
      TEXTOUTPUT(sFileName, Fill(' ', nFill) | sValue);
      p = p + 1;
  END;
  TEXTOUTPUT(sFileName, '');
EndIf;

sControlName = '}CubeAttributes';
If( DimensionExists(sControlName) = 1 & CubeExists(sControlName) = 1);
  sSectionName = 'CubeAttributes:=';
  TEXTOUTPUT(sFileName, sSectionName);
  nPropCount = DIMSIZ( sControlName );
  p = 1;
  WHILE (p <= nPropCount);
      sProp = DIMNM( sControlName , p);
      If(DTYPE(sControlName, sProp) @= 'S');
        sValue = CellGetS(sControlName, pCubeName, sProp);
      Else;
        sValue = NumberToString(CellGetN(sControlName, pCubeName, sProp));
      EndIf;
      sValue = sProp | ':=' | sValue;
      TEXTOUTPUT(sFileName, Fill(' ', nFill) | sValue);
      p = p + 1;
  END;
  TEXTOUTPUT(sFileName, '');
EndIf;

sControlName = '}CubeCaptions';
If( DimensionExists(sControlName) = 1 & CubeExists(sControlName) = 1);
  sSectionName = 'CubeCaptions:=';
  TEXTOUTPUT(sFileName, sSectionName);
  nPropCount = DIMSIZ( sControlName );
  p = 1;
  WHILE (p <= nPropCount);
      sProp = DIMNM( sControlName , p);
      If(DTYPE(sControlName, sProp) @= 'S');
        sValue = CellGetS(sControlName, pCubeName, sProp);
      Else;
        sValue = NumberToString(CellGetN(sControlName, pCubeName, sProp));
      EndIf;
      sValue = sProp | ':=' | sValue;
      TEXTOUTPUT(sFileName, Fill(' ', nFill) | sValue);
      p = p + 1;
  END;
  TEXTOUTPUT(sFileName, '');
EndIf;

If(pIncludeSecurity <> 0 );
  sControlName = '}Groups';
  sCubeSecCube = '}CubeSecurity';
  If( DimensionExists(sControlName) = 1 & CubeExists(sCubeSecCube) = 1);
    sSectionName = 'CubeSecurity:=';
    TEXTOUTPUT(sFileName, sSectionName);
    nPropCount = DIMSIZ( sControlName );
    p = 1;
    WHILE (p <= nPropCount);
        sProp = DIMNM( sControlName , p);
        sValue = CellGetS(sCubeSecCube, pCubeName, sProp);
        sValue = sProp | ':=' | sValue;
        TEXTOUTPUT(sFileName, Fill(' ', nFill) | sValue);
        p = p + 1;
    END;
    TEXTOUTPUT(sFileName, '');
  EndIf;
EndIf;

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
