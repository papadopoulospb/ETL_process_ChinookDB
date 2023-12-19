# SQL scripts demonstrating Extract Load Transform (ETL) process in a database
Each sql script demonstrates a different stage of this process. ETL process is essential to extract data from OLTP database to Data Warehouse in order to provide essential information and data to business analysts for making decisions.
OLTP databases are fast enough to insert data but their structure is not appropriate to for business analysts to extract the data. For this purpose ETL is crusial step to bridge the gap between the OLTP and Data Warehouse.
##  Executing the scripts
It is recommended to use **Microsoft SQL Server Management Studio** to execute the scripts.
The scripts , is recommended , to be executed with the following order. Otherwise ETL process fails.
- ChinookStaging
- 1.CreateTables_ChinookDW
- 2.CreateDimDate_ChinookDW
- 3.Load_ChinookDW
- Make_relationships_StarSchema_ChinookDW
- Make_chnages_in_Chinook
- 4.Remove_relationships_ChinookDW
- 5.SCD_Type2_ChinookDW
- Make_relationships_StarSchema_ChinookDW

The data warehouse is implemented so that the relationship between the dimension tables and the fact table will be __star__.

> [!NOTE]
> 1. Before executing the **SCD_Type2_Chinook.sql**, which is the script that making changes in data warehouse,
> it is necessary to remove the relationships between the dimension tables and the fact table, even for future changes.
> 2. It is crusial when executing the scripts to set the appropriate *start_date* and *end_date* variable inside
> the **2.CreateDimDate_ChinookDW.sql** and *etl_date* in the **SCD_Type2_Chinook.sql** scripts.


> [!IMPORTANT]
> These scripts should be customized to the user's goals and database tables.

> [!TIP]
> Instead of executing the scripts one-by-one manually you can execute the script **script_automation.sql** that executes the above
> all together to see the final results more quickly.

## Installation of scripts
In **Git Bash** (for Windows) or in **Bash** for (Linux/Mac) use the following command to install the sql scripts:
```Git Bash
git clone https://github.com/papadopoulospb/ETL_process_ChinookDB
```
