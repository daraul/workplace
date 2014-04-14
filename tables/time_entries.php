<?php
    $job_id = $_GET["key"];
    $timentry_con = new mysqli("localhost","employee","1234","workplace");
    //Time entries
    $entries = mysqli_query($timentry_con, "SELECT * FROM Time_Entries WHERE JobID=" . $job_id);
?>

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