<?php
    require_once "require/db_connection.php";
    $update_con = new mysqli($db_host, $user_employee, $user_employee_pw, "workplace");
    $employees = mysqli_query($update_con, "SELECT * FROM employees");
    //Clients
    $clients = mysqli_query($update_con, "SELECT * FROM Clients");
    //Jobs
    $update_select_job_names = mysqli_query($update_con, "SELECT * FROM worktodo WHERE JobID = " . $job_id);
    $job_name = [];
    $job_desc = [];
    $job_lead = [];
    $job_client = [];
    $job_start = [];
    $job_due = [];
    $job_status = [];
    while ($row = mysqli_fetch_array($update_select_job_names)){
        array_push($job_name, $row['JobTitle']);
        array_push($job_desc, $row['Description']);
        array_push($job_start, $row['StartDate']);
        array_push($job_due, $row['DueDate']);
        array_push($job_lead, $row['employeeID']);
        array_push($job_client, $row['ClientID']);
        array_push($job_status, $row['currentStatus']);
    }
?>
<form class="add_info" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); echo "?key=" . $job_id;?>" method="post">
    <label>Job Name: 
        <input type="text" id="jobname" name="jobname" class="text_input" value="<?php echo $job_name[0]; ?>" required />
    </label>
    <label>Job Description: 
        <textarea rows="4" id="jobdesc" columns="50" name="jobdesc" required /><?php echo $job_desc[0]; ?></textarea>
    </label>
    <label>Lead: 
        <select id="employee" name="employee" required>
            <option disabled style="display: none;"></option>
            <?php
                while($row = mysqli_fetch_array($employees)){
                    echo "<option value=" . $row["employeeID"] . ">" . $row["fName"] . " " . $row["lName"] . "</option>";
                }
            ?>
        </select>
    </label>
    <label>Client: 
        <select id="client" name="client" required>
        <option selected disabled style="display: none;"></option>
            <?php
                while($client_row = mysqli_fetch_array($clients)){
        	        echo "<option value=\"" . $client_row["ClientID"] . "\">" . $client_row["Name"] . "</option>";
                }
            ?>
        </select>
    </label>
    <label>Start Date: 
        <input type="text" id="startdate" value="<?php echo $job_start[0]; ?>" name="startdate" class="datepicker" required />
    </label>
    <label>Due Date: 
        <input type="text" id="duedate" class="datepicker" value="<?php echo $job_due[0]; ?>" name="duedate"required />
    </label>
    <label>Status: 
        <select id="status" value="Complete" name="status" required>
            <?php require "includes/statuses.php" ?>
        </select>
    </label>
    <input type="submit" id="submit" name="submit" value="Add job" />
</form>
<link rel="stylesheet" href="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/themes/smoothness/jquery-ui.css" />
<link rel="stylesheet" href="css/forms.css" />
<!--<script src="//code.jquery.com/jquery-1.9.1.js"></script>-->
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js" type="text/javascript"></script>
<script src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
<script>
    $("select#employee option[value='<?php echo $job_lead[0] ?>']").attr("selected", "");
    $("select#client option[value='<?php echo $job_client[0] ?>']").attr("selected", "");
    $("select#status option[value='<?php echo $job_status[0] ?>']").attr("selected", "");
</script>
