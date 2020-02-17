#Import the CSV to a variable
$data = Import-CSV -Delimiter ";" '.\mydata.csv'

#Clear the table
$table = $null

#Create the new DataTable
$table = New-Object System.Data.DataTable

#define the data type for each column in your database
$table.Columns.Add("column1","int") | Out-Null
$table.Columns.Add("column2","int") | Out-Null
$table.Columns.Add("column3","float") | Out-Null
#$table.Columns.Add("columnX","type") | Out-Null

#Now map each item in each row from the csv to the table
foreach ($item in $data) {
    #define a new row object
    $row = $table.NewRow()
 
    #set the properties of each row from the data
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
