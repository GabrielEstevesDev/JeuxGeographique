<html lang="fr">
<meta charset="UTF-8">

<head>
    <title>PROJET WEB</title>
    <link rel="stylesheet" href="./styles/index.css">
    <script src="https://unpkg.com/typewriter-effect@latest/dist/core.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css"
        integrity="sha512-MV7K8+y+gLIBoVD59lQIYicR65iaqukzvf/nwasF0nqhPay5w/9lJmVM2hMDcnK1OnMGCdVK+iQrJ7lzPJQd1w=="
        crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.2/dist/leaflet.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"
        integrity="sha512-aVKKRRi/Q/YV+4mjoKBsE4x3H+BkegoM/em46NNlCqNTmUYADjBbeNefNxYV7giUp0VxICtqdrbqU7iVaeZNXA=="
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script src="https://unpkg.com/leaflet@1.9.2/dist/leaflet.js"></script>
    <script src="./index.js"></script>
</head>

<body>
    <header>
        <nav id="navbar">
            <div class="nav-container">
                <ul>
                    <a href="#">
                        <li>jouer</li>
                    </a>
                    <a href="../classement/classement.php">
                        <li>classement</li>
                    </a>
                    <?php
                        if(isset($_SESSION['id']) && $_SESSION['id'] != NULL) {

                        echo '<a href="../profil/profil.php"><li>profil</li></a>';
                        echo '<a href="../connexion/php/logout.php"><li>déconnexion</li></a>';
                    } else {
                        echo '<a href="../connexion/ident.php"><li>se connecter</li></a>';
                    }  ?>
                </ul>
            </div>
        </nav>
    </header>
    <section class="jeuContainer">
        <div id="title"></div>
        <div class="infosParties">
            <h2 id="manche"></h2>
            <h2 id="nomVille"></h2>
            <h2 id="points"></h2>
        </div>
        <div id="containerProgressBar">
            <div id="progressBar">
            </div>
        </div>
        <div id="map">
            <div id="accueilJeu">
                <h2>Villes de</h2>
                <h1>France</h1>
                <p>Localisez les villes.<br> Vous avez 10 secondes par ville.</p>
                <?php 
                    if(isset($_SESSION['id']) && $_SESSION['id'] != NULL) {
                        echo '<button id="lancerAvecChrono">Jouer</button>';
                        echo '<button id="lancerSansChrono">Jouer sans chrono</button>';
                    } else {
                        echo '<a href="../connexion/ident.php"><button id="seConnecter">Connectez-vous pour jouer</button></a>';
                        echo '<button style="display:none;"id="lancerAvecChrono">Jouer</button>';
                        echo '<button style="display:none;" id="lancerSansChrono">Jouer sans chrono</button>';
                    }
                ?>
            </div>
            <span id="recommencer"><i class="fa-solid fa-rotate-right"></i></span>
            <div id="popup">
                <div id="msg"></div>
                <button id="btn"></button>
            </div>
        </div>

    </section>
</body>

</html>