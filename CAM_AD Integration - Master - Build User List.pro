601,100
602,"CAM_AD Integration - Master - Build User List"
562,"NULL"
586,
585,
564,
565,"s2GigkjG:m8N0KDFou[ae\HOU;:=B^BfVaQsp1\;G>WAPVOh?^N0jTfA^i6IISZLtx@?[BWbP_YnuFrKqeckB>uQnGykI1dtY6=Cq=7oZwRvyV`M9vmLCM>`D6Za1CYVC\<D1Z2r7t=0A3VH:UBaUYmJ`^Zg0BW2;f@3aB7AaPC98?z;6@`wN50OTnDpusI6L4T<Yxo5"
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
572,122

#****Begin: Generated Statements***
#****End: Generated Statements****


# Process Name: CAM_AD Integration - Master - Build User List
#_______________________________________________________________________________

# _______________________________________________________________________________
# 1.0 Start Prolog
# _______________________________________________________________________________

# _______________________________________________________________________________
# Purpose:          This process will obtain a list of all users within a given domain
#                   from the active directory and use this to populate the "AD users"
#                   dimension.
#
# Workflow:         Run from PAW, triggers sub processes as required
#
# Developer:        Excelerated | Andrew Craig | 24 Sep 2020
#
# Update Log:       AC | 05 Feb 2021 |  Changed name of AD Users Directory to reflect correct naming convention
#   	            AC | 05 Feb 2021 |  Add logic to clean up temporary files and folders
#                   AC | 11 Feb 2021 |  Add subset creation logic for picklist to source from 
#                   AC | 22 Feb 2021 |  Simplify and enhance robustness of process
#                   AC | 01 Mar 2021 |  Move PowerShell commands from sub to master process
#                   AC | 02 Mar 2021 |  Move deletion commands to sub-process to ensure only triggered when file is available
#                   AC | 03 Mar 2021 |  Optimise for performance
# _______________________________________________________________________________
 
# 1.1 Initialise
# _______________________________________________________________________________

cProcessName = GetProcessName();
cProcessTime = TIMST ( NOW , '\y\m\d\h\i\s');
cProcessReference = cProcessName | '_' | cProcessTime;

sFilePathPrefix  = 'zImport\';
sFilePath = sFilePathPrefix | cProcessReference | '.csv';

sADUsersDim = 'CAM_AD All AD Accounts';
sBuildUserProcess = 'CAM_AD Integration - Build User List - Simplified SubProcess';
sAssessmentSubProcess = 'CAM_AD Integration - File Availability Assessment';
sAD_UsersParent = 'All Users';
sADAll_SubsetName = 'All AD Users Picklist';
sCamNamespace = 'CAM_AD';



# 1.2 Create temporary folder
# _______________________________________________________________________________

sCreateFolderCommand = 'cmd /c "md ' | sFilePathPrefix | '"';
ExecuteCommand ( sCreateFolderCommand, 1);
Sleep( 500 );



# 1.3 Execute PowerShell commands to produce flat file 
# _______________________________________________________________________________

# Ensure powershell is activated with relevant AD commandlets
sPowerShellCommand = 'powershell -command "import-module ActiveDirectory"';
ExecuteCommand( sPowerShellCommand, 1);

# Export list of all users in the domain
sPowerShellCommand = Expand( 'powershell -command "Get-ADUser -Filter {Enabled -eq ''True''} | Select SamAccountName | Export-csv -Path ''%sFilePath%'' " ' ); 
ExecuteCommand( sPowerShellCommand, 1);



# 1.4 Ensure file has been produced and is not locked before proceeding 
# _______________________________________________________________________________

i = 1;
# Check for file 10 times
iMax = 10;
# Proceed in 2 second increments
nSleepIncrement = 2000;

While( i < iMax);

    # Do not proceed if file cannot be accessed correctly
    If( i = (iMax - 1) );
        LogOutput( 'Info', 'Loop exit FAILURE due to inaccessible file' | NumberToString( i ) );
        ProcessQuit;
    EndIf;

    LogOutput( 'Info', 'Wait commenced - i status was ' | NumberToString( i ) );

    # Initial wait - allow Powershell to generate ~67k CSV records from active directory
    Sleep( nSleepIncrement );

    # Run Sub-process and determine return code
    gReturnCode = ExecuteProcess( sAssessmentSubProcess, 'pFilePath', sFilePath );

    # If return code is ProcessExitOnInit() keep waiting ( 10x ) otherwise move forward
    If( gReturnCode = ProcessExitNormal() );
        i = iMax;
        LogOutput( 'Info', 'Loop exit SUCCESS due to accessible file' );
    EndIf;

    i = i + 1;

End;







# _______________________________________________________________________________
# 1.9 End Prolog
# _______________________________________________________________________________







573,3

#****Begin: Generated Statements***
#****End: Generated Statements****
574,3

#****Begin: Generated Statements***
#****End: Generated Statements****
575,50

#****Begin: Generated Statements***
#****End: Generated Statements****




# _______________________________________________________________________________
# 4.0 Start Epilog
# _______________________________________________________________________________


# 4.1 Run sub-process
# _______________________________________________________________________________

ExecuteProcess( sBuildUserProcess, 'pFilePath', sFilePath, 'pCamNamespace', sCamNamespace );



# 4.2 Clean up temporary folder and files
# _______________________________________________________________________________

# Remove files

sCleanUpCommand = 'cmd /c powershell -command "Get-ChildItem -Path ' | sFilePathPrefix | ' -Include *.* -Recurse | foreach { $_.Delete()}"';

ExecuteCommand( sCleanUpCommand, 1 );


# Remove folder

sRemoveFolderCommand = 'cmd /c "rd /s /q ' | sFilePathPrefix | '"';

ExecuteCommand( sRemoveFolderCommand, 1 );



# 4.3 Build Subset
# _______________________________________________________________________________
If( SubsetExists( sADUsersDim, sADAll_SubsetName ) = 0);
    SubsetCreate( sADUsersDim, sADAll_SubsetName );
EndIf;
SubsetIsAllSet( sADUsersDim, sADAll_SubsetName, 1 );



# _______________________________________________________________________________
# 4.9 End Epilog
# _______________________________________________________________________________

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
