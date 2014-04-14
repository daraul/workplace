<?php
    $job_id = $_GET["key"];
    require_once "require/db_connection.php";
    $timentry_con = new mysqli($db_host, $user_employee, $user_employee_pw,"workplace");
    //Time entries
    $entries = mysqli_query($timentry_con, "SELECT * FROM Time_Entries WHERE JobID=" . $job_id);
?>

<link rel="stylesheet" type="text/css" id="time_entries_css" class="table_css" href="css/tables.css" />

<table class="info_table" border="1">
    <tr>
        <th>EntryID</th>
        <th>JobID</th>
        <th>EmployeeID</th>
        <th>TimeIn</th>
        <th>TimeOut</th>
        <th>Summary</th>
    </tr>
    <?php
        while($timerow = mysqli_fetch_array($entries))
        {
            echo "<tr>";
            echo "<td>" . $timerow[EntryID] . "</td>";
            echo "<td>" . $timerow[JobID] . "</td>";
            echo "<td>" . $timerow[EmployeeID] . "</td>";
            echo "<td>" . $timerow[TimeIn] . "</td>";
            echo "<td>" . $timerow[TimeOut] . "</td>";
            echo "<td>" . $timerow[Summary] . "</td>";
            echo "</tr>";
        }
    ?>
<!--Close the table. Easy to forget that.-->
</table>
