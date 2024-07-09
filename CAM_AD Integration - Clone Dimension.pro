601,100
602,"CAM_AD Integration - Clone Dimension"
562,"SUBSET"
586,"}Clients"
585,"}Clients"
564,
565,"r\X;nHDBE<ad?2NiAHa5puiZGYLNG^BbVc0u1dn:CZ`Ixld0Q:_S1\`0swa>ZafflLiEC9cOd<7ij1ANw]106K\N:5yIB`BkW\zdbstlnakncW;`yVJKtLP0W3Xl6y8Eu9SyLiv]=y4[:PHDee1UM6wjeDYWZ^XW5zga7H25THbS=RI3hZaY>aWPYGa51UDmD1;Hz2Dm"
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
560,7
pLogOutput
pStrictErrorHandling
pSrcDim
pTgtDim
pHier
pAttr
pDelim
561,7
1
1
2
2
2
1
2
590,7
pLogOutput,1
pStrictErrorHandling,1
pSrcDim,"}Clients"
pTgtDim,"CAM_AD Clients"
pHier,""
pAttr,1
pDelim,""
637,7
pLogOutput,"OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)"
pStrictErrorHandling,"OPTIONAL: On encountering any error, exit with major error status by ProcessQuit after writing to the server message log (Boolean True = 1)"
pSrcDim,"REQUIRED: Source Dimension"
pTgtDim,"OPTIONAL: Target Dimension (will default to pSrcDim_clone If blank (or) is same as pSrcDim)"
pHier,"REQUIRED: Hierarchies to be included (will use default is left blank), accepts wildcards (if = *, then all hierarchies)"
pAttr,"REQUIRED: Include Attributes? (Boolean 1=True)"
pDelim,"OPTIONAL: delimiter character for element list (required if pEle parameter is used) (default value if blank = '&')"
577,1
vEle
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
572,202

#****Begin: Generated Statements***
#****End: Generated Statements****


# ________________________________________________________________________
# 1.0 Start Prolog
# ________________________________________________________________________


# ________________________________________________________________________
  # PreFolded RapidLaunch
  
  # Name: CAM_AD Integration - Clone Dimension

  # Purpose: Generic process to clone a dimension
  
  # Developer | Andrew Craig | 08 Jan 2021
# ________________________________________________________________________



# 1.1 Source information
# ________________________________________________________________________

  # Data Source: TM1 Dimension

  # Parameters: 
        # pLogOutput | Numeric | OPTIONAL: Write parameters and action summary to server message log (Boolean True = 1)
        # pStrictErrorHandling | Numeric | "OPTIONAL: On encountering any error, exit with major error status by ProcessQuit after writing to the server message log (Boolean True = 1)"
        # pSrcDim | String | "REQUIRED: Source Dimension"
        # pTgtDim | String | "OPTIONAL: Target Dimension (will default to pSrcDim_clone If blank (or) is same as pSrcDim)"
        # pHier | String | "REQUIRED: Hierarchies to be included (will use default is left blank), accepts wildcards (if = *, then all hierarchies)"
        # pAttr | Numeric | "REQUIRED: Include Attributes? (Boolean 1=True)"
        # pDelim | String | "OPTIONAL: delimiter character for element list (required if pEle parameter is used) (default value if blank = '&')"

  
  # Variables:  
        # vEle | String - Element
  


# 1.2 Initialise
# ________________________________________________________________________

### Global Variables
StringGlobalVariable ('sProcessReturnCode');
NumericGlobalVariable('nProcessReturnCode');
nProcessReturnCode = 0;

### Constants ###
cThisProcName     = GetProcessName();
cUserName         = TM1User();
cTimeStamp        = TimSt( Now, '\Y\m\d\h\i\s' );
cRandomInt        = NumberToString( INT( RAND( ) * 1000 ));
cSubset           = cThisProcName |'_'| cTimeStamp |'_'| cRandomInt;
cMsgErrorLevel    = 'ERROR';
cMsgErrorContent  = '%cThisProcName% : %sMessage% : %cUserName%';
cMsgInfoContent   = 'User:%cUserName% Process:%cThisProcName% Message:%sMessage%';
cLogInfo          = '***Parameters for Process:%cThisProcName% for pSrcDim:%pSrcDim%, pTgtDim:%pTgtDim%, pHier:%pHier%, pAttr:%pAttr%,  pDelim:%pDelim%.';
cLangDim          = '}Cultures';
nNumLang          = DimSiz( cLangDim );

