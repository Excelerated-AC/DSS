601,100
602,"}src_import"
562,"CHARACTERDELIMITED"
586,"C:\TM1\Blank.txt"
585,"C:\TM1\Blank.txt"
564,
565,"pdWF4fMN?OfM6A>ba2u5V5J`v6Hzqnn3ci:CNfo_qM?Vtz2?ok<xsN8m7Ax8y1hio4i8GDa`uFFNiVdvg9v5xp1Skdpfuiqdp=qnS;4rX]a`OytwIL_3q`J_@UgXJ_Q12[t7J<YRCcV=UtLIDgwmvFGfZmR>=9UgXsfuQce1aFWYVA<FP1zFy6aDJSCZRYLhFhRn8XVo"
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
567,"	"
588,"."
589,","
568,""""
570,
571,
569,0
592,0
599,1000
560,2
pPackPath
pOpsPath
561,2
2
2
590,2
pPackPath,""
pOpsPath,""
637,2
pPackPath,""
pOpsPath,""
577,65
vId
vOp
vObjType
vObj
V5
V6
V7
V8
V9
V10
V11
V12
V13
V14
V15
V16
V17
V18
V19
V20
V21
V22
V23
V24
V25
V26
V27
V28
V29
V30
V31
V32
V33
V34
V35
V36
V37
V38
V39
V40
V41
V42
V43
V44
V45
V46
V47
V48
V49
V50
V51
V52
V53
V54
V55
V56
V57
V58
V59
V60
V61
V62
V63
V64
V65
578,65
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
579,65
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30
31
32
33
34
35
36
37
38
39
40
41
42
43
44
45
46
47
48
49
50
51
52
53
54
55
56
57
58
59
60
61
62
63
64
65
580,65
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
581,65
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
582,65
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
603,0
572,27

#****Begin: Generated Statements***
#****End: Generated Statements****


SetInputCharacterSet ('TM1CS_UTF8');

sOutput = pOpsPath | '.meta';
sOutputData = pOpsPath | '.data';

DatasourceASCIIQuoteCharacter = '';
DatasourceASCIIDelimiter = CHAR(9);
SetOutputCharacterSet( sOutput, 'TM1CS_UTF8'  );
SetOutputCharacterSet( sOutputData, 'TM1CS_UTF8'  );

m = 0;
d = 0;


DataSourceNameForClient = pOpsPath; 
DataSourceNameForServer = pOpsPath; 






573,462

#****Begin: Generated Statements***
#****End: Generated Statements****


If(m = 0);
  m = 1;
  SetOutputCharacterSet( sOutput, 'TM1CS_UTF8'  );
EndIf;

If(vObjType @= 'Dimension');

  If(vOp @= 'DELETE');
  
    If(DimensionExists(vObj) = 1);
      DimensionDestroy(vObj);
      TextOutput(sOutput, NumberToString(NOW), 'Deleted Dimension', vObj);
    EndIf;
    
  ElseIf(vOp @= 'ADD');
  
    If(DimensionExists(vObj) = 0);
      DimensionCreate(vObj);
      DimensionSortOrder(vObj, V5, V6, V7, V8);
      TextOutput(sOutput, NumberToString(NOW), 'Created Dimension', vObj);
    EndIf;

  ElseIf(vOp @= 'UPDATE');
  
    If(DimensionExists(vObj) = 1);
      DimensionSortOrder(vObj, V5, V6, V7, V8);
      TextOutput(sOutput, NumberToString(NOW), 'Updated Dimension sort order', vObj);
    EndIf;
    
  EndIf;
  
ElseIf(vObjType @= 'Cube');

  If(vOp @= 'DELETE');
  
    If(CubeExists(vObj) = 1);
      CubeDestroy(vObj);
      TextOutput(sOutput, NumberToString(NOW), 'Deleted Cube', vObj);
    EndIf;
    
  ElseIf(vOp @= 'ADD');
  
    If(CubeExists(vObj) = 1);
      ItemSkip;
    EndIf;
    
    sDim1 = V5;
    sDim2 = V6;
    nDimCount = 2;
      If(TRIM(V7) @<> '');
      sDim3 = V7;
      nDimCount = 3;
    EndIf;
    If(TRIM(V8) @<> '');
      sDim4 = V8;
      nDimCount = 4;
    EndIf;
    If(TRIM(V9) @<> '');
      sDim5 = V9;
      nDimCount = 5;
    EndIf;
    If(TRIM(V10) @<> '');
      sDim6 = V10;
      nDimCount = 6;
    EndIf;
    If(TRIM(V11) @<> '');
      sDim7 = V11;
      nDimCount = 7;
    EndIf;
    If(TRIM(V12) @<> '');
      sDim8 = V12;
      nDimCount = 8;
    EndIf;
    If(TRIM(V13) @<> '');
      sDim9 = V13;
      nDimCount = 9;
    EndIf;
    If(TRIM(V14) @<> '');
      sDim10 = V14;
      nDimCount = 10;
    EndIf;
    If(TRIM(V15) @<> '');
      sDim11 = V15;
      nDimCount = 11;
    EndIf;
    If(TRIM(V16) @<> '');
      sDim12 = V16;
      nDimCount = 12;
    EndIf;
    If(TRIM(V17) @<> '');
      sDim13 = V17;
      nDimCount = 13;
    EndIf;
    If(TRIM(V18) @<> '');
      sDim14 = V18;
      nDimCount = 14;
    EndIf;
    If(TRIM(V19) @<> '');
      sDim15 = V19;
      nDimCount = 15;
    EndIf;
    If(TRIM(V20) @<> '');
      sDim16 = V20;
      nDimCount = 16;
    EndIf;
    If(TRIM(V21) @<> '');
      sDim17 = V21;
      nDimCount = 17;
    EndIf;
    If(TRIM(V22) @<> '');
      sDim18 = V22;
      nDimCount = 18;
    EndIf;
    If(TRIM(V23) @<> '');
      sDim19 = V23;
      nDimCount = 19;
    EndIf;
    If(TRIM(V24) @<> '');
      sDim20 = V24;
      nDimCount = 20;
    EndIf;
    If(TRIM(V25) @<> '');
      sDim21 = V25;
      nDimCount = 21;
    EndIf;
    If(TRIM(V26) @<> '');
      sDim22 = V26;
      nDimCount = 22;
    EndIf;
    If(TRIM(V27) @<> '');
      sDim23 = V27;
      nDimCount = 23;
    EndIf;
    If(TRIM(V28) @<> '');
      sDim24 = V28;
      nDimCount = 24;
    EndIf;
    If(TRIM(V29) @<> '');
      sDim25 = V29;
      nDimCount = 25;
    EndIf;
    If(TRIM(V30) @<> '');
      sDim26 = V30;
      nDimCount = 26;
    EndIf;
    If(TRIM(V31) @<> '');
      sDim27 = V31;
      nDimCount = 27;
    EndIf;
    If(TRIM(V32) @<> '');
      sDim28 = V32;
      nDimCount = 28;
    EndIf;
    If(TRIM(V33) @<> '');
      sDim29 = V33;
      nDimCount = 29;
    EndIf;
    If(TRIM(V34) @<> '');
      sDim30 = V34;
      nDimCount = 30;
    EndIf;
    If(TRIM(V35) @<> '');
      sDim31 = V35;
      nDimCount = 31;
    EndIf;
    If(TRIM(V36) @<> '');
      sDim32 = V36;
      nDimCount = 32;
    EndIf;
    If(TRIM(V37) @<> '');
      sDim33 = V37;
      nDimCount = 33;
    EndIf;
    If(TRIM(V38) @<> '');
      sDim34 = V38;
      nDimCount = 34;
    EndIf;
    If(TRIM(V39) @<> '');
      sDim35 = V39;
      nDimCount = 35;
    EndIf;
    If(TRIM(V40) @<> '');
      sDim36 = V40;
      nDimCount = 36;
    EndIf;
    If(TRIM(V41) @<> '');
      sDim37 = V41;
      nDimCount = 37;
    EndIf;
    If(TRIM(V42) @<> '');
      sDim38 = V42;
      nDimCount = 38;
    EndIf;
    If(TRIM(V43) @<> '');
      sDim39 = V43;
      nDimCount = 39;
    EndIf;
    If(TRIM(V44) @<> '');
      sDim40 = V44;
      nDimCount = 40;
    EndIf;
    If(TRIM(V45) @<> '');
      sDim41 = V45;
      nDimCount = 41;
    EndIf;
    If(TRIM(V46) @<> '');
      sDim42 = V46;
      nDimCount = 42;
    EndIf;
    If(TRIM(V47) @<> '');
      sDim43 = V47;
      nDimCount = 43;
    EndIf;
    If(TRIM(V48) @<> '');
      sDim44 = V48;
      nDimCount = 44;
    EndIf;
    If(TRIM(V49) @<> '');
      sDim45 = V49;
      nDimCount = 45;
    EndIf;
    If(TRIM(V50) @<> '');
      sDim46 = V50;
      nDimCount = 46;
    EndIf;
    If(TRIM(V51) @<> '');
      sDim47 = V51;
      nDimCount = 47;
    EndIf;
    If(TRIM(V52) @<> '');
      sDim48 = V52;
      nDimCount = 48;
    EndIf;
    If(TRIM(V53) @<> '');
      sDim49 = V53;
      nDimCount = 49;
    EndIf;
    If(TRIM(V54) @<> '');
      sDim50 = V54;
      nDimCount = 50;
    EndIf;
    If(TRIM(V55) @<> '');
      sDim51 = V55;
      nDimCount = 51;
    EndIf;
    If(TRIM(V56) @<> '');
      sDim52 = V56;
      nDimCount = 52;
    EndIf;
    If(TRIM(V57) @<> '');
      sDim53 = V57;
      nDimCount = 53;
    EndIf;
    If(TRIM(V58) @<> '');
      sDim54 = V58;
      nDimCount = 54;
    EndIf;
    If(TRIM(V59) @<> '');
      sDim55 = V59;
      nDimCount = 55;
    EndIf;
    If(TRIM(V60) @<> '');
      sDim56 = V60;
      nDimCount = 56;
    EndIf;
    If(TRIM(V61) @<> '');
      sDim57 = V61;
      nDimCount = 57;
    EndIf;
    If(TRIM(V62) @<> '');
      sDim58 = V62;
      nDimCount = 58;
    EndIf;
    If(TRIM(V63) @<> '');
      sDim59 = V63;
      nDimCount = 59;
    EndIf;
    If(TRIM(V64) @<> '');
      sDim60 = V64;
      nDimCount = 60;
    EndIf;
  
    If(nDimCount = 2);
      CubeCreate(vObj, sDim1, sDim2);
    ElseIf(nDimCount = 3);
      CubeCreate(vObj, sDim1, sDim2, sDim3);
    ElseIf(nDimCount = 4);
      CubeCreate(vObj, sDim1, sDim2, sDim3, sDim4);
    ElseIf(nDimCount = 5);
      CubeCreate(vObj, sDim1, sDim2, sDim3, sDim4, sDim5);
    ElseIf(nDimCount = 6);
      CubeCreate(vObj, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6);
    ElseIf(nDimCount = 7);
      CubeCreate(vObj, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7);
    ElseIf(nDimCount = 8);
      CubeCreate(vObj, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8);
    ElseIf(nDimCount = 9);
      CubeCreate(vObj, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9);
    ElseIf(nDimCount = 10);
      CubeCreate(vObj, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10);
    ElseIf(nDimCount = 11);
      CubeCreate(vObj, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11);
    ElseIf(nDimCount = 12);
      CubeCreate(vObj, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12);
    ElseIf(nDimCount = 13);
      CubeCreate(vObj, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13);
    ElseIf(nDimCount = 14);
      CubeCreate(vObj, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14);
    ElseIf(nDimCount = 15);
      CubeCreate(vObj, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15);
    ElseIf(nDimCount = 16);
      CubeCreate(vObj, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16);
    ElseIf(nDimCount = 17);
      CubeCreate(vObj, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17);
    ElseIf(nDimCount = 18);
      CubeCreate(vObj, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18);
    ElseIf(nDimCount = 19);
      CubeCreate(vObj, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19);
    ElseIf(nDimCount = 20);
      CubeCreate(vObj, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20);
    ElseIf(nDimCount = 21);
      CubeCreate(vObj, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21);
    ElseIf(nDimCount = 22);
      CubeCreate(vObj, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22);
    ElseIf(nDimCount = 23);
      CubeCreate(vObj, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23);
    ElseIf(nDimCount = 24);
      CubeCreate(vObj, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24);
    ElseIf(nDimCount = 25);
      CubeCreate(vObj, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25);
    ElseIf(nDimCount = 26);
      CubeCreate(vObj, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26);
    ElseIf(nDimCount = 27);
      CubeCreate(vObj, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27);
    ElseIf(nDimCount = 28);
      CubeCreate(vObj, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28);
    ElseIf(nDimCount = 29);
      CubeCreate(vObj, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29);
    ElseIf(nDimCount = 30);
      CubeCreate(vObj, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30);
    ElseIf(nDimCount = 31);
      CubeCreate(vObj, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31);
    ElseIf(nDimCount = 32);
      CubeCreate(vObj, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32);
    ElseIf(nDimCount = 33);
      CubeCreate(vObj, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33);
    ElseIf(nDimCount = 34);
      CubeCreate(vObj, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34);
    ElseIf(nDimCount = 35);
      CubeCreate(vObj, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35);
    ElseIf(nDimCount = 36);
      CubeCreate(vObj, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36);
    ElseIf(nDimCount = 37);
      CubeCreate(vObj, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37);
    ElseIf(nDimCount = 38);
      CubeCreate(vObj, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38);
    ElseIf(nDimCount = 39);
      CubeCreate(vObj, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39);
    ElseIf(nDimCount = 40);
      CubeCreate(vObj, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40);
    ElseIf(nDimCount = 41);
      CubeCreate(vObj, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41);
    ElseIf(nDimCount = 42);
      CubeCreate(vObj, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42);
    ElseIf(nDimCount = 43);
      CubeCreate(vObj, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43);
    ElseIf(nDimCount = 44);
      CubeCreate(vObj, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44);
    ElseIf(nDimCount = 45);
      CubeCreate(vObj, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44, sDim45);
    ElseIf(nDimCount = 46);
      CubeCreate(vObj, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44, sDim45, sDim46);
    ElseIf(nDimCount = 47);
      CubeCreate(vObj, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44, sDim45, sDim46, sDim47);
    ElseIf(nDimCount = 48);
      CubeCreate(vObj, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44, sDim45, sDim46, sDim47, sDim48);
    ElseIf(nDimCount = 49);
      CubeCreate(vObj, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44, sDim45, sDim46, sDim47, sDim48, sDim49);
    ElseIf(nDimCount = 50);
      CubeCreate(vObj, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44, sDim45, sDim46, sDim47, sDim48, sDim49, sDim50);
    ElseIf(nDimCount = 51);
      CubeCreate(vObj, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44, sDim45, sDim46, sDim47, sDim48, sDim49, sDim50, sDim51);
    ElseIf(nDimCount = 52);
      CubeCreate(vObj, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44, sDim45, sDim46, sDim47, sDim48, sDim49, sDim50, sDim51, sDim52);
    ElseIf(nDimCount = 53);
      CubeCreate(vObj, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44, sDim45, sDim46, sDim47, sDim48, sDim49, sDim50, sDim51, sDim52, sDim53);
    ElseIf(nDimCount = 54);
      CubeCreate(vObj, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44, sDim45, sDim46, sDim47, sDim48, sDim49, sDim50, sDim51, sDim52, sDim53, sDim54);
    ElseIf(nDimCount = 55);
      CubeCreate(vObj, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44, sDim45, sDim46, sDim47, sDim48, sDim49, sDim50, sDim51, sDim52, sDim53, sDim54, sDim55);
    ElseIf(nDimCount = 56);
      CubeCreate(vObj, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44, sDim45, sDim46, sDim47, sDim48, sDim49, sDim50, sDim51, sDim52, sDim53, sDim54, sDim55, sDim56);
    ElseIf(nDimCount = 57);
      CubeCreate(vObj, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44, sDim45, sDim46, sDim47, sDim48, sDim49, sDim50, sDim51, sDim52, sDim53, sDim54, sDim55, sDim56, sDim57);
    ElseIf(nDimCount = 58);
      CubeCreate(vObj, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44, sDim45, sDim46, sDim47, sDim48, sDim49, sDim50, sDim51, sDim52, sDim53, sDim54, sDim55, sDim56, sDim57, sDim58);
    ElseIf(nDimCount = 59);
      CubeCreate(vObj, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44, sDim45, sDim46, sDim47, sDim48, sDim49, sDim50, sDim51, sDim52, sDim53, sDim54, sDim55, sDim56, sDim57, sDim58, sDim59);
    ElseIf(nDimCount = 60);
      CubeCreate(vObj, sDim1, sDim2, sDim3, sDim4, sDim5, sDim6, sDim7, sDim8, sDim9, sDim10, sDim11, sDim12, sDim13, sDim14, sDim15, sDim16, sDim17, sDim18, sDim19, sDim20, sDim21, sDim22, sDim23, sDim24, sDim25, sDim26, sDim27, sDim28, sDim29, sDim30, sDim31, sDim32, sDim33, sDim34, sDim35, sDim36, sDim37, sDim38, sDim39, sDim40, sDim41, sDim42, sDim43, sDim44, sDim45, sDim46, sDim47, sDim48, sDim49, sDim50, sDim51, sDim52, sDim53, sDim54, sDim55, sDim56, sDim57, sDim58, sDim59, sDim60);
    EndIf;
    
    
    TextOutput(sOutput, NumberToString(NOW), 'Created Cube', vObj);
  
  EndIf;
  
ElseIf(vObjType @= 'Element');
  
  If(vOp @= 'DELETE');
  
    DimensionElementDelete(vObj, V5);
    TextOutput(sOutput, NumberToString(NOW), 'Deleted Element', vObj, V5);
    
  ElseIf(vOp @= 'ADD');
    
    sInsertPoint = '';
    If(TRIM(V7) @<> '');
      If(DIMIX(vObj, V7) > 0);
        sInsertPoint = V7;
      EndIf;
    EndIf; 

    DimensionElementInsert(vObj, sInsertPoint, V5, V6);
    TextOutput(sOutput, NumberToString(NOW), 'Added Element', vObj, V5);

  ElseIf(vOp @= 'ADDCOMPONENT');
  
    IF (DTYPE(vObj, v6) @= 'S');
        TextOutput(sOutput, NumberToString(NOW), '**** WARNING **** String element ' | V6 | ' cannot be added as members of the Consolidated parent ' | V5 | ', this operation will be ignored: ', vObj, V5, V6);
    ELSE;
        DimensionElementComponentAdd(vObj, V5, V6, StringToNumber(V7));
        TextOutput(sOutput, NumberToString(NOW), 'Added Component', vObj, V5, V6);
    ENDIF;
  
  ElseIf(vOp @= 'DELETECOMPONENT');
  
    DimensionElementComponentDelete(vObj, V5, V6);
    TextOutput(sOutput, NumberToString(NOW), 'Deleted Component', vObj, V5, V6);
    
  EndIf;
  
ElseIf(vObjType @= 'Attribute');
  
  If(vOp @= 'DELETE');
  
    AttrDelete(vObj, V5);
    TextOutput(sOutput, NumberToString(NOW), 'Deleted Attribute', vObj, V5, V6);
    
  ElseIf(vOp @= 'ADD');
  
    AttrInsert(vObj, '', V5, V6);
    TextOutput(sOutput, NumberToString(NOW), 'Added Attribute', vObj, V5, V6);
  
  EndIf;
  
EndIf;
574,48

#****Begin: Generated Statements***
#****End: Generated Statements****

If(d = 0);
  d = 1;
  SetOutputCharacterSet( sOutputData, 'TM1CS_UTF8'  );
EndIf;

If(vObjType @= 'Attribute');
  
  If(vOp @= 'VALUE');

      sAttrCube = '}ElementAttributes_' | vObj;
      nIsUpdateable = CellIsUpdateable (sAttrCube, V5, V6);
   
     IF (nIsUpdateable = 1);
  
         If(V8 @= 'N');

           AttrPutN(StringToNumber(V7), vObj, V5, V6);
           TextOutput(sOutputData, NumberToString(NOW), 'Updated Attribute', vObj, V5, V6, V7);
      
         Else;
    
           AttrPutS(V7, vObj, V5, V6);
            TextOutput(sOutputData, NumberToString(NOW), 'Updated Attribute', vObj, V5, V6, V7);
    
         EndIf;

    ELSE;

           TextOutput(sOutputData, NumberToString(NOW), 'Rule applies for the Attribute, update will not be perfomed, skipping', vObj, V5, V6, V7);

    ENDIF;
  
  EndIf;
  
ElseIf(vObjType @= 'Rule');
  
  If(vOp @= 'UPDATE');
  
    RuleLoadFromFile(vObj, pPackPath | 'rules\' | vObj | '.RUX');
    TextOutput(sOutputData, NumberToString(NOW), 'Updated Rule', vObj);
  
  EndIf;
  
EndIf;
575,4

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
