601,100
602,"}src_clients_export"
562,"SUBSET"
586,"}Clients"
585,"}Clients"
564,
565,"iTh`qsuYNaBN4@p?w9vO5zdhwksNfiwO?4wl[447cAM5`1Fri_YiDO2dkFdbOdRomorZ5T=eV\]BypgRwpm3V;3bUO:@gVtTVuXl2cmQur=U^4dG^orr<PYu0AjHyI2ABJoTdPxA7;m]vJk]]Umup1tydTPylk8OAb`:?7P9e3pzN;J04UY=uoft6DW;f=kvB1Ipa`7G"
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
pPath
561,1
2
590,1
pPath,""
637,1
pPath,"Path to file"
577,1
vClient
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
572,17

#****Begin: Generated Statements***
#****End: Generated Statements****

sOutputPath = pPath;

DatasourceASCIIQuoteCharacter='';
DatasourceASCIIDelimiter='|';

SetOutputCharacterSet( sOutputPath, 'TM1CS_UTF8'  );


i = 0;




573,3

#****Begin: Generated Statements***
#****End: Generated Statements****
574,45

#****Begin: Generated Statements***
#****End: Generated Statements****

SetOutputCharacterSet( sOutputPath, 'TM1CS_UTF8'  );

sDisplayName = ATTRS('}Clients', vClient, '}TM1_DefaultDisplayValue');
sIsAdmin = 'false';
sIsReadOnly = 'false';
If ( CellGetS('}ClientGroups', vClient, 'ADMIN') @= 'ADMIN');
  sIsAdmin = 'true';
  sIsReadOnly = 'false';
ElseIf( CellGetN('}ClientProperties',  vClient, 'ReadOnlyUser') = 1);
  sIsReadOnly = 'true';
ElseIf (CubeExists('}CubeSecurity') = 1);
  sIsReadOnly = 'true';
  nGroupCount = DIMSIZ('}Groups');
  If(nGroupCount < 50);
    nCubeCount = DIMSIZ('}Cubes');
    c = 1;
    WHILE ( c <= nCubeCount);
      sCubeName = DIMNM('}Cubes', c);
      g = 1;
      WHILE ( g <= nGroupCount );
        sGroupName = DIMNM('}Groups', g);
        sAccess = CellGetS('}CubeSecurity', sCubeName, sGroupName);
        If (sAccess @= 'WRITE');
          sValue = CellGetS ('}ClientGroups', vClient, sGroupName);
          If (sGroupName @= sValue);
              sIsReadOnly = 'false';
          EndIf;
        EndIf;
         g = g + 1;
      END;
      c = c + 1;
    END;
  Else;
    sIsReadOnly = 'false';
  EndIf;
EndIf;

TEXTOUTPUT(sOutputPath, vClient, sDisplayName, sIsAdmin, sIsReadOnly);



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
