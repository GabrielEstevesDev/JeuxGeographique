<!DOCTYPE HTML>
<html lang="fr">
<meta charset="UTF-8">
<head>
<title>PROJET WEB</title>
<link rel="stylesheet" href="./index.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js" integrity="sha512-aVKKRRi/Q/YV+4mjoKBsE4x3H+BkegoM/em46NNlCqNTmUYADjBbeNefNxYV7giUp0VxICtqdrbqU7iVaeZNXA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="./index.js"></script>
</head>
<body>
    <header>
        <div class="nav-container">
            <nav id="navbar">
                <ul>
                    <a href="../jouer/index.php"> <li>jouer</li></a>
                    <a href="../classement/classement.php"><li>classement</li></a>
                    <?php
                        if(isset($_SESSION['id']) && $_SESSION['id'] != NULL) {

                        echo '<a href="../profil/profil.php"><li>profil</li></a>';
                        echo '<a href="../connexion/php/logout.php"><li>déconnexion</li></a>';
                    } else {
                        echo '<a href="../connexion/ident.php"><li>se connecter</li></a>';
                    }  ?>
                </ul>
            </nav>
        </div>
    </header>
    <div id="form">
        <form action="ident.php" method="post">
            <label for="cologin">Login/email</label><br>
            <input type="text" id="cologin" name="cologin" value="" required><br>
            <label for="comdp">Mot de passe</label><br>
            <input type="password" id="comdp" name="comdp" value="" required><br><br>
            <input type="submit" value="Connection">
        </form> 
        <div><?php echo $msg;?></div>
    </div>

    <div id="form">
        <form action="php/signin.php" method="post">
            <label for="silogin">Login</label><br>
            <input type="text" id="silogin" name="silogin" value="" required><br>
            <label for="siemail">Email</label><br>
            <input type="email" id="siemail" name="siemail" value="" required><br>
            <label for="simdp">Mot de passe</label><br>
            <input type="password" id="simdp" name="simdp" value="" required><br><br>
            <input type="submit" value="Inscription">
        </form> 
        <div><?php echo $msgAcc;?></div>
    </div>

</body>
</html>