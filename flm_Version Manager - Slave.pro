601,100
602,"flm_Version Manager - Slave"
562,"VIEW"
586,"sys_Dummy"
585,"sys_Dummy"
564,
565,"wD]FDriB4RKhfFtKXuyDquaa_dJ4ECaT:Uwgsc^qSY<`Xp`fI;7qK^sV9j[Z6mI`dm@paTjMFPN4IEol_?ozm:jHSxwta\HCVOyH[yp[YCiueDbZ]X9dA\75\Tq:QpMW<I9N:c]Rxy]xeZ8[vYH7ai9ct8ILN\W_asSFQ@FFnlbbvM7;t^c@T`\dk7G:g]w204F=XgL6"
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
570,Default
571,
569,0
592,0
599,1000
560,3
sCube
srcParams
destParams
561,3
2
2
2
590,3
sCube,""
srcParams,""
destParams,""
637,3
sCube,""
srcParams,""
destParams,""
577,18
V1
V2
V3
V4
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
NVALUE
SVALUE
VALUE_IS_STRING
578,18
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
1
2
1
579,18
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
0
0
0
580,18
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
581,18
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
582,16
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
IgnoredInputVarName=ValueVarType=33ColType=1165
603,0
572,211

#****Begin: Generated Statements***
#****End: Generated Statements****

#*******************************************************************************************************************************************#
#
# Process:            vm_Version Manager - Slave

# Purpose:            This process will copy data from 1 part of a cube to another.
#                           It takes 3 parameters sCube, srcParams and destParams.
#                           srcParams and destParama are both of the form 'Dim1;Element1|Dim2;Element2|...|Dimn;Elementn'.
#                                  There can only be 1 element selected for each dimension.
#                           The process can work on any cube with 3 to 14 dimensions, but can be modified to work on less or
#                            more if required
#
# Written by:        Malcolm MacDonnell (Excelerated Consulting)
#
# Date:                 2/12/2011
#
#*******************************************************************************************************************************************#

#-------------------------------------------------------------------------------
#    CUBES
#-------------------------------------------------------------------------------
cbPref = 'Client Preferences';
cbLeaseDetails = 'flm_Finance Lease Details';
cbLeaseSchedule = 'flm_Finance Lease Schedule';
cbLeaseVariations = 'flm_Finance Lease Variations';
cbLeaseComponent = 'flm_Finance Lease Components';
cbLeaseMenu = 'flm_Finance Lease Menu';
cbClient = 'sys_Client Preferences';

#-------------------------------------------------------------------------------
#    DIMENSIONS
#-------------------------------------------------------------------------------
dmMonth = 'Month';
dmClient = '}Clients';

#-------------------------------------------------------------------------------
#    PARAMETERS
#-------------------------------------------------------------------------------
sUser = ATTRS(dmClient, TM1User, 'Non_CAM_ID');
sSrc = '}' | sCube | 'SYSTEMec_tdrc_src';	
sDest = '}' | sCube | 'SYSTEMec_tdrc_dest';
nChange = 1;

#-----------------------------------------------------------------------------
#    GET TODAYS DATE
#-----------------------------------------------------------------------------
sYear = SUBST(TODAY(1), 1, 4);
sMonth =  SUBST(TODAY(1), 6, 2);
IF(SUBST(sMonth, 1, 1) @= '0');
      sMonth = SUBST(sMonth, 2, 1);
ENDIF;

IF( DIMIX(dmMonth, sMonth) <> 0);
      sMonth =DIMNM(dmMonth, DIMIX(dmMonth, sMonth) + 6);
ENDIF;
sDay = SUBST(TODAY(1), 9, 2);
sDate = sDay | ' ' | sMonth | ' ' | sYear;

#-------------------------------------------------------------------------------
#    TURN OFF CUBE LOGGING
#-------------------------------------------------------------------------------
CUBESETLOGCHANGES (sCube, 0);

#-------------------------------------------------------------------------------
#    COUNT THE DIMS IN THE CUBE
#-------------------------------------------------------------------------------
nIdx = 1;
WHILE (TABDIM (sCube, nIdx) @<> '');
      nIdx = nIdx + 1;
