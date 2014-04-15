<link id="add_job_css" class="form_css" rel="stylesheet" href="css/forms.css" />
<?php require_once "require/db_connection.php"; ?>
<?php  
    $con = new mysqli($db_host, $user_employee, $user_employee_pw, "workplace");
    $employees = mysqli_query($con, "SELECT * FROM employees");
    $jobs = mysqli_query($con, "SELECT * FROM worktodo");
    $jobs_ordered = mysqli_query($con, "SELECT * FROM worktodo ORDER BY JobTitle");
    $job_lead = [];
    while($rows = mysqli_fetch_array($jobs)){
        array_push($job_lead, $rows["employeeID"]);
    }
    echo "<h1>" . $job_lead[0] . "</h1>";
?>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js" type="text/javascript"></script>
<form class="add_info" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]);?>" method="post">
    <label for="job">Job Name: 
        <select id="job" name="chosenjob" required>
        <option disabled style="display: none;"></option>
            <?php
                while($jobrow = mysqli_fetch_array($jobs_ordered)){
                    echo "<option value=\"" . $jobrow["JobID"] . "\">" . $jobrow["JobTitle"] . "</option>";
                }
            ?>
        </select>
    </label>
    <label for="employee">Select an employee: 
        <select id="employee" name="employee" required>
        <option disabled style="display: none;"></option>
            <?php
                while ($row = mysqli_fetch_array($employees)){
                    echo "<option value=\"" . $row["employeeID"] . "\">" . $row["fName"] . " " . $row["lName"] . "</option>";
                }
            ?>
        </select>
    </label>
    <label for="timein">Time in: 
        <input type="datetime-local" id="timein" name="timein" required />
    </label>
    <label for="timeout">Time out: 
        <input type="datetime-local" id="timeout" name="timeout" required />
    </label>
    <label for="summary">Summary: 
        <textarea rows="4" columns="50" id="summary" name="summary" value="" required /></textarea>
    </label>
    <!--<label>Status: 
        <select name="status" id="status">
        <php require "includes/statuses.php" ?>
    </label>-->
    <input type="submit" name="submit" value="Add job" />
</form>
<script>
    $("select#employee option[value='<?php echo $job_lead[0] ?>'").attr("selected", "");
</script>
<?php
    $time_out = date_create($_POST["timeout"]);
    $time_in = date_create($_POST["timein"]);
    $the_employee = $_POST["employee"];
    $the_summary = $_POST["summary"];
    $job_id = $_POST["chosenjob"];
    
    if(isset($_POST['submit'])){
        $insert = "INSERT INTO Time_Entries (JobID, EmployeeID, TimeIn, TimeOut, Summary)
        VALUES 
        ('" . $job_id . "', '" . $the_employee . "', '" . date_format($time_in, 'Y-m-d H:i:s') . "', '" . date_format($time_out, 'Y-m-d H:i:s') . "', '" . $the_summary . "')";
        if (!mysqli_query($con, $insert))
        {
        die('Error: ' . mysqli_error($con));
        } else {
            echo "<p>Time entry information below:</p>
                <p>Job ID: " . $job_id . "</p>
                <p>Time in: " . date_format($time_in, 'Y-m-d H:i:s') . "</p>
                <p>Time out: " . date_format($time_out, 'Y-m-d H:i:s') . "</p>
                <p>Employee number: " . $the_employee . "</p>
                <p>Summary: " . $the_summary . "</p>";
        }
    };
?>
