#Import the CSV to a variable 
#Note:- my CSV had a ";" as a delimiter. Yours may be different.
$data = Import-CSV -Delimiter ";" '.\mydata.csv' 

#Clear the table
$table = $null

#Create a new DataTable
$table = New-Object System.Data.DataTable

#define the column name and data type below as the same as in your database table
#$table.Columns.Add("table_column_name","date_type") | Out-Null
$table.Columns.Add("column1","int") | Out-Null
$table.Columns.Add("column2","int") | Out-Null
$table.Columns.Add("column3","float") | Out-Null


#Now map each item in each row from the csv to the table
foreach ($item in $data) {
    #define a new row object
    $row = $table.NewRow()

    #replace $item.column1...$item.columnX with your CSV column headers.
    $row.column1 = $item.column1
    $row.column2 = $item.column2
    $row.column3 = $item.column3
#   $row.columnX = $item.columnX
    $table.Rows.Add($row)
    }

Write-SqlTableData  -ServerInstance "mysqlserver\myinstance" `
                    -DatabaseName "mydatabase" `
                    -SchemaName "dbo" `
                    -TableName "mytable" `
                    -InputData $table -PassThru