END;
nDimCount = nIdx -1;

#-------------------------------------------------------------------------------
#    DESTROY OLD VIEWS
#-------------------------------------------------------------------------------
VIEWDESTROY (sCube, sSrc);
VIEWDESTROY (sCube, sDest);
VIEWCREATE (sCube, sSrc);
VIEWCREATE (sCube, sDest);

#-------------------------------------------------------------------------------
#    BUILD SOURCE SUBSETS AND VIEWS
#-------------------------------------------------------------------------------
sDims = srcParams;
nIdx = SCAN (';', sDims);
sDim = TRIM (SUBST (sDims, 1, nIdx -1));
sDims = SUBST (sDims, nIdx +1, LONG (sDims));

# parse the srcParams into dimensions and elements
WHILE (sDim @<> '');

      SUBSETDESTROY (sDim, sSrc);
      SUBSETCREATE (sDim, sSrc);

      # Get the element
      nIdx = SCAN ('|', sDims);

      IF(nIdx = 0);
            nIdx = LONG (sDims) + 1;
      ENDIF;

      sEl = TRIM (SUBST (sDims, 1, nIdx -1));
      sDims = SUBST (sDims, nIdx +1, LONG (sDims));

      # If Consolidated get all the N-level components
      IF(DTYPE (sDim, sEl) @= 'C');
            nDimSize = DIMSIZ (sDim);
            nElIdx = 1;

            WHILE (nElIdx <= nDimSize);
                  sComp = DIMNM (sDim, nElIdx);

                  IF(ELISANC (sDim, sEl, sComp) = 1);
                        SUBSETELEMENTINSERT (sDim, sSrc, sComp, 1);
                  EndIf;

                  nElIdx = nElIdx +1;
            END;
            SUBSETELEMENTINSERT (sDim, sSrc, sEl, 1);
      ELSE;
            SUBSETELEMENTINSERT (sDim, sSrc, sEl, 1);

      ENDIF;

      # Add it to the view
      VIEWSUBSETASSIGN (sCube, sSrc, sDim, sSrc);

      # Get the next Dim
      nIdx = SCAN (';', sDims);
      sDim = TRIM (SUBST (sDims, 1, nIdx -1));
      sDims = SUBST (sDims, nIdx +1, LONG (sDims));

END;

#-------------------------------------------------------------------------------
#    BUILD TARGET SUBSETS AND VIEWS
#-------------------------------------------------------------------------------
sDims = destParams;
nIdx = SCAN (';', sDims);
sDim = TRIM (SUBST (sDims, 1, nIdx -1));
sDims = SUBST (sDims, nIdx +1, LONG (sDims));

# parse the destParams into dimensions and elements
WHILE (sDim @<> '');
      SUBSETDESTROY (sDim, sDest);
      SUBSETCREATE (sDim, sDest);

      # Get the element
      nIdx = SCAN ('|', sDims);

      IF(nIdx = 0);
            nIdx = LONG (sDims) + 1;
      ENDIF;

      sEl = TRIM (SUBST (sDims, 1, nIdx -1));
      sDims = SUBST (sDims, nIdx +1, LONG (sDims));

      # If Consolidated get all the N-level components
      IF(DTYPE (sDim, sEl) @= 'C');
            nDimSize = DIMSIZ (sDim);
            nElIdx = 1;

            WHILE (nElIdx <= nDIMSIZe);
                  sComp = DIMNM (sDim, nElIdx);

                  IF(ELISANC (sDim, sEl, sComp) = 1);
                        SUBSETELEMENTINSERT (sDim, sDest, sComp, 1);
                  ENDIF;

                  nElIdx = nElIdx +1;
            End;
            SUBSETELEMENTINSERT (sDim, sDest, sEl, 1);
      ELSE;
            SUBSETELEMENTINSERT (sDim, sDest, sEl, 1);
      ENDIF;

      # Add it to the view
      VIEWSUBSETASSIGN (sCube, sDest, sDim, sDest);

      # Get the next Dim
      nIdx = SCAN (';', sDims);
      sDim = TRIM (SUBST (sDims, 1, nIdx -1));
      sDims = SUBST (sDims, nIdx +1, LONG (sDims));
