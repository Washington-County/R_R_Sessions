/*Connect to the data mart*/
/*
LIBNAME OPERA ODBC dsn = 'SAS_ORPHEUS' schema = OPERA cursor_type = forward_only;

/******************************************************************************************************/
/*Template is to be used in SAS 9.4*/

/*Template is to be used in SAS Enterpise Guide*/
/*program name, e.g. example1.sas*/
%LET programname =%UPCASE(&_CLIENTTASKLABEL);

/*full path and program name, e.g. c:\project\programs\example1.sas*/
%LET path_programname = %UPCASE(&_SASPROGRAMFILE);

/*since script is starting in script path*/
%LET path_root = %SUBSTR(&path_programname,2,%eval(%length(&path_programname)-%length(&programname)-8));
%put &path_root;

/*identify other folder and libname for use*/
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
/*Specify name of data*/
