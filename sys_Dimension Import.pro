601,100
602,"sys_Dimension Import"
562,"CHARACTERDELIMITED"
586,"\\TM1-TAMS\TM1_Common_TCCS\TAMS_Upload\Dimension Exports\DT Account BAL-SHEET.cma"
585,"\\TM1-TAMS\TM1_Common_TCCS\TAMS_Upload\Dimension Exports\DT Account BAL-SHEET.cma"
564,
565,"zZ3FwM]x0qU]NGQ?C;[Th>M^Cja34cuM^3X1y1:wSv>wp1\xlF^8EjAU@=om7OH>4F>Ai5h0E;VZdXQqWx9C8Tfpg_e4o<uvzzl?t7x4[;ff;BQqt23wirSLmsDuQ2\Vs9TcFdcT_5@eq=9qySFPntaZ3Q]u3l=0?4a@EuOm]Sn1dlGpvQo;f5PvGpTp2U7Pxst\=IeE"
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
571,
569,0
592,0
599,1000
560,4
psDim
psParent
psAttr
psUnwind
561,4
2
2
2
2
590,4
psDim,"DT Account"
psParent,"OP-RES"
psAttr,"Y"
psUnwind,"Y"
637,4
psDim,""
psParent,""
psAttr,""
psUnwind,""
577,7
vsElNm
vsElTyp
vsChNm
vsChTyp
vsWgt
vsAttrVal
V7
578,7
2
2
2
2
2
2
2
579,7
1
2
3
4
5
6
7
580,7
0
0
0
0
0
0
0
581,7
0
0
0
0
0
0
0
582,7
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
VarType=32ColType=827
603,0
572,73

#****Begin: Generated Statements***
#****End: Generated Statements****


#************************************************************************************************************************************
#**** PROCESS:		sys_Dimension Import
#****
#**** DESCRIPTION:	This is a generic process to import a dimension structure from a flat file.
#****			It loads the dimension from a flat file that was created by the TI
#****			"sys_Sync Generic Dimension Export".
#****
#****			It takes the following parameters:
#****			psDim: The dimension to be imported
#****			psAttr: 'Y' or 'N', to import attributes as well
#****
#**** AUTHOR:		Standard Installation FIle (Excelerated Consulting)
#****
#**** MODIFICATION HISTORY:
#****
#**** Date	Initials	Comments
#**** ====	======	==========
#**** 06/05/2020	EC	Standard Installation File
#****
#************************************************************************************************************************************


#----------------------------------------------------------------------------------------------
#    CUBES
#----------------------------------------------------------------------------------------------
cbVar = 'sys_Variable';
cbAttr = '}ElementAttributes_' | psDim;

#----------------------------------------------------------------------------------------------
#    DIMENSIONS
#----------------------------------------------------------------------------------------------
dmAttr = cbAttr;

#----------------------------------------------------------------------------------------------
#    OTHER PARAMETERS
#----------------------------------------------------------------------------------------------
gsImpDir = CELLGETS(cbVar, 'sys_Import Directory', 'sValue') | 'Dimension Exports\';
gsImpFil = gsImpDir | psDim | ' ' | psParent | '.cma';
nRowCtr = 1;

#----------------------------------------------------------------------------------------------
#    REMOVE ALL CONSOLIDATIONS
#----------------------------------------------------------------------------------------------
IF(psUnwind @= 'Y');
      nCounter = DIMSIZ (psDim);

      WHILE (nCounter > 0);
            sElNm = DIMNM (psDim, nCounter);
	
            IF (DTYPE (psDim, sElNm) @= 'C' & ELISANC(psDim, psParent, sElNm) = 1 % sElNm @= psParent);
                  DIMENSIONELEMENTDELETE (psDim, sElNm);
            ENDIF;
            nCounter = nCounter - 1;
      END;
ENDIF;

#----------------------------------------------------------------------------------------------
#    SET THE DIMENSION SORT ORDER
#----------------------------------------------------------------------------------------------
DIMENSIONSORTORDER (psDim, 'ByName', 'Ascending', 'ByHierarchy', 'Ascending');

#----------------------------------------------------------------------------------------------
#    SET DATA SOURCE
#----------------------------------------------------------------------------------------------
DATASOURCETYPE = 'CHARACTERDELIMITED';
DATASOURCENAMEFORSERVER = gsImpFil;


573,68

#****Begin: Generated Statements***
#****End: Generated Statements****


#----------------------------------------------------------------------------------------------
#    SET VARIABLES
#----------------------------------------------------------------------------------------------
sAttrVal = vsAttrVal;

