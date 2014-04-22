<link id="add_job_css" class="form_css" rel="stylesheet" href="css/forms.css" />
<?php require_once "require/db_connection.php"; ?>
<?php //Form validation
        
    //define variables to set to empty including the error message variables:
    //$jobnameerr = $descerr = $employeeerr = $clienterr = $startdateerr = $duedateerr = "";
    $jobname = $desc = $employee = $client = $startdate = $duedate = "";
    //Make sure the request has been made and if so, test the fields.
    function test_input($data){
        $data = trim($data);
        $data = stripslashes($data);
        $data = htmlspecialchars($data);
        return $data;
    };
    
    if ($_SERVER["REQUEST_METHOD"] == "POST")
    {
        if(empty($_POST["jobname"])){
            $jobnameerr = "A job name is required.";
        } else {
            $jobname = test_input($_POST["jobname"]);
            // check if name only contains letters and whitespace
            if (!preg_match("[A-Za-z-0-9]+\s[A-Za-z-'0-9]+",$jobname))
            {
                $jobname = "Only letters & spaces allowed.";
            }
        }
        if(empty($_POST["desc"])){
            $descerr = "A description of the job is required.";
        } else {
            $desc = test_input($_POST["jobdesc"]);
            // check if name only contains letters and whitespace
            if (!preg_match("/^[a-zA-Z ]*$/",$jobdesc))
            {
                $jobdesc = "Only letters, spaces & numbers allowed for now."; 
            }
        }
        if(empty($_POST["employee"])){
            $employeeerr = "An employee must be assigned to the job.";
        } else {
            $employee = test_input($_POST["employee"]);
        }
        if(empty($_POST["client"])){
            $clienterr = "A client must be assigned to the job.";
        } else {
            $client = test_input($_POST["client"]);
        }
        if(empty($_POST["startdate"])){
            $startdateerr = "A start date must be set for the job.";
        } else {
        $startdate = test_input($_POST["startdate"]);
        }
        if(empty($_POST["duedate"])){
            $duedateerr = "A due date must be set for the job.";
        } else {
            $duedate = test_input($_POST["duedate"]);
        }
    };
?>
	
<?php //SQL connection
    //$con = new mysqli($db_host, $user_root, $user_root_pw, "workplace");
    $con_select = new mysqli($db_host, $user_employee, $user_employee_pw, "workplace");
    if(mysqli_connect_errno()){
        echo "Failed to connect to database. " . mysqli_connect_error();
    }
    $clients = mysqli_query($con_select, "SELECT * FROM Clients");
    $employees = mysqli_query($con_select, "SELECT * FROM employees");
?>

<?php //Submit or post error
    $jobtitle = $_POST["jobname"];
    $jobdescription =  $_POST["jobdesc"];
    $status = $_POST["status"];
    $employee = $_POST["employee"];
    $client = $_POST["client"];
    $start =  $_POST["startdate"];
    $due = $_POST["duedate"];
    
    if(isset($_POST['submit'])){
        /*$insert = "INSERT INTO Worktobedone (Status, employeeID, ClientID, StartDate, DueDate, JobTitle, Description)
        VALUES
        ('" . $status . "', '" . $employee . "', '" . $client . "', '" . $start . "', '" . $due . "', '" . $jobtitle . "', '" . $jobdescription . "')
        ";
        if (!mysqli_query($con_insert, $insert))
        {
            die('Error: ' . mysqli_error($con_insert));
            } else {*/
                echo "<h3>You just tried to add this shit!</h3>
                    <p>Information below: </p>
                    <p>Job title: " . $jobtitle . "</p>
                    <p>Job status: Queued</p>
                    <p>Job description: " . $jobdescription . "</p>
                    <p>Employee number: " . $employee . "</p>
                    <p>Client number: " . $client . "</p>
                    <p>Start date: " . $start . "</p>
                    <p>Due date: " . $due . "</p>";
	        echo "<script>
	        	console.log(\"This works!\");
	        </script>";
        //};
    }
?>
<!--The form actually starts here -->
<form class="add_info" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]);?>" method="post">
    <label for="jobname">Job Name: 
        <input type="text" id="jobname" name="jobname" class="text_input" value="<?php echo $jobname; ?>" placeholder="Job Name" autofocus required />
    </label>
    <label for="jobdesc">Job Description: 
        <textarea rows="4" id="jobdesc" columns="50" name="jobdesc" placeholder="Make sure it's descriptive!" value="<?php echo $jobdesc; ?>" required /></textarea>
    </label>
    <label>Status: 
        <select id="status" name="status">
            <?php require "require/statuses.php" ?>
        </select>
    </label>
    <label for="employee">Select employee: 
        <select id="employee" name="employee" required>
            <option selected disabled style="display: none;"></option>
            <?php
                while($row = mysqli_fetch_array($employees)){
                    echo "<option value=\"" . $row["employeeID"] . "\">" . $row["fName"] . " " . $row["lName"] . "</option>";
                }
            ?>
        </select>
    </label>
    <label for="client">Client: 
        <select id="client" name="client" required><!-- Test! -->
        <option selected disabled style="display: none;"></option>
            <?php
                while($client_row = mysqli_fetch_array($clients)){
        	        echo "<option value=\"" . $client_row[ClientID] . "\">" . $client_row["Name"] . "</option>";
                }
            ?>
        </select>
    </label>
    <label for="startdate">Start Date: 
        <input type="text" id="startdate" class="datepicker" placeholder="yyyy-mm-dd" name="startdate" value="<?php echo $startdate; ?>" required />
    </label>
    <label for="duedate">Due Date: 
        <input type="text" id="duedate" class="datepicker" placeholder="yyyy-mm-dd" name="duedate" pattern="[12][0123456789][0123456789][0123456789]-([0][123456789]|1[012])-([0][123456789]|[12][0123456789]|3[01])" value="<?php echo $duedate; ?>" pattern="[A-Za-z-0-9]+\s[A-Za-z-'0-9]+" required />
    </label>
    <input type="submit" id="submit" name="submit" value="Add job" />
</form>
    <link rel="stylesheet" href="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/themes/smoothness/jquery-ui.css" />
    <script src="//code.jquery.com/jquery-1.9.1.js"></script>
    <script src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
<script>
    $(function() {
        $(".datepicker").datepicker();
        $(".datepicker").datepicker("option", "dateFormat", "yy-mm-dd");
    });
</script>
