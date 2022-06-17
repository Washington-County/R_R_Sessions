/*Connect to the data mart*/
/*
LIBNAME OPERA ODBC dsn = 'SAS_ORPHEUS' schema = OPERA cursor_type = forward_only;

/******************************************************************************************************/
/*Template is to be used in SAS 9.4*/

/*Set relative directory*/
/*get program path*/
%let path_programname=%sysget(SAS_EXECFILEPATH);
/*get program name*/
%let programname=%sysget(SAS_EXECFILENAME);
*Name of other folders in project;
%let datafolder = data;
%let outputsfolder = output;
%let scriptsfolder = scripts;

/*set full path*/
%LET path_root = %SUBSTR(&path_programname,1,%eval(%length(&path_programname)-%length(&programname)-8));
%put &path_root;

*Name of other folders in project;
%let datafolder = data;
%let outputsfolder = output;
%let scriptsfolder = scripts;

*create full paths to other folders;
%let path_data = &path_root.&datafolder\; 
%let path_script = &path_root.&scriptsfolder\;
%let path_output = &path_root.&outputsfolder\;

*full paths for all;
%put Data Path: &path_data;
%put Scripts Folder: &path_script;
%put Outputs Folder: &path_output;

/******************************************************************************************************/
