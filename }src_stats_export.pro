601,100
602,"}src_stats_export"
562,"SUBSET"
586,"}PerfCubes"
585,"}PerfCubes"
564,
565,"e@jDSa;o10q0^RYux7Iq6:yc<Q0EL=^706YmVV^Pd>m2J657t]vqkh2wH\;g?G<fLo\:x;Bic;s^0xxe?=Gl@`9b?w:F2AayNYW]DeXqCS:a7jYQyopgtsaWsG<I3>gEI4F5D7r12mAX>8ZNjz=z9X5W^ueRInF6eX[0YrMZKC?VsEc\tqX<]V1nC0rS>=IwkiPfzTgo"
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
577,1
vCubeName
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
572,13

#****Begin: Generated Statements***
#****End: Generated Statements****


nFill = 1;

sFileName = pPath;

DatasourceASCIIQuoteCharacter = '';
DatasourceASCIIDelimiter = CHAR(9);
SetOutputCharacterSet( sFileName, 'TM1CS_UTF8'  );

573,3

#****Begin: Generated Statements***
#****End: Generated Statements****
574,18

#****Begin: Generated Statements***
#****End: Generated Statements****

    sControlCubeName = '}StatsByCube';
    sControlName = '}StatsStatsByCube';
    If( DimensionExists(sControlName) = 1 & CubeExists(sControlCubeName) = 1);
      TextOutput(sFileName, vCubeName);
      nPropCount = DIMSIZ( sControlName );
      p = 1;
      WHILE (p <= nPropCount);
          sProp = DIMNM( sControlName , p);
          sValue = sProp | ':=' | TRIM(STR(CellGetN(sControlCubeName, sProp, vCubeName, 'LATEST' ), 15, 0));
          TextOutput(sFileName, Fill(' ', nFill) | sValue);
          p = p + 1;
      END;
      TextOutput(sFileName, '');
    EndIf;
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
