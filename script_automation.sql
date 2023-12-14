/*
Set this script to SQLCMD_MODE
At the top taskbar Query->SQLCMD_MODE


This is a script file in SQLCMD_MODE to run a set of sql scripts for 
1.Creating the ChinookStaging database
2.Create the Chinook Dataware House
3.Load the ChinookDW
4.Make changes at the OLTP - Chinook DB
5.SCD type 2

! Be careful of the files' path to be aligned to your's !

*/


/*In line 19 set your own path in variable ScriptPath*/
:setvar ScriptPath "C:\Users\User\Documents\BI_DataEngineering\Project_Chinook\Chinook_ETL_process"


/* Lines 23 - 31 : From OLTP to DW , not changes to OLTP yet ! */
:r $(ScriptPath)\ChinookStaging.sql

:r $(ScriptPath)\1.CreateTables_ChinookDW.sql

:r $(ScriptPath)\2.CreateDimDate_ChinookDW.sql

:r $(ScriptPath)\3.Load_ChinookDW.sql

:r $(ScriptPath)\Make_relationships_StarSchema_ChinookDW.sql


:r $(ScriptPath)\Make_changes_in_Chinook.sql

:r $(ScriptPath)\4.Remove_relationships_ChinookDW.sql

:r $(ScriptPath)\5.SCD_Type2_ChinookDW.sql

:r $(ScriptPath)\Make_relationships_StarSchema_ChinookDW.sql
