<?php
    $page_title = "New job";
    require "require/head.php";
?>
    
</head>
<body>
    <?php require "require/header.php" ?>
    <div class="body_wrapper">
        <h2 class="page_title">New job information</h2>
        <p>This&#32;is&#32;where&#32;you&#39;ll&#32;add&#32;a&#32;new&#32;job&#46;</p>
        <?php require "forms/new_job.php" ?>
    </div>
    <footer>
        <?php require "require/footer.php"; ?>
    </footer>
</body>
    <?php require "js/basic_dependencies.php" ?>
</html>