END;

#**** Fix up the views
VIEWEXTRACTSKIPCALCSSET (sCube, sSrc, 1);
VIEWEXTRACTSKIPZEROESSET(sCube, sSrc, 1);
VIEWEXTRACTSKIPRULEVALUESSET(sCube, sSrc, 0);

VIEWEXTRACTSKIPCALCSSET(sCube, sDest, 1);
VIEWEXTRACTSKIPZEROESSET(sCube, sDest, 1);
VIEWEXTRACTSKIPRULEVALUESSET(sCube, sDest, 0);

#-------------------------------------------------------------------------------
#    CLEAR TARGET VIEW
#-------------------------------------------------------------------------------
IF(srcParams @<> destParams);
      VIEWZEROOUT (sCube, sDest);
ENDIF;

#-------------------------------------------------------------------------------
#    SETUP THE DATASOURCE
#-------------------------------------------------------------------------------
DATASOURCENAMEFORSERVER = sCube;
DATASOURCENAMEFORCLIENT = sCube;
DATASOURCETYPE = 'VIEW';
DATASOURCECUBEVIEW = sSrc; 
573,3

#****Begin: Generated Statements***
#****End: Generated Statements****
574,188

#****Begin: Generated Statements***
#****End: Generated Statements****

# Swap values in destination dimensions
sDims = destParams;
nIdx = SCAN (';', sDims);
sDim = TRIM (SUBST (sDims, 1, nIdx -1));
sDims = SUBST (sDims, nIdx +1, LONG (sDims));

WHILE (sDim @<> '');
      # Get the element
      nIdx = SCAN ('|', sDims);
      sEl = TRIM (SUBST (sDims, 1, nIdx -1));
      sDims = SUBST (sDims, nIdx +1, LONG (sDims));

      IF(DTYPE (sDim, sEl) @= 'N');

            # Replace the destination element
            IF(TABDIM (sCube, 1) @= sDim);
                  V1 = sEl;
            ELSEIF (TABDIM (sCube, 2) @= sDim);
                  V2 = sEl;
            ELSEIF (TABDIM (sCube, 3) @= sDim);
                  V3 = sEl;
            ELSEIF (TABDIM (sCube, 4) @= sDim);
                  V4 = sEl;
            ELSEIF (TABDIM (sCube, 5) @= sDim);
                  V5 = sEl;
            ELSEIF (TABDIM (sCube, 6) @= sDim);
                  V6 = sEl;
            ELSEIF (TABDIM (sCube, 7) @= sDim);
                  V7 = sEl;
            ELSEIF (TABDIM (sCube, 8) @= sDim);
                  V8 = sEl;
            ELSEIF (TABDIM (sCube, 9) @= sDim);
                  V9 = sEl;
            ELSEIF (TABDIM (sCube, 10) @= sDim);
                  V10 = sEl;
            ELSEIF (TABDIM (sCube, 11) @= sDim);
                  V11 = sEl;
            ELSEIF (TABDIM (sCube, 12) @= sDim);
                  V12 = sEl;
            ELSEIF (TABDIM (sCube, 13) @= sDim);
                  V13 = sEl;
            ELSEIF (TABDIM (sCube, 14) @= sDim);
                  V14 = sEl;
            ELSEIF (TABDIM (sCube, 15) @= sDim);
                  V15 = sEl;
            ENDIF;
      ENDIF;

      # Get the next Dim
      nIdx = SCAN (';', sDims);
      sDim = TRIM (SUBST (sDims, 1, nIdx -1));
      sDims = SUBST (sDims, nIdx +1, LONG (sDims));

END;

# Get the name of the last dim to test type
sMeasure = TABDIM (sCube, nDimCount);

# Make the process work for cubes from 3 to 15 dims

