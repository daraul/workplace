<?php 
    $page_title = "Clients";
    require "require/head.php"; 
?>
</head>
<body>
    <?php require "require/header.php" ?>
    <div class="body_wrapper">
        <h2 class="page_title">Clients</h2>
        <?php require "tables/clients.php" ?>
    </div>

    <footer>
        <?php require ("require/footer.php"); ?>
        <h3>Client footnotes!</h3>
        <p>Well, this is where the clients should go. I haven't added the table as yet, though.</p>
    </footer>
</body>
    <?php require "js/basic_dependencies.php" ?>
</html>
