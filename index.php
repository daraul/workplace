<?php 
    $page_title = "Dashboard";
    require "require/head.php"; 
?>
</head>
<body>
    <?php require "require/header.php" ?>
    <div class="body_wrapper">
        <h2 class="page_title">The Dashboard</h2>
        <p>The dashboard is where you'll find relevant information you'll need to see first thing in the morning.</p>
        
        <?php require "tables/todo.php"; ?>
    </div>
    <footer>
        <?php require "require/footer.php" ?>
        <h3>Footnotes!</h3>
        <p>Alright, footnotes. Well so far this works. You can log in, but it won't remember you if you close the page. I'll have to figure out how to do that now...
        <br/>Click <a href="http://thurst306.kd.io/">here</a> if you get bored and want to go back home.</p>
    </footer>
</body>
    <?php require "require/basic_dependencies.php" ?>
</html>
