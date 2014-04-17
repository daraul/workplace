<?php 
    require_once "require/db_connection.php";
    $clients_con = new mysqli($db_host, $user_employee, $user_employee_pw,"workplace");
    if(mysqli_connect_errno()){
        echo "Failed to connect to database. " . mysqli_connect_error();
    }
    $clients = mysqli_query($clients_con, "SELECT * FROM Clients");
?>

<link rel="stylesheet" type="text/css" id="time_entries_css" class="table_css" href="css/tables.css" />

<table class="info_table" border="1">
<tr>
    <th>Client ID</th>
    <th>Client Name</th>
    <th>Email</th>
</tr>
<?php
    while($row = mysqli_fetch_array($clients)){
        echo "<tr>";
        echo "<td>" . $row["ClientID"] . "</td>";
        echo "<td>" . $row["Name"] . "</td>";
        echo "<td><a href=\"mailto:" . $row["ContactInfo"] . "\" title=\"Email " . $row["Name"] . "\">" . $row["ContactInfo"] . "</td>";
        echo "</tr>";
    }
?>
</table>