## LogOutput parameters
IF ( pLogoutput = 1 );
  LogOutput('INFO', Expand( cLogInfo ) );   
ENDIF;




# 1.3 Validations and error handling
# ________________________________________________________________________


### Validate Parameters ###
nErrors = 0;

If( Scan( '*', pSrcDim )=0 &  Scan( '?', pSrcDim )=0 & Scan( pDelim, pSrcDim )=0 & Scan( ':', pSrcDim ) > 0 & pHier @= '' );
    # A hierarchy has been passed as dimension. Handle the input error by splitting dim:hier into dimension & hierarchy
    pHier       = SubSt( pSrcDim, Scan( ':', pSrcDim ) + 1, Long( pSrcDim ) );
    pSrcDim        = SubSt( pSrcDim, 1, Scan( ':', pSrcDim ) - 1 );
EndIf;

## Validate dimension
IF( Trim( pSrcDim ) @= '' );
  nErrors = 1;
  sMessage = 'No source dimension specified.';
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
ElseIF( DimensionExists( pSrcDim ) = 0 );
  nErrors = 1;
  sMessage = 'Invalid source dimension: ' | pSrcDim;
  LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
EndIf;

If( pTgtDim @= '' % pTgtDim @= pSrcDim );
  pTgtDim = pSrcDim | '_Clone';
EndIf;

# Validate hierarchy
IF( Scan( '*', pSrcDim )=0 &  Scan( '?', pSrcDim )=0 & Scan( pDelim, pSrcDim )=0 & pHier @= '');
    pHier = pSrcDim;
ElseIf( Scan( '*', pHier )=0 &  Scan( '?', pHier )=0 & Scan( pDelim, pHier )=0 & pHier @<> '' & HierarchyExists(pSrcDim, pHier) = 0 );
    nErrors = 1;
    sMessage = 'Invalid dimension hierarchy: ' | pHier;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
Endif;

If( Trim( pHier ) @= '' );
    ## use same name as Dimension. Since wildcards are allowed, this is managed inside the code below
EndIf;

## Default delimiter
If( pDelim     @= '' );
    pDelim     = '&';
EndIf;

### Check for errors before continuing
If( nErrors <> 0 );
  If( pStrictErrorHandling = 1 ); 
      ProcessQuit; 
  Else;
      ProcessBreak;
  EndIf;
EndIf;


# 1.4 Create target dimension
# ________________________________________________________________________

If(DimensionExists( pTgtDim ) = 0 );
    DimensionCreate( pTgtDim );
Else;
    DimensionDeleteAllElements( pTgtDim );
EndIf;

### Set the target Sort Order ###
sSortElementsType     = CELLGETS( '}DimensionProperties', pSrcDim, 'SORTELEMENTSTYPE');
sSortElementsSense    = CELLGETS( '}DimensionProperties', pSrcDim, 'SORTELEMENTSSENSE');
sSortComponentsType   = CELLGETS( '}DimensionProperties', pSrcDim, 'SORTCOMPONENTSTYPE');
sSortComponentsSense  = CELLGETS( '}DimensionProperties', pSrcDim, 'SORTCOMPONENTSSENSE');

DimensionSortOrder( pTgtDim, sSortComponentsType, sSortComponentsSense, sSortElementsType , sSortElementsSense);


nSourceDimSize = DIMSIZ( pSrcDim );
nIndex = 1;
WHILE( nIndex <= nSourceDimSize );
  sElName = DIMNM( pSrcDim, nIndex);
  sElType = DTYPE( pSrcDim, sElName);
  
    DimensionElementInsert( pTgtDim, '', sElName, sElType );

  nIndex = nIndex + 1;
END;



# 1.5 Assign Data Source 
# ________________________________________________________________________

DatasourceNameForServer   = pSrcDim;
DatasourceNameForClient   = pSrcDim;
DataSourceType            = 'SUBSET';
DatasourceDimensionSubset = 'ALL';



# 1.6 Replicate Attributes
# ________________________________________________________________________

