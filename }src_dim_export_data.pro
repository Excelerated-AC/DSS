601,100
602,"}src_dim_export_data"
562,"SUBSET"
586,"}Dimensions"
585,"}Dimensions"
564,
565,"lElC=q;S:Po<auRnMLD576819pWkiyTp0q^t2DwO?R[jw?B20c;=_b>u3kzyZ=C?F`mTNg8XFXkcJ7elFOzB:B>qKAI9qikb^hwtIALSy<3o2AHoyHm`8Jy;8z[owXrOq[Q_:j9Q;EDfcpu]x4VpNOddZC<H;8imtMyPNhhRuS0uO`adQ=x5f6v1?MD8CDSGGzq3?;O0"
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
560,3
pDimName
pPath
pMaxElements
561,3
2
2
1
590,3
pDimName,""
pPath,""
pMaxElements,0
637,3
pDimName,"The name of the dimension"
pPath,"The directory to export the file to"
pMaxElements,"Maximum dimension size"
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
572,125

#****Begin: Generated Statements***
#****End: Generated Statements****


sDataFileName = pPath;
DatasourceASCIIQuoteCharacter = '';
DatasourceASCIIDelimiter = CHAR(9);
cCubeProperties = '}CubeProperties';

IF (DimensionExists(pDimName) = 1);

  nFill = 1;

  sSubset = '}Export.All';
  If( SubsetExists( pDimName, sSubset ) = 0 );
    SubsetCreate(  pDimName, sSubset );
    SubsetIsAllSet(  pDimName, sSubset, 1 );
  EndIf;

  ### Assign Data Source ###

  DatasourceNameForServer =  pDimName;
  DatasourceNameForClient =  pDimName;
  DataSourceType = 'SUBSET';
  DatasourceDimensionSubset = sSubset;

  i = 0;

  SetOutputCharacterSet( sDataFileName, 'TM1CS_UTF8'  );

  If(DIMSIZ(pDimName) = 0);
     sSectionName = 'Statistics:=';
    TEXTOUTPUT(sDataFileName, sSectionName);
    nDimSiz = DimSiz( pDimName );
    TEXTOUTPUT(sDataFileName, Fill(' ', nFill) | 'Elements:=' | NumberToString(nDimSiz));

    # NUMBER OF ELEMENTS & HIERARCHIES & LEVELS
    eCount = 1;
    nNLevel = 0;
    nHierarchies = 0;
    nEmptyConsols = 0;
    nOrphans = 0;
    nStrings = 0;
    While( eCount <= nDimSiz );
      vElName = DimNm( pDimName, eCount );
      IF( DType( pDimName, vElName ) @= 'N' );
        nNLevel = nNLevel + 1;
        If(ElPar( pDimName, vElName, 1 ) @= '');
          nOrphans = nOrphans + 1;
        EndIf;
      ElseIf ( DType( pDimName, vElName ) @= 'C' );
        If( ElCompN( pDimName, vElName ) > 0 & ElPar( pDimName, vElName, 1 ) @= '' );
          nHierarchies = nHierarchies + 1;
        ElseIf ( ElCompN( pDimName, vElName ) = 0);
          nEmptyConsols = nEmptyConsols + 1;
        EndIF;
      ElseIf ( DType( pDimName, vElName ) @= 'S' );
        nStrings = nStrings + 1;
      EndIf;
      eCount = eCount + 1;
    End;
    TEXTOUTPUT(sDataFileName, Fill(' ', nFill) | 'Hierarchies:=' | NumberToString(nHierarchies));   
    TEXTOUTPUT(sDataFileName, Fill(' ', nFill) | 'NElements:=' | NumberToString(nNLevel));
    TEXTOUTPUT(sDataFileName, Fill(' ', nFill) | 'SElements:=' | NumberToString(nStrings));
    TEXTOUTPUT(sDataFileName, Fill(' ', nFill) | 'EmptyConsols:=' | NumberToString(nEmptyConsols));
    TEXTOUTPUT(sDataFileName, Fill(' ', nFill) | 'Orphans:=' | NumberToString(nOrphans));
    nDnLev = DnLev( pDimName );
    TEXTOUTPUT(sDataFileName, Fill(' ', nFill) | 'Levels:=' | NumberToString(nDnLev));
    
    sAttrDimName = '}ElementAttributes_' | pDimName;
    nAttrCount = DIMSIZ( sAttrDimName );
    TEXTOUTPUT(sDataFileName, Fill(' ', nFill) | 'Attributes:=' | NumberToString(nAttrCount));   
    
    cCount = 1;
    iCount = 0;
    vNumCubes = DimSiz( '}Cubes' );
    While( cCount <= vNumCubes );
      sCubeName = DimNm( '}Cubes', cCount );
      cMaxDims = 30;
      vDimIndex = 1;
      
      nProcessCube = 1;
      If(CubeExists(cCubeProperties) = 1);
        sLoadOnDemand = CellGetS (cCubeProperties, sCubeName, 'DEMANDLOAD');
         If( sLoadOnDemand @= 'YES' );
            nProcessCube = 0;
        EndIf;
      EndIf;
      
      if( nProcessCube = 1 );
        While( vDimIndex <= cMaxDims );
          sDimTest = TabDim( sCubeName, vDimIndex );
          IF( sDimTest @= pDimName );
            # Don't include the control objects
            IF( SUBST(sCubeName,1,1) @<> '}');
              iCount = iCount + 1;
              vDimIndex = cMaxDims + 1;
            ENDIF;
          EndIF;
          vDimIndex = vDimIndex + 1;
        End;
      EndIf;
      cCount = cCount + 1;
    End;
    
    TEXTOUTPUT(sDataFileName, Fill(' ', nFill) | 'Cubes:=' | NumberToString(iCount));
    
    TEXTOUTPUT(sDataFileName, '');

    TEXTOUTPUT(sDataFileName, '---');

    TEXTOUTPUT(sDataFileName, '');

  EndIf;


