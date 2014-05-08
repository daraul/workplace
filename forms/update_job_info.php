<?php
    require_once "require/db_connection.php";
    $update_con = new mysqli($db_host, $user_employee, $user_employee_pw, "workplace");
    $employees = mysqli_query($update_con, "SELECT * FROM employees");
    //Clients
    $clients = mysqli_query($update_con, "SELECT * FROM Clients");
    //Jobs
    $update_select_job_names = mysqli_query($update_con, "SELECT * FROM worktodo WHERE JobID = " . $job_id);
    //Check for submission
    if(isset($_POST["submit"])){
        //Check that the submission isn't somehow empty
        /*if(empty($_POST['jobname']) || empty($_POST['jobdesc']) || empty($_POST['startdate']) || empty($_POST['duedate']) || empty($_POST['startdate']) || empty($_POST['client']) || empty($_POST['status'])){
            $job_name = "This is required";
            $job_desc = "This is required";
            $job_start = "This is required";
            $job_due = "This is required";
            $job_lead = "This is required";
            $job_client = "This is required";
            $job_status = "This is required";
        }*/
        //Submission successful, update variables to submitted data
        $job_name = $_POST['jobname'];
        $job_desc = $_POST['jobdesc'];
        $job_start = $_POST['startdate'];
        $job_due = $_POST['duedate'];
        $job_lead = $_POST['startdate'];
        $job_client = $_POST['client'];
        $job_status = $_POST['status'];
    } else {
        while ($row = mysqli_fetch_array($update_select_job_names)){
            $job_name = $row['JobTitle'];
            $job_desc = $row['Description'];
            $job_start = $row['StartDate'];
            $job_due = $row['DueDate'];
            $job_lead = $row['employeeID'];
            $job_client = $row['ClientID'];
            $job_status = $row['currentStatus'];
        }
    }
?>
<form class="add_info" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); echo "?key=" . $job_id;?>" method="post">
    <label>Job Name: 
        <input type="text" id="jobname" name="jobname" class="text_input" value="<?php echo $job_name; ?>" />
    </label>
    <label>Job Description: 
        <textarea rows="4" id="jobdesc" columns="50" name="jobdesc" /><?php echo $job_desc; ?></textarea>
    </label>
    <label>Lead: 
        <select id="employee" name="employee">
            <option disabled style="display: none;"></option>
            <?php
                while($row = mysqli_fetch_array($employees)){
                    echo "<option value=" . $row["employeeID"] . ">" . $row["fName"] . " " . $row["lName"] . "</option>";
                }
            ?>
        </select>
    </label>
    <label>Client: 
        <select id="client" name="client">
        <option selected disabled style="display: none;"></option>
            <?php
                while($client_row = mysqli_fetch_array($clients)){
        	        echo "<option value=\"" . $client_row["ClientID"] . "\">" . $client_row["Name"] . "</option>";
                }
            ?>
        </select>
    </label>
    <label>Start Date: 
        <input type="text" id="startdate" value="<?php echo $job_start[0]; ?>" name="startdate" class="datepicker" />
    </label>
    <label>Due Date: 
        <input type="text" id="duedate" class="datepicker" value="<?php echo $job_due[0]; ?>" name="duedate" />
    </label>
    <label>Status: 
        <select id="status" name="status">
            <?php require "includes/statuses.php" ?>
        </select>
    </label>
    <input type="submit" id="submit" name="submit" value="Update job" />
</form>
<link rel="stylesheet" href="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/themes/smoothness/jquery-ui.css" />
<link rel="stylesheet" href="css/forms.css" />
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js" type="text/javascript"></script>
<script src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
<script>
    $("select#employee option[value='<?php echo $job_lead ?>']").attr("selected", "");
    $("select#client option[value='<?php echo $job_client ?>']").attr("selected", "");
    $("select#status option[value='<?php echo $job_status ?>']").attr("selected", "");
</script>