# Note: DType on Attr dim returns "AS", "AN" or "AA" need to strip off leading "A"
sAttrDim        = '}ElementAttributes_' | pSrcDim;
sAttrLoc        = '}LocalizedElementAttributes_' | pSrcDim;
sAttrTargetDim  = '}ElementAttributes_' | pTgtDim;
sAttrLocTarget  = '}LocalizedElementAttributes_' | pTgtDim;

If( pAttr = 1 & DimensionExists( sAttrDim ) = 1 );
  nNumAttrs = DimSiz( sAttrDim );
  nCount = 1;
  While( nCount <= nNumAttrs );
    sAttrName = DimNm( sAttrDim, nCount );
    sAttrType = SubSt(DType( sAttrDim, sAttrName ), 2, 1 );
      
      If ( DimensionExists( sAttrTargetDim ) = 0);
         AttrInsert(pTgtDim,'',sAttrName,sAttrType );
       ElseIF(DimIx(sAttrTargetDim, sAttrName) = 0);
         AttrInsert(pTgtDim,'',sAttrName,sAttrType );
      Endif;
        
    nCount = nCount + 1;
  End;
EndIf;


# ________________________________________________________________________
# 1.9 End Prolog
# ________________________________________________________________________




573,42

#****Begin: Generated Statements***
#****End: Generated Statements****




# ________________________________________________________________________
# 2.0 Start Metadata
# ________________________________________________________________________

### Check for errors in prolog ###

If( nErrors <> 0 );
  If( pStrictErrorHandling = 1 ); 
      ProcessQuit; 
  Else;
      ProcessBreak;
  EndIf;
EndIf;

### Add Elements to target dimension ###

sElType = DType( pSrcDim, vEle );
IF( sElType @= 'C' & ElCompN( pSrcDim, vEle ) > 0 );
    nChildren = ElCompN( pSrcDim, vEle );
    nCount = 1;
    While( nCount <= nChildren );
      sChildElement = ElComp( pSrcDim, vEle, nCount );
      sChildWeight = ElWeight( pSrcDim, vEle, sChildElement );
      DimensionElementComponentAdd( pTgtDim, vEle, sChildElement, sChildWeight );
      nCount = nCount + 1;
    End;
EndIf;


# ________________________________________________________________________
# 2.9 End Metadata
# ________________________________________________________________________



574,98

#****Begin: Generated Statements***
#****End: Generated Statements****


# ________________________________________________________________________
# 3.0 Start Data
# ________________________________________________________________________

### Check for errors ###

If( nErrors <> 0 );
  If( pStrictErrorHandling = 1 ); 
      ProcessQuit; 
  Else;
      ProcessBreak;
  EndIf;
EndIf;

### Replicate Attributes ###
# Note: DTYPE on Attr dim returns "AS", "AN" or "AA" need to strip off leading "A"