ELSE;

  DataSourceType = 'NULL';

ENDIF;



573,5

#****Begin: Generated Statements***
#****End: Generated Statements****


574,168

#****Begin: Generated Statements***
#****End: Generated Statements****

i = i + 1;

If( i = 1);

   SetOutputCharacterSet( sDataFileName, 'TM1CS_UTF8'  );

   sSectionName = 'Statistics:=';
    TEXTOUTPUT(sDataFileName, sSectionName);
    nDimSiz = DimSiz( pDimName );
    TEXTOUTPUT(sDataFileName, Fill(' ', nFill) | 'Elements:=' | NumberToString(nDimSiz));

    # NUMBER OF ELEMENTS & HIERARCHIES & LEVELS
    eCount = 1;
    nNLevel = 0;
    nHierarchies = 0;
    nEmptyConsols = 0;
    nOrphans = 0;
    nStrings = 0;
    While( eCount <= nDimSiz );
      
      vElName = DimNm( pDimName, eCount );
      
      If(DimIx(pDimName, vElName) > 0);
        IF( DType( pDimName, vElName ) @= 'N' );
          nNLevel = nNLevel + 1;
          If(ElPar( pDimName, vElName, 1 ) @= '');
            nOrphans = nOrphans + 1;
          EndIf;
        ElseIf ( DType( pDimName, vElName ) @= 'C' );
          If( ElCompN( pDimName, vElName ) > 0 & ElPar( pDimName, vElName, 1 ) @= '' );
            nHierarchies = nHierarchies + 1;
          ElseIf ( ElCompN( pDimName, vElName ) = 0);
            nEmptyConsols = nEmptyConsols + 1;
        EndIF;
        ElseIf ( DType( pDimName, vElName ) @= 'S' );
          nStrings = nStrings + 1;
        EndIf;
      EndIf;
      
      eCount = eCount + 1;
      
    End;
    TEXTOUTPUT(sDataFileName, Fill(' ', nFill) | 'Hierarchies:=' | NumberToString(nHierarchies));   
    TEXTOUTPUT(sDataFileName, Fill(' ', nFill) | 'NElements:=' | NumberToString(nNLevel));
    TEXTOUTPUT(sDataFileName, Fill(' ', nFill) | 'SElements:=' | NumberToString(nStrings));
    TEXTOUTPUT(sDataFileName, Fill(' ', nFill) | 'EmptyConsols:=' | NumberToString(nEmptyConsols));
    TEXTOUTPUT(sDataFileName, Fill(' ', nFill) | 'Orphans:=' | NumberToString(nOrphans));
    nDnLev = DnLev( pDimName );
    TEXTOUTPUT(sDataFileName, Fill(' ', nFill) | 'Levels:=' | NumberToString(nDnLev));
    
    sAttrDimName = '}ElementAttributes_' | pDimName;
    nAttrCount = DIMSIZ( sAttrDimName );
    TEXTOUTPUT(sDataFileName, Fill(' ', nFill) | 'Attributes:=' | NumberToString(nAttrCount));   
    
    cCount = 1;
    iCount = 0;
    vNumCubes = DimSiz( '}Cubes' );
    While( cCount <= vNumCubes );
      sCubeName = DimNm( '}Cubes', cCount );
      cMaxDims = 30;
      vDimIndex = 1;
      
      nProcessCube = 1;
      If(CubeExists(cCubeProperties) = 1);
        sLoadOnDemand = CellGetS (cCubeProperties, sCubeName, 'DEMANDLOAD');
         If( sLoadOnDemand @= 'YES' );
            nProcessCube = 0;
        EndIf;
      EndIf;
      
      If( nProcessCube = 1 );
        While( vDimIndex <= cMaxDims );
          sDimTest = TabDim( sCubeName, vDimIndex );
          IF( sDimTest @= pDimName );
            # Don't include the control objects
            IF( SUBST(sCubeName,1,1) @<> '}');
              iCount = iCount + 1;
              vDimIndex = cMaxDims + 1;
            ENDIF;
          EndIF;
          vDimIndex = vDimIndex + 1;
        End;
      EndIf;
      cCount = cCount + 1;
    End;
    
    TEXTOUTPUT(sDataFileName, Fill(' ', nFill) | 'Cubes:=' | NumberToString(iCount));
    
    TEXTOUTPUT(sDataFileName, '');

    TEXTOUTPUT(sDataFileName, '---');

    TEXTOUTPUT(sDataFileName, '');

