<?php
    $page_title = "Job information";
    require "require/head.php";
    $con_select = new mysqli("localhost","employee","1234","workplace");
    if(mysqli_connect_errno()){
        echo "Failed to connect to database. " . mysqli_connect_error();
    }
    $job_id = $_GET["key"];
    $JobTitles = mysqli_query($con_select, "SELECT JobTitle FROM worktodo WHERE JobID=" . $job_id);
    $jobtitle = mysqli_fetch_array($JobTitles);
?>
</head>
<body>
    <?php require "require/header.php" ?>
    <div class="body_wrapper">
        
        <!-- Start the table below. This isn't hard. -->
        <?php if(isset($job_id)){
            echo "<h2>\"" . $jobtitle[JobTitle] . "\" job summary</h2>
            <h3>Time entries: </h3>";
            require "includes/timeentrytable.php";
            echo "<a href=\"new_timeentry.php?key=" . $job_id . "\"><input type=\"button\" value=\"Add time entry\"></a>
            <h3>Job information </h3>
            <p>You can edit the job's information here: </p>";
            require "includes/updatejobinfo.php";
        } else {
            echo "<h2>You didn't choose a job!</h2>
            <h3>Choose one below: </h3>";
            require "includes/todotable.php";
        }    
        ?>
    </div>
        <footer>
            <?php include "includes/footer.php"; ?>
            <h3>Footnotes!</h3>
            <p>Alright, footnotes. Well so far this works. You can log in, but it won't remember you if you close the page. I'll have to figure out how to do that now...
            <br/>Click <a href='http://thurst306.kd.io/'>here</a> if you get bored and want to go back home.</p>
        </footer>
    </div>
</body>
    <?php require "js/basic_dependencies.php" ?>
</html>