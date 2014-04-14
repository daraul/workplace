<?php 
    $page_title = "Clients";
    require "includes/head.php"; 
?>
</head>
<body>
    <?php require "includes/header.php" ?>
    <div class="body_wrapper">
        <h2 class="page_title">Clients</h2>
        <?php require "includes/clientstable.php" ?>
    </div>

    <footer>
        <?php require ("includes/footer.php"); ?>
        <h3>Client footnotes!</h3>
        <p>Well, this is where the clients should go. I haven't added the table as yet, though.</p>
    </footer>
</body>
    <?php require "js/basic_dependencies.php" ?>
</html>