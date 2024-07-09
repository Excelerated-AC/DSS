601,100
602,"sys_Client Preferences Management"
562,"NULL"
586,
585,
564,
565,"vZHx@[=a<@HHf:TgEQOUZqasV6zm2mmMaA27eoCl@bej=3nbC9?@FtJkqpRkv9h6w1@O\lNpHiXsAMFsTalbQT32c_95CPogUPVUnF>Et>uXKP\WX7MPTID\==IhyNRV8yeBX2VYz0F?trXZUaQdYw8D4W]80=ZBrvt_9CTVWRvf`x4tqCeLV33YePQJd7bXG<rV5ANh"
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
560,0
561,0
590,0
637,0
577,0
578,0
579,0
580,0
581,0
582,0
603,0
572,121

#****Begin: Generated Statements***
#****End: Generated Statements****


#******************************************************************************************************************************************************************
#**** PROCESS:		sys_Client Preferences Management
#****
#**** DESCRIPTION:	This process sets default prefereces for each client
#****			
#**** AUTHOR:		Excelerated Consulting
#****
#**** MODIFICATION HISTORY:
#****
#**** Date	Initials	Comments
#**** ====	======	==========
#**** 02/10/2018	RJR	
#******************************************************************************************************************************************************************

#-----------------------------------------------------------------------------------------
#    CUBES
#-----------------------------------------------------------------------------------------
cbPreferences = 'sys_Client Preferences';
cbClientSettings = '}ClientSettings';
cbClientProperties = '}ClientProperties';
cbVar = 'sys_Variable';
cbScMgr = 'sys_Scenario Manager';

#-----------------------------------------------------------------------------------------
#    DIMENSIONS
#-----------------------------------------------------------------------------------------
dmClient = '}Clients';
dmMeasure = 'sys_Client Preferences Measure';
sUser = TM1User;

#-----------------------------------------------------------------------------------------
#    OTHER PARAMETERS
#-----------------------------------------------------------------------------------------
sDefaultClient = 'Default Client';

#-----------------------------------------------------------------------------------------
#    UPDATE CLIENT PREFERENCES
#-----------------------------------------------------------------------------------------
nCounter1 = 1;
nDimSize1 = DIMSIZ(dmClient);

WHILE(nCounter1 <= nDimSize1);

      sClient = DIMNM(dmClient, nCounter1);
      nCounter2 = 1;
      nDimSize2 = DIMSIZ(dmMeasure);
      
      WHILE(nCounter2 <= nDimSize2);
            sMeasure = DIMNM(dmMeasure, nCounter2);

            IF(DTYPE(dmMeasure, sMeasure) @= 'S');      
                  sValue = CELLGETS(cbPreferences, sClient, sMeasure);
                  sDefaultValue = CELLGETS(cbPreferences, sDefaultClient, sMeasure);
                  IF(sValue @= '');
                        IF(CELLISUPDATEABLE(cbPreferences, sClient, sMeasure) = 1);
                              CELLPUTS(sDefaultValue, cbPreferences, sClient, sMeasure);
                        ENDIF;
                  ENDIF;

            ENDIF;
            nCounter2 = nCounter2 + 1;

      END;

      nCounter1 = nCounter1 + 1;

END;

#-----------------------------------------------------------------------------------------
#    UPDATE CLIENT SETTINGS
#-----------------------------------------------------------------------------------------
nCounter = 1;
nDimSize = DIMSIZ(dmClient);

WHILE(nCounter <= nDimSize);
      sEl = DIMNM(dmClient, nCounter);


      # Web Hide NavTree
      CELLPUTS('false', cbClientSettings, sEl, 'Web Hide NavTree');

      # Web Hide TabBar
      CELLPUTS('true', cbClientSettings, sEl, 'Web Hide TabBar');

      # Home Page Object Type
      CELLPUTS('Websheet', cbClientSettings, sEl, 'Web Home Page Object Type');

      # Web Hide Websheet ToolBar
      CELLPUTS('false', cbClientSettings, sEl, 'Web Hide Websheet ToolBar');

      # Unique ID
      IF(CELLGETS(cbClientProperties, sEl, 'UniqueID') @= '');
            CELLPUTS(sEl | '@CENTRAL', cbClientProperties, sEl, 'UniqueID');
      ENDIF;

      IF(DIMIX(dmClient, sUser)  = 0);

            # Budget Year
            sValue = CELLGETS(cbVar, 'Current Budget Year', 'sValue');
            CELLPUTS(sValue, cbPreferences, sEl, 'Budget Year');

            # Reporting Year
            sValue = CELLGETS(cbVar, 'Current Year', 'sValue');
            CELLPUTS(sValue, cbPreferences, sEl, 'Reporting Year');

            # Reporting Month
            sValue = CELLGETS(cbVar, 'Current Month', 'sValue');
            CELLPUTS(sValue, cbPreferences, sEl, 'Reporting Month');

      ENDIF;

      nCounter = nCounter + 1;

END;


573,3

#****Begin: Generated Statements***
#****End: Generated Statements****
574,3

#****Begin: Generated Statements***
#****End: Generated Statements****
575,8

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
