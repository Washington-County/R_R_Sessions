/*______________________________________________________________________________________________________________
 Program: GenericSASExplicitPath																				|
 Location: GITHUB\Washington-County\Template_RAID\Scripts\														|
 Author: Stefani Aleman 																						|
 Created: 12/6/2021																								|
 Lastest Edit:  																								|
 Current Version: Version 1.1																					|
 Revisions: 																									|
 			Version 1.0 (12/06/2021): Initial script created code. 												|
																												|																				*
																												|
 Summary: Calls direct paths assigned to be used in other scripts. The original version of this script lives
			in the Template_RAID on github. Standardized changes made to the script that are intended to be
			used by all team members, must be updated in github. 
		The .gitignore file under the Template_RAID includes ignoring the GenericSASExplicitPath, so that 
		ultimately any changes made where a direct path is stated will not be uploaded into github.
		THIS MEANS THAT all changes to this .sas file will be LOCAL only and information on how to properly
		run your project must include information on how to access this particular script version under your
		project (e.g., "The explicit paths are living under this project in the local copy repo")
________________________________________________________________________________________________________________
How to run macro:	

	Step 0. Before reunning, ammend your copy of GenericSASExplicitPath.sas. to include names and location of 
			paths that are required for your analysis or script, but that do not live under any of the folders
			"..\Teamplate_RAID\". 
			Save your copy as "MyDirectPaths.sas" !!!
	Step 1. In your script containing your code for analysis/QA, Copy and paste line 23 to use and include 
			statement to call the  GenericSASExplicitPath.sas file. The GenericSASExplicitPath.sas must
			be living in your &path_scripts folder, other wise this will not work.

 			%include '&path_scripts.MyDirectPaths.sas';

	 Step 2. Finally, add the statement to run the direcpaths in your script contatining code by copying and 
			pasting line 27.
																												
 			%directpaths;																																												*
_________________________________________________________________________________________________________________*/

*****************************************START OF MACRO CODE*****************************************************;

%macro directpaths;

*EDIT LINES START;
	libname TestLibrary1 'K:\Enter\Path\Name\Here';
	libname TestLibrary2 'K:\Enter\Your\Second\Path\Name\Here';
	libname TestLibrary3 'K:\Enter\Your\Third\Path\Name\Here';
	libname TestLibrary4 'K:\Eneter\Your\Fourth\Path\Name\Here';
*EDIT LINES END;

%mend directpaths;

********************************************END CODE*************************************************************
;
