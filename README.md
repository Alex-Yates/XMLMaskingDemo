# XMLMaskingDemo
Challenge: How to mask XML data using a sync manager. The XML data contains some data that needs to masked consistently with other tables, and some unique data which also needs to be masked.

## How to run this demo

This demo assumes you have a SQL Server installed locally and that you can connect to the default instance using WindowsAuth/Integrated Security. You will need at least dbo access because you'll be creating, deleting and modifying databases.

1. Run CreateDatabase.sql to create a sample database.
1. Open the masking set DataMaskerMaskingSet.DMMaskSet using Redgate Data Masker. (More info here: https://www.red-gate.com/products/data-masker/)

The sample database contains two tables (EMPLOYEE and EXPENSES). The tables each contain 3 rows of data. We have 3 employees, and 3 expenses. The expenses are stored in an XML column.

The XML data for the expenses contains the name of the employee who made the expense claim. Hence, we have a loose, unenforced reference between the two tables. 2 of the expenses were made by employees in the EMPLOYEE table. However, one of the expenses was made by someone who does not exist in the EMPLOYEE table. Perhaps they used to work for us but have since left? Or perhaps there was an error inputting the data?

Our objective is to ensure all the names (first and last) are masked in either table. We also want to maintain the existing relationships between expenses and employees.

## How the masking set works

1. First, we have a rule (05-0004) to copy the sensitive data from the XML block into a separate table. (We need to do this so that we can pull the data into a Sync Manager).
1. Once we've copied the data, we convert the XML column to nvarchar(MAX). (This allows us later to use Table to Text rules within Sync Managers to mask the data.)
1. Next we use Sync Managers (15-0009 and 16-0010) to mask the first and last names in both the EMPLOYEE and EXPENSES tables. These work by creating temp mapping tables using the name data from both the EMPLOYEE table and the temp table we created in rule 05-0004 (which holds all the sensitive data from the XML in the EXPENSES table). Random names are generated in the mapping table. Then we use the mapping table to overwite the original values in both the EMPOYEE table, and the temp table we created in rule 05-0004. Finally, the Sync Managers use and additional Table-To-Text rule to override the values in the original EXPENSES table.
1. Finally, in rule block 95, we have a couple of command rules to tidy up. We drop the table we created in rule 05-0004, and we convert the XML column data back from nvarchar(Max) datatype to XML.