If( pAttr = 1 & DimensionExists( sAttrDim ) = 1 );

    nAttr = 1;
    While( nAttr <= nNumAttrs );
        sAttrName = DimNm( sAttrDim, nAttr );
        sAttrType = SubSt( DTYPE( sAttrDim, sAttrName ), 2, 1 );
        If( CellIsUpdateable( sAttrTargetDim, vEle, sAttrName ) = 1 );
            If( sAttrType @= 'S' % sAttrType @= 'A' );
                sAttrVal = AttrS( pSrcDim, vEle, sAttrName );
                If( sAttrVal @<> '' );
                    If( sAttrType @= 'A' );
                        AttrPutS( sAttrVal, pTgtDim, vEle, sAttrName, 1 );
                    Else;
                        AttrPutS( sAttrVal, pTgtDim, vEle, sAttrName );
                    EndIf;
                EndIf;
            Else;
                nAttrVal = AttrN( pSrcDim, vEle, sAttrName );
                If( nAttrVal <> 0 );
                    AttrPutN( nAttrVal, pTgtDim, vEle, sAttrName );
                EndIf;
            EndIf;
        EndIf;
        # check for localized attributes
        If( CubeExists( sAttrLoc ) = 1 );
            nLang = 1;
            While( nLang <= nNumLang );
                sLang       = DimNm( cLangDim, nLang );
                If( sAttrType @= 'A' % sAttrType @= 'S' );
                    sAttrVal    = AttrS( pSrcDim, vEle, sAttrName );
                    sAttrValLoc = AttrSL( pSrcDim, vEle, sAttrName, sLang );
                    If( sAttrValLoc @= sAttrVal ); sAttrValLoc = ''; EndIf;
                Else;
                    nAttrVal    = AttrN( pSrcDim, vEle, sAttrName );
                    nAttrValLoc = AttrNL( pSrcDim, vEle, sAttrName, sLang );
                EndIf;
                If( CubeExists( sAttrLocTarget ) = 0 );
                    If( sAttrType @= 'A' );
                        AttrPutS( sAttrValLoc, pTgtDim, vEle, sAttrName, sLang, 1 );
                    ElseIf( sAttrType @= 'N' );
                        If( nAttrValLoc <> nAttrVal );
                            AttrPutN( nAttrValLoc, pTgtDim, vEle, sAttrName, sLang );
                        EndIf;
                    Else;
                        AttrPutS( sAttrValLoc, pTgtDim, vEle, sAttrName, sLang );
                    EndIf;
                ElseIf( CubeExists( sAttrLocTarget ) = 1 );
                    If( CellIsUpdateable( sAttrLocTarget, vEle, sLang, sAttrName ) = 1 );
                        If( sAttrType @= 'A' );
                            AttrPutS( sAttrValLoc, pTgtDim, vEle, sAttrName, sLang, 1 );
                        ElseIf( sAttrType @= 'N' );
                            If( nAttrValLoc <> nAttrVal );
                                AttrPutN( nAttrValLoc, pTgtDim, vEle, sAttrName, sLang );
                            EndIf;
                        Else;
                            AttrPutS( sAttrValLoc, pTgtDim, vEle, sAttrName, sLang );
                        EndIf;
                    EndIf;
                EndIf;
                nLang   = nLang + 1;
            End;
        EndIf;
        nAttr = nAttr + 1;
    End;

EndIf;

# ________________________________________________________________________
# 3.9 End Data
# ________________________________________________________________________






575,220

#****Begin: Generated Statements***
#****End: Generated Statements****



# ________________________________________________________________________
# 4.0 Start Epilog
# ________________________________________________________________________


### Set the target Sort Order ###
  CELLPUTS( sSortElementsType, '}DimensionProperties', pTgtDim, 'SORTELEMENTSTYPE');
  CELLPUTS( sSortElementsSense, '}DimensionProperties', pTgtDim, 'SORTELEMENTSSENSE');
  CELLPUTS( sSortComponentsType, '}DimensionProperties', pTgtDim, 'SORTCOMPONENTSTYPE');
  CELLPUTS( sSortComponentsSense, '}DimensionProperties', pTgtDim, 'SORTCOMPONENTSSENSE');

### Destroy Source Subset ###

  If( SubsetExists( pSrcDim, cSubset ) = 1 );
    SubsetDestroy( pSrcDim, cSubset );
  EndIf;

##Clone all the Hierarchies except default hierarchy & Leaves
If( pHier @= '*' );
    sDim = pSrcDim;
    sHierDim = '}Hierarchies_' | sDim;
    sTargetHierarchy = '';
    nMax = DimSiz( sHierDim );
    nCtr = 1;
    While( nCtr <= nMax );
        sEle = DimNm( sHierDim, nCtr );
        nElength = Long(sEle);
        nElestart  = 0;
        nElestart = SCAN(':', sEle) + 1;
        If(nElestart > 1);
          vSourceHierarchy = SUBST(sEle,nElestart,nElength);
         If ( vSourceHierarchy @<> 'Leaves');
            #  nRet = EXECUTEPROCESS('}bedrock.hier.clone',
            #    'pLogOutput', pLogOutput,
            #    'pStrictErrorHandling', pStrictErrorHandling,
            #    'pSrcDim', sDim,
            #    'pSrcHier', vSourceHierarchy,
            #    'pTgtDim', pTgtDim,
            #    'pTgtHier', vSourceHierarchy,
            #    'pAttr', pAttr,
            #    'pUnwind',pUnwind
            #    );
         Endif;
         sTargetHierarchy = sTargetHierarchy |':'|vSourceHierarchy;
        Endif;
        nCtr = nCtr + 1;
    End;