#----------------------------------------------------------------------------------------------
#    ENSURE THAT THE ATTRIBUTES EXIST
#----------------------------------------------------------------------------------------------
IF (nRowCtr = 1);
      IF (psAttr @='Y');

            # Break the attribute down to individual parts
            WHILE (LONG (sAttrVal) > 0);

                  nIdx= SCAN ('|', sAttrVal);
                  sAttrNm = SUBST (sAttrVal, 1, nIdx - 1);
                  IF( sAttrNm @= 'desc');
                        sAttrNm = 'Description';
                  ELSEIF(sAttrNm @= 'num+desc' );
                        sAttrNm = 'Code and Description';
                  ENDIF;
                  sAttrVal = TRIM (SUBST (sAttrVal, nIdx + 1, LONG (sAttrVal) - nIdx));
                  nIdx= SCAN ('|', sAttrVal);
                  sAttrTyp = SUBST (sAttrVal, 1, nIdx - 1);
                  sAttrVal = TRIM (SUBST (sAttrVal, nIdx + 1, LONG (sAttrVal) - nIdx));
                  nIdx = SCAN ('|', sAttrVal);
			
                  # If the Index is zero, this is the last attribute to populate
                  IF (nIdx = 0);
                        sAttr = sAttrVal;
                        sAttrVal = '';
                  ELSE;
                        sAttr = SUBST (sAttrVal, 1, nIdx - 1);
                        sAttrVal = TRIM (SUBST (sAttrVal, nIdx + 1, LONG (sAttrVal) - nIdx));
                  ENDIF;
			
                  # Insert the attribute value
                  IF (DIMIX (dmAttr, sAttrNm) = 0);
                        ATTRINSERT (psDim, '', sAttrNm, sAttrTyp);
                  ENDIF;
            END;
      ENDIF;

      nRowCtr = nRowCtr + 1;

ENDIF;

#----------------------------------------------------------------------------------------------
#    CREATE THE ELEMENT
#----------------------------------------------------------------------------------------------
DIMENSIONELEMENTINSERT (psDim, '', vsElNm, vsElTyp);

#----------------------------------------------------------------------------------------------
#    CREATE THE CHILD
#----------------------------------------------------------------------------------------------
IF (TRIM (vsChNm) @<> '');
      DIMENSIONELEMENTINSERT (psDim, '', vsChNm, vsChTyp);
      DIMENSIONELEMENTCOMPONENTADD (psDim, vsElNm, vsChNm, STRINGTONUMBER (vsWgt));
ENDIF;




574,63

#****Begin: Generated Statements***
#****End: Generated Statements****



#----------------------------------------------------------------------------------------------
#    SET VARIABLES
#----------------------------------------------------------------------------------------------
sAttrVal = vsAttrVal;

#----------------------------------------------------------------------------------------------
#    POPULATE THE ATTRIBUTES
#----------------------------------------------------------------------------------------------
IF (psAttr @='Y');
      # Break the attribute down to individual parts
      WHILE (LONG (sAttrVal) > 0);

            nIdx= SCAN ('|', sAttrVal);
            sAttrNm = SUBST (sAttrVal, 1, nIdx - 1);
            IF( sAttrNm @= 'desc');
                  sAttrNm = 'Description';
            ELSEIF(sAttrNm @= 'num+desc' );
                  sAttrNm = 'Code and Description';
            ENDIF;
            sAttrVal = TRIM (SUBST (sAttrVal, nIdx + 1, LONG (sAttrVal) - nIdx));
            nIdx= SCAN ('|', sAttrVal);
            sAttrTyp = SUBST (sAttrVal, 1, nIdx - 1);
            sAttrVal = TRIM (SUBST (sAttrVal, nIdx + 1, LONG (sAttrVal) - nIdx));
            nIdx = SCAN ('|', sAttrVal);
		
            # If the Index is zero, this is the last attribute to populate
            IF (nIdx = 0);
                  sAttr = sAttrVal;
                  sAttrVal = '';
            ELSE;
                  sAttr = SUBST (sAttrVal, 1, nIdx - 1);
                  sAttrVal = TRIM (SUBST (sAttrVal, nIdx + 1, LONG (sAttrVal) - nIdx));
            ENDIF;
		
            # Do not populate any of the Picklist attributes
            IF (sAttr @<> 'Picklist');
                  # Add the attribute
                  IF (sAttrTyp @= 'N');
                        ATTRPUTN (STRINGTONUMBER (sAttr), psDim, vsElNm, sAttrNm);
                  ELSE;
                        # Replace any pipes '|' removed during the export
                        nPipeIdx = SCAN ('##PIPE$$', sAttr);
				
                        WHILE (nPipeIdx > 0);
                              sAttr = SUBST (sAttr, 1, nPipeIdx - 1) | '|' | SUBST (sAttr, nPipeIdx + 8, LONG (sAttr) - nPipeIdx - 7);
                              nPipeIdx = SCAN ('##PIPE$$', sAttr);
                        END;
				
                        # Check if an element is already known by this attribute, and the names don't match
                        IF (DTYPE (dmAttr, sAttrNm) @<> 'AA' % 
                        DIMIX (psDim, sAttr) = 0 % DIMIX (psDim, sAttr) = DIMIX (psDim, vsElNm));
                              ATTRPUTS (sAttr, psDim, vsElNm, sAttrNm);
                        ENDIF;
                  ENDIF;
            ENDIF;
      END;
ENDIF;
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
