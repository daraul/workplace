<?php 
    $todo_con = new mysqli("localhost","employee","1234","workplace");
    if(mysqli_connect_errno()){
            echo "Failed to connect to database. " . mysqli_connect_error();
    }
    $worktodo = mysqli_query($todo_con,"SELECT * FROM worktodo WHERE currentStatus != 'Complete' ORDER BY Priority, currentStatus, JobTitle");
?>


<table border="1" class="info_table" id="dashboard_table">
    <tr>
        <th>Job Title</th>
        <th>Status</th>
        <th>Client</th>
        <th>Lead</th>
        <th>Start Date</th>
        <th>Due Date</th>
        <th>Description</th>
    </tr>
    <!--<tfoot>
        <tr>
            <td>Lots of work to do! I just wwanted to add a footer to this table. It doesn't really do anything.</td>
        </tr>
    </tfoot>-->
<?php while($row = mysqli_fetch_array($worktodo))
{
    echo "<tr>";
    echo "<td><a href=\"job_info.php?key=" . $row["JobID"] . "\" id=\"jobTitleLink\" title=\"Check the time entries for this job\">" . $row["JobTitle"] . "</a></td>";
    echo "<td class=\"middle_align\">" . $row["currentStatus"] . "</td>";
    echo "<td class=\"middle_align\">" . $row["ClientID"] . "</td>";
    echo "<td class=\"middle_align\">" . $row["employeeID"] . "</td>";
    echo "<td class=\"middle_align\">" . $row["StartDate"] . "</td>";
    echo "<td class=\"middle_align\">" . $row["DueDate"] . "</td>";
    echo "<td>" . $row["Description"] . "</a></td>";
    echo "</tr>";
}
?>
</table>

<?php mysqli_close($con);?>