IF(nDimCount = 3);
      IF(CELLISUPDATEABLE (sCube, V1, V2, V3) =1);
            IF(DTYPE (sMeasure, V3) @= 'N');
                  CELLPUTN (NUMBR (V4) * nChange, sCube, V1, V2, V3);
            ELSE;
                  CELLPUTS (V4, sCube, V1, V2, V3);
            ENDIF;
      ENDIF;
ELSEIF (nDimCount = 4);
      IF(CELLISUPDATEABLE (sCube, V1, V2, V3, V4) =1);
            IF(DTYPE (sMeasure, V4) @= 'N');
                  CELLPUTN (NUMBR (V5) * nChange, sCube, V1, V2, V3, V4);
            ELSE;
                  CELLPUTS (V5, sCube, V1, V2, V3, V4);
            ENDIF;
      ENDIF;
ELSEIF (nDimCount = 5);
      IF(CELLISUPDATEABLE (sCube, V1, V2, V3, V4, V5) =1);
            IF(DTYPE (sMeasure, V5) @= 'N');
                  CELLPUTN (NUMBR (V6) * nChange, sCube, V1, V2, V3, V4, V5);
            ELSE;
                  CELLPUTS (V6, sCube, V1, V2, V3, V4, V5);
            ENDIF;
      ENDIF;
ELSEIF (nDimCount = 6);
      IF(CELLISUPDATEABLE (sCube, V1, V2, V3, V4, V5, V6) =1);
            IF(DTYPE (sMeasure, V6) @= 'N');
                  CELLPUTN (NUMBR (V7) * nChange, sCube, V1, V2, V3, V4, V5, V6);
            ELSE;
                  CELLPUTS (V7, sCube, V1, V2, V3, V4, V5, V6);
            ENDIF;
      ENDIF;
ELSEIF (nDimCount = 7);
      IF(CELLISUPDATEABLE (sCube, V1, V2, V3, V4, V5, V6, V7) =1);
            IF(DTYPE (sMeasure, V7) @= 'N');
                  CELLPUTN (Numbr (V8) * nChange, sCube, V1, V2, V3, V4, V5, V6, V7);
            ELSE;
                  CELLPUTS (V8, sCube, V1, V2, V3, V4, V5, V6, V7);
            ENDIF;
      ENDIF;
ELSEIF (nDimCount = 8);
      IF(CELLISUPDATEABLE (sCube, V1, V2, V3, V4, V5, V6, V7, V8) =1);
            IF(DTYPE (sMeasure, V8) @= 'N');
                  CELLPUTN (Numbr (V9) * nChange, sCube, V1, V2, V3, V4, V5, V6, V7, V8);
            ELSE;
                  CELLPUTS (V9, sCube, V1, V2, V3, V4, V5, V6, V7, V8);
            ENDIF;
      ENDIF;
ELSEIF (nDimCount = 9);
      IF(CELLISUPDATEABLE (sCube, V1, V2, V3, V4, V5, V6, V7, V8, V9) =1);
            IF(DTYPE (sMeasure, V9) @= 'N');
                  CELLPUTN (Numbr (V10) * nChange, sCube, V1, V2, V3, V4, V5, V6, V7, V8, V9);
            ELSE;
                  CELLPUTS (V10, sCube, V1, V2, V3, V4, V5, V6, V7, V8, V9);
            ENDIF;
      ENDIF;
ELSEIF (nDimCount = 10);
      IF(CELLISUPDATEABLE (sCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10) =1);
            IF(DTYPE (sMeasure, V10) @= 'N');
                  CELLPUTN (Numbr (V11) * nChange, sCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10);
            ELSE;
                  CELLPUTS (V11, sCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10);
            ENDIF;
      ENDIF;
ELSEIF (nDimCount = 11);
      IF(CELLISUPDATEABLE (sCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11) =1);
            IF(DTYPE (sMeasure, V11) @= 'N');
                  CELLPUTN (Numbr (V12) * nChange, sCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11);
            ELSE;
                  CELLPUTS (V12, sCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11);
            ENDIF;
      ENDIF;
