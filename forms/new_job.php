<link rel="stylesheet" href="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/themes/smoothness/jquery-ui.css" />
<script src="//code.jquery.com/jquery-1.9.1.js"></script>
<script src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
<link id="add_job_css" class="form_css" rel="stylesheet" href="css/forms.css" />
<?php require_once "require/db_connection.php"; ?>
<?php //Form validation

    //Test input function
    function test_input($data){
        $data = trim($data);
        $data = stripslashes($data);
        $data = htmlspecialchars($data);
        return $data;
    };
?>
	
<?php //SQL connection
    $con_select = new mysqli($db_host, $user_employee, $user_employee_pw, "workplace");
    if(mysqli_connect_errno()){
        echo "Failed to connect to database. " . mysqli_connect_error();
    }
    $clients = mysqli_query($con_select, "SELECT * FROM Clients");
    $employees = mysqli_query($con_select, "SELECT * FROM employees");
?>

<?php //Check for submission
    if(isset($_POST['submit'])){
        //Test all input
        $jobtitle = test_input($_POST["jobname"]);
        $jobdescription =  test_input($_POST["jobdesc"]);
        $status = test_input($_POST["status"]);
        $employee = test_input($_POST["employee"]);
        $client = test_input($_POST["client"]);
        $start =  test_input($_POST["startdate"]);
        $due = test_input($_POST["duedate"]);
        //Check that nothing is empty
        if(empty($_POST["jobname"]) || empty($_POST["jobdesc"]) || empty($_POST["status"]) || empty($_POST["employee"]) || empty($_POST["client"]) || empty($_POST["startdate"]) || empty($_POST["duedate"])){
            //If anything is, reset the form
            echo "
                <script>
                    console.log(\"Something is empty!\");
                </script>
            ";
            $jobtitle = "";
            $jobdescription =  "";
            $status = "";
            $employee = "";
            $client = "";
            $start =  "";
            $due = "";
        } else {
            //Otherwise... check the formats of the input
            if(!preg_match("/^[a-z0-9\s]+\z/i", $jobtitle) || (!preg_match("/^[2]{1}[01]{1}[0-9]{2}\-(0[1-9]|1[012])\-(0[1-9]|1[0-9]|2[0-9]|3[01])\z/", $start)) || (!preg_match("/^[2]{1}[01]{1}[0-9]{2}\-(0[1-9]|1[012])\-(0[1-9]|1[0-9]|2[0-9]|3[01])\z/", $due))){
                //If something is wrong... reset the form
                echo "
                    <script>
                        console.log(\"Syntax is wrong somewhere!\");
                    </script>
                ";
                $jobtitle = "";
                $jobdescription =  "";
                $status = "";
                $employee = "";
                $client = "";
                $start =  "";
                $due = "";
            } else {
                //If the input is right then submit the form
                $insert = "INSERT INTO `worktodo` (`currentStatus`, `employeeID`, `ClientID`, `StartDate`, `DueDate`, `JobTitle`, `Description`)
                VALUES
                ('$status', '$employee', '$client', '$start', '$due', '$jobtitle', '$jobdescription')
                ";
                if (!mysqli_query($con_select, $insert))
                {
                    die('Error: ' . mysqli_error($con_select));
                } else {
                    echo "
                        <script>
                            console.log(\"Submission successful!\");
                        </script>
                    ";
                    echo "<h3>You just tried to add this shit!</h3>
                        <p>Information below: </p>
                        <p>Job title: " . $jobtitle . "</p>
                        <p>Job status: Queued</p>
                        <p>Job description: " . $jobdescription . "</p>
                        <p>Employee number: " . $employee . "</p>
                        <p>Client number: " . $client . "</p>
                        <p>Start date: " . $start . "</p>
                        <p>Due date: " . $due . "</p>";
    	        echo "
    	            <script>
        	        	console.log('Information added to db!');
        	        </script>";
                };
            }
        }
    }
?>
<!--The form actually starts here -->
<form class="add_info" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]);?>" method="post">
    <label for="jobname">Job Name: 
        <input type="text" id="jobname" name="jobname" class="text_input" value="<?php echo $jobname; ?>" placeholder="Job Name" pattern="[A-Za-z0-9\s]+" autofocus required />
    </label>
    <label for="jobdesc">Job Description: 
        <textarea rows="4" id="jobdesc" columns="50" name="jobdesc" placeholder="Make sure it's descriptive!" value="<?php echo $jobdesc; ?>" required /></textarea>
    </label>
    <label>Status: 
        <select id="status" name="status">
            <option selected disabled style="display: none;"></option>
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
        <select id="client" name="client" required>
        <option selected disabled style="display: none;"></option>
            <?php
                while($client_row = mysqli_fetch_array($clients)){
        	        echo "<option value=\"" . $client_row[ClientID] . "\">" . $client_row["Name"] . "</option>";
                }
            ?>
        </select>
    </label>
    <label for="startdate">Start Date: 
        <input type="text" id="startdate" class="datepicker" placeholder="yyyy-mm-dd" name="startdate" value="<?php echo $startdate; ?>"pattern="[2]{1}[01]{1}[0-9]{2}\-(0[1-9]|1[012])\-(0[1-9]|1[0-9]|2[0-9]|3[01])" required />
    </label>
    <label for="duedate">Due Date: 
        <input type="text" id="duedate" class="datepicker" placeholder="yyyy-mm-dd" name="duedate" value="<?php echo $duedate; ?>" pattern="[2]{1}[01]{1}[0-9]{2}\-(0[1-9]|1[012])\-(0[1-9]|1[0-9]|2[0-9]|3[01])" required />
    </label>
    <input type="submit" id="submit" name="submit" value="Add job" />
</form>
<script>
    $(function() {
        $( ".datepicker" ).datepicker({
          showOn: "button",
          buttonImage: "images/calendar.gif",
          buttonImageOnly: true,
          dateFormat: "yy-mm-dd"
        });
    });
</script>
