<?php
    $page_title = "New job";
    require "includes/head.php";
?>
    <script>
        $(function() {
            $( ".datepicker" ).datepicker();
            $( ".datepicker" ).datepicker( "option", "dateFormat", "yy-mm-dd" );
        });
    </script>
    
</head>
<body>
    <?php require "includes/header.php" ?>
    <div class="body_wrapper">
        <h2 class="page_title">New job information</h2>
        <p>This&#32;is&#32;where&#32;you&#39;ll&#32;add&#32;a&#32;new&#32;job&#46;</p>
        <?php require "includes/newjob.php" ?>
    </div>
    <footer>
        <?php require "includes/footer.php"; ?>
    </footer>
</body>
    <?php require "js/basic_dependencies.php" ?>
</html>