ELSEIF (nDimCount = 12);
      IF(CELLISUPDATEABLE (sCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12) =1);
            IF(DTYPE (sMeasure, V12) @= 'N');
                  CELLPUTN (Numbr (V13) * nChange, sCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12);
            ELSE;
                  CELLPUTS (V13, sCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12);
            ENDIF;
      ENDIF;
ELSEIF (nDimCount = 13);
      IF(CELLISUPDATEABLE (sCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12, V13) =1);
            IF(DTYPE (sMeasure, V13) @= 'N');
                  CELLPUTN (Numbr (V14) * nChange, sCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12, V13);
            Else;
                  CELLPUTS (V14, sCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12, V13);
            ENDIF;
      ENDIF;
ELSEIF (nDimCount = 14);
      IF(CELLISUPDATEABLE (sCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12, V13, V14) =1);
            IF(DTYPE (sMeasure, V14) @= 'N');
                  CELLPUTN (Numbr (V15) * nChange, sCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12, V13, V14);
            ELSE;
                  CELLPUTS (V15, sCube, V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12, V13, V14);
            ENDIF;
      ENDIF;
ENDIF;

#-----------------------------------------------------------------------------
#    UPDATE FINANCE LEASE VARIATIONS
#-----------------------------------------------------------------------------
IF(sCube @= 'flm_Finance Lease Details');

      # ---- PickList
      sCurrentPicklist = CELLGETS(cbLeaseVariations, V2, 'Picklist');
      IF(SCAN(V1, sCurrentPicklist) = 0);
            sNewPicklist = sCurrentPicklist | ':' | V1;
            CELLPUTS(sNewPicklist, cbLeaseVariations, V2, 'Picklist');
      ENDIF;

      # ---- Created By
      CELLPUTS(sUser, cbLeaseDetails, V1, V2, 'Created By');

      # ---- Date Created
      CELLPUTS(sDate, cbLeaseDetails, V1, V2, 'Date Created');

      # ---- Variation Status
      CELLPUTS('Current', cbLeaseDetails, V1, V2, 'Variation Status');

      # ---- Previous Variation
      CELLPUTS('', cbLeaseDetails, V1, V2, 'Previous Variation');

ENDIF;

575,51

#****Begin: Generated Statements***
#****End: Generated Statements****

#-------------------------------------------------------------------------------
#    DESTROY SOURCE VIEWS AND SUBSETS
#-------------------------------------------------------------------------------
VIEWDESTROY(sCube, sSrc);

sDims = srcParams;
nIdx = SCAN (';', sDims);
sDim = TRIM (SUBST (sDims, 1, nIdx -1));
sDims = SUBST (sDims, nIdx +1, LONG (sDims));

WHILE(sDim @<> '');

      SUBSETDESTROY (sDim, sSrc);

      # Get the next Dim
      nIdx = SCAN ('|', sDims);
      sDims = SUBST (sDims, nIdx +1, LONG (sDims));
      nIdx = SCAN (';', sDims);
      sDim = TRIM (SUBST (sDims, 1, nIdx -1));
      sDims = SUBST (sDims, nIdx +1, LONG (sDims));
END;

#-------------------------------------------------------------------------------
#    DESTROY TARGET VIEWS AND SUBSETS
#-------------------------------------------------------------------------------
VIEWDESTROY (sCube, sDest);

sDims = destParams;
nIdx = SCAN (';', sDims);
sDim = TRIM (SUBST (sDims, 1, nIdx -1));
sDims = SUBST (sDims, nIdx +1, LONG (sDims));

WHILE(sDim @<> '');
      SUBSETDESTROY(sDim, sDest);

      # Get the next Dim
      nIdx = SCAN ('|', sDims);
      sDims = SUBST (sDims, nIdx +1, LONG (sDims));
      nIdx = SCAN (';', sDims);
      sDim = TRIM (SUBST (sDims, 1, nIdx -1));
      sDims = SUBST (sDims, nIdx +1, LONG (sDims));
END;

#-------------------------------------------------------------------------------
#    TURN ON CUBE LOGGING
#-------------------------------------------------------------------------------
CUBESETLOGCHANGES (sCube, 1);
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