EndIf;
  
If ( nDimSiz < pMaxElements);

  sEl = vElement;
  If( SCAN (':=', sEl) > 0);
      ItemReject('Element ' | sEl | ' cannot contain :=');
  EndIf;
  TEXTOUTPUT(sDataFileName, sEl | ':=');

  If( DIMIX(pDimName, sEl) <= 0);
    ItemSkip;
  EndIf;
  
  # Type
  sType = DTYPE(pDimName, sEl);
  TEXTOUTPUT(sDataFileName, Fill(' ', nFill) | 'Type:= ' | sType);

  sAttributes = Fill(' ', nFill) | 'Attributes:=';
  TEXTOUTPUT(sDataFileName, sAttributes);
  nAttrCount = DIMSIZ( sAttrDimName );
  a = 1;
  WHILE (a <= nAttrCount);
      sAttr = DIMNM(sAttrDimName , a);
      IF(DimIx(sAttrDimName, sAttr) > 0);
        sAttrTypeOr = DTYPE( sAttrDimName, sAttr);
        sAttrType = sAttrTypeOr;
        sAttrType = SUBST( sAttrType, LONG(sAttrType), 1);
        If( sAttrType @= 'N' );
            IF (CUBEEXISTS (sAttrDimName) = 1 );
                  sAttrVal = NumberToString(CellGetN(sAttrDimName, sEl, sAttr));
            ELSE;
                   sAttrVal = '0';
            ENDIF;
        Else;
           IF (sAttrTypeOr @= 'AS');
                  sAttrVal = ATTRS(pDimName, sEl, sAttr);
           ELSE;
              IF (CUBEEXISTS (sAttrDimName) = 1 );
                sAttrVal = CellGetS(sAttrDimName, sEl, sAttr);
              ELSE;
                sAttrVal = '';
              ENDIF;
           ENDIF;
  
        EndIf;
        TEXTOUTPUT(sDataFileName, Fill(' ', 4) | sAttr | ':= ' | sAttrVal );
      ENDIF;
      a = a + 1;
  END;

  # Loop through all of the parents
  sParents = Fill(' ', nFill) | 'Parents:=';
  TEXTOUTPUT(sDataFileName, sParents);
  nParentCount = ELPARN(pDimName, sEl);
  p = 1;
  WHILE (p <= nParentCount);
      sPar = ELPAR(pDimName,  sEl, p);
      TEXTOUTPUT(sDataFileName, Fill(' ', 4) | sPar | ':= ' | NumberToString(ELWEIGHT(pDimName, sPar, sEl)) );
      p = p + 1;
  END;


  TEXTOUTPUT(sDataFileName, '');

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