### Just one hierarchy specified in parameter
ElseIf( Scan( '*', pHier )=0 &  Scan( '?', pHier )=0 & Scan( pDelim, pHier )=0 & Trim( pHier ) @<> '' );
    sDim = pSrcDim;
    sHierDim = '}Hierarchies_' | sDim;
    sCurrHier = pHier;
    sCurrHierName = Subst( sCurrHier, Scan(':', sCurrHier)+1, Long(sCurrHier) );
    # Validate hierarchy name in sHierDim
    If( Dimix( sHierDim , sDim |':'| sCurrHier ) = 0 );
        sMessage = Expand('The "%sCurrHier%" hierarchy does NOT exist in the "%sDim%" dimension.');
        LogOutput( 'INFO' , Expand( cMsgInfoContent ) );
    ElseIf( sCurrHierName @= 'Leaves' );
        sMessage = 'Invalid  Hierarchy: ' | sCurrHier | ' will be skipped....';
        LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
    ElseIf( sCurrHierName @<> sDim );
      If( pLogOutput = 1 );
        sMessage = Expand( 'Hierarchy "%sCurrHierName%" in Dimension "%sDim%" being processed....' );
        LogOutput( 'INFO', Expand( cMsgInfoContent ) );
      EndIf;
    #   nRet = EXECUTEPROCESS('}bedrock.hier.clone',
    #    'pLogOutput', pLogOutput,
    #    'pStrictErrorHandling', pStrictErrorHandling,
    #    'pSrcDim', sDim,
    #    'pSrcHier', sCurrHierName,
    #    'pTgtDim', pTgtDim,
    #    'pTgtHier', sCurrHierName,
    #    'pAttr', pAttr,
    #    'pUnwind',pUnwind
    #   );
    Endif;
### Hierachy is a delimited list with no wildcards
ElseIf( Scan( '*', pHier )=0 &  Scan( '?', pHier )=0 & Trim( pHier ) @<> '' );
  
      # Loop through hierarchies in pHier
    sDim = pSrcDim;
    sHierarchies              = pHier;
    nDelimiterIndexA    = 1;
    sHierDim            = '}Hierarchies_'| sDim ;
    sMdxHier = '';
    While( nDelimiterIndexA <> 0 );
  
        nDelimiterIndexA = Scan( pDelim, sHierarchies );
        If( nDelimiterIndexA = 0 );
            sHierarchy   = sHierarchies;
        Else;
            sHierarchy   = Trim( SubSt( sHierarchies, 1, nDelimiterIndexA - 1 ) );
            sHierarchies  = Trim( Subst( sHierarchies, nDelimiterIndexA + Long(pDelim), Long( sHierarchies ) ) );
        EndIf;
        sCurrHier = sHierarchy;
        sCurrHierName = Subst( sCurrHier, Scan(':', sCurrHier)+1, Long(sCurrHier) );
        # Validate hierarchy name in sHierDim
        If( Dimix( sHierDim , sDim |':'| sCurrHier ) = 0 );
            sMessage = Expand('The "%sCurrHier%" hierarchy does NOT exist in the "%sDim%" dimension.');
            LogOutput( 'INFO' , Expand( cMsgInfoContent ) );
        ElseIf( sCurrHierName @= 'Leaves' );
            sMessage = 'Invalid  Hierarchy: ' | sCurrHier | ' will be skipped....';
            LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
        ElseIf( sCurrHierName @<> sDim );
          If( pLogOutput = 1 );
            sMessage = Expand( 'Hierarchy "%sCurrHierName%" in Dimension "%sDim%" being processed....' );
            LogOutput( 'INFO', Expand( cMsgInfoContent ) );
          EndIf;
        #   nRet = EXECUTEPROCESS('}bedrock.hier.clone',
        #    'pLogOutput', pLogOutput,
        #    'pStrictErrorHandling', pStrictErrorHandling,
        #    'pSrcDim', sDim,
        #    'pSrcHier', sCurrHierName,
        #    'pTgtDim', pTgtDim,
        #    'pTgtHier', sCurrHierName,
        #    'pAttr', pAttr,
        #    'pUnwind',pUnwind
        #   );
        Endif;
    End;

