601,100
602,"}src_control"
562,"NULL"
586,
585,
564,
565,"fu3JpPaz=aDD:2j[;[<8sNB;hoDe0T7TQL_UEeEp4yCCls<m]hq2F;=9;k4P\eqUEwI5XHDJCY;>ge44csHOt@^tNXY^NzHEBSTFEjgf2AuThf;JYa>IJbN<Pq6L@QFaXlnsK2?6iENIxMLav[`:IN[4Ol5s<H=jZ0dm]w7Yb<ZSzMSVa]N<N4Cw3WYlh@t8e>VuWr6R"
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
pPath
561,1
2
590,1
pPath,""
637,1
pPath,"Path to file"
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,87

#****Begin: Generated Statements***
#****End: Generated Statements****

DatasourceASCIIQuoteCharacter = '';
DatasourceASCIIDelimiter = CHAR(9);
SetOutputCharacterSet( pPath, 'TM1CS_UTF8'  );

sDim = '}Cubes';
nCount = DIMSIZ(sDim);
n = 1;
WHILE( n <= nCount);
  sName = DIMNM(sDim, n);
  TEXTOUTPUT(pPath, 'Cube', sName);
  n = n + 1;
END;

sDim = '}Dimensions';
nCount = DIMSIZ(sDim);
n = 1;
WHILE( n <= nCount);
  sName = DIMNM(sDim, n);
  IF(SCAN(':', sName) = 0);
      TEXTOUTPUT(pPath, 'Dimension', sName);
  ENDIF;
  n = n + 1;
END;

sDim = '}Processes';
nCount = DIMSIZ(sDim);
n = 1;
WHILE( n <= nCount);
  sName = DIMNM(sDim, n);
  TEXTOUTPUT(pPath, 'Process', sName);
  n = n + 1;
END;

sDim = '}Chores';
nCount = DIMSIZ(sDim);
n = 1;
WHILE( n <= nCount);
  sName = DIMNM(sDim, n);
  TEXTOUTPUT(pPath, 'Chore', sName);
  n = n + 1;
END;

sDim = '}Clients';
nCount = DIMSIZ(sDim);
n = 1;
WHILE( n <= nCount);
  sName = DIMNM(sDim, n);
  TEXTOUTPUT(pPath, 'Client', sName);
  n = n + 1;
END;

sDim = '}Groups';
nCount = DIMSIZ(sDim);
n = 1;
WHILE( n <= nCount);
  sName = DIMNM(sDim, n);
  TEXTOUTPUT(pPath, 'Group', sName);
  n = n + 1;
END;

sDim = '}ApplicationEntries';
If( DimensionExists(sDim) = 1);
  nCount = DIMSIZ(sDim);
  n = 1;
  WHILE( n <= nCount);
    sName = DIMNM(sDim, n);
    TEXTOUTPUT(pPath, 'Application', sName);
    n = n + 1;
  END;
EndIf;













573,3

#****Begin: Generated Statements***
#****End: Generated Statements****
574,3

#****Begin: Generated Statements***
#****End: Generated Statements****
575,4

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
