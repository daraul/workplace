<?php 
    $page_title = "New Time entry";
    require "require/head.php";
    $job_id = $_GET["key"];
?>
</head>
    <body>
        <?php require "require/header.php" ?>
        <div class="body_wrapper">
            <h2 class="page_title">Add new time entry!</h2>
            <?php require "forms/new_timeentry.php" ?>
        </div>
        <footer>
            <?php require "require/footer.php" ?>
        </footer>
    </body>
    <?php require "js/basic_dependencies.php" ?>
    <style>.error {color: #FF0000;}</style>
    <script>
        /*$(function() {
            $( ".datepicker" ).datepicker();
            $( ".datepicker" ).datepicker( "option", "dateFormat", "yy-mm-dd" );
        });
        $('#timein').timepicker();
            $('#setTimeButton').on('click', function (){
            $('#timein').timepicker('setTime', new Date());
        });
        $('#timeout').timepicker();
            $('#setTimeButton').on('click', function (){
            $('#timeout').timepicker('setTime', new Date());
        });*/
    </script>
    <link rel="stylesheet" href="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/themes/smoothness/jquery-ui.css" />
</html>