### Hierachy has wildcards inside
ElseIf( Trim( pHier ) @<> '' );
  
      # Loop through hierarchies in pHier
    sDim = pSrcDim;
    sHierarchies              = pHier;
    nDelimiterIndexA    = 1;
    sHierDim            = '}Hierarchies_'| sDim ;
    sMdxHier = '';
    While( nDelimiterIndexA <> 0 );
  
        nDelimiterIndexA = Scan( pDelim, sHierarchies );
        If( nDelimiterIndexA = 0 );
            sHierarchy   = sHierarchies;
        Else;
            sHierarchy   = Trim( SubSt( sHierarchies, 1, nDelimiterIndexA - 1 ) );
            sHierarchies  = Trim( Subst( sHierarchies, nDelimiterIndexA + Long(pDelim), Long( sHierarchies ) ) );
        EndIf;
  
        # Create subset of Hierarchies using Wildcard
        sHierExp = '"'| sDim | ':' | sHierarchy|'"';
        sMdxHierPart = '{TM1FILTERBYPATTERN( {TM1SUBSETALL([ ' |sHierDim| '])},'| sHierExp | ')}';
        IF( sMdxHier @= ''); 
          sMdxHier = sMdxHierPart; 
        ELSE;
          sMdxHier = sMdxHier | ' + ' | sMdxHierPart;
        ENDIF;
    End;
  
    If( SubsetExists( sHierDim, cSubset ) = 1 );
        # If a delimited list of attr names includes wildcards then we may have to re-use the subset multiple times
        SubsetMDXSet( sHierDim, cSubset, sMdxHier );
    Else;
        # temp subset, therefore no need to destroy in epilog
        SubsetCreatebyMDX( cSubset, sMdxHier, sHierDim, 1 );
    EndIf;
  
    # Loop through subset of hierarchies created based on wildcard
    nCountHier = SubsetGetSize( sHierDim, cSubset  );
    While( nCountHier >= 1 );
        sCurrHier = SubsetGetElementName( sHierDim, cSubset , nCountHier );
        sCurrHierName = Subst( sCurrHier, Scan(':', sCurrHier)+1, Long(sCurrHier) );
        # Validate hierarchy name in sHierDim
        If( Dimix( sHierDim , sCurrHier ) = 0 );
            sMessage = Expand('The "%sCurrHier%" hierarchy does NOT exist in the "%sDim%" dimension.');
            LogOutput( 'INFO' , Expand( cMsgInfoContent ) );
        ElseIf( sCurrHierName @= 'Leaves' );
            sMessage = 'Invalid  Hierarchy: ' | sCurrHier | ' will be skipped....';
            LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
        ElseIf( sCurrHierName @<> sDim );
          If( pLogOutput = 1 );
            sMessage = Expand( 'Hierarchy "%sCurrHierName%" in Dimension "%sDim%" being processed....' );
            LogOutput( 'INFO', Expand( cMsgInfoContent ) );
          EndIf;
        #   nRet = EXECUTEPROCESS('}bedrock.hier.clone',
        #    'pLogOutput', pLogOutput,
        #    'pStrictErrorHandling', pStrictErrorHandling,
        #    'pSrcDim', sDim,
        #    'pSrcHier', sCurrHierName,
        #    'pTgtDim', pTgtDim,
        #    'pTgtHier', sCurrHierName,
        #    'pAttr', pAttr,
        #    'pUnwind',pUnwind
        #   );
        Endif;
      
        nCountHier = nCountHier - 1;
    End;
Endif;


### Return code & final error message handling
If( nErrors > 0 );
    sMessage = 'the process incurred at least 1 error. Please see above lines in this file for more details.';
    nProcessReturnCode = 0;
    LogOutput( cMsgErrorLevel, Expand( cMsgErrorContent ) );
    sProcessReturnCode = Expand( '%sProcessReturnCode% Process:%cThisProcName% completed with errors. Check tm1server.log for details.' );
    If( pStrictErrorHandling = 1 ); 
        ProcessQuit; 
    EndIf;
Else;
    sProcessAction = Expand( 'Process:%cThisProcName% has cloned the %pSrcDim% dimension into %pTgtDim%.' );
    sProcessReturnCode = Expand( '%sProcessReturnCode% %sProcessAction%' );
    nProcessReturnCode = 1;
    If( pLogoutput = 1 );
        LogOutput('INFO', Expand( sProcessAction ) );   
    EndIf;
EndIf;

# ________________________________________________________________________
# 4.9 End Epilog
# ________________________________________________________________________

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
