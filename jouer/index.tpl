<html lang="fr">
<meta charset="UTF-8">

<head>
    <title>PROJET WEB</title>
    <link rel="stylesheet" href="./styles/index.css">
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
                    <a href="">
                        <li>jouer</li>
                    </a>
                    <a href="">
                        <li>classement</li>
                    </a>
                    <a href="">
                        <li>contactez-nous</li>
                    </a>
                    <a href="">
                        <li>se connecter</li>
                    </a>
                    <a href="">
                        <li></li>
                    </a>
                </ul>
            </div>
        </nav>
    </header>
    <section class="map">
        <h1 class="title">Bienvenue sur notre jeu géographique !</h1>
        <div class="stat">
            <h2 id="manche"></h2>
            <h2 id="nomVille"></h2>
            <h2 id="points"></h2>
        </div>
        <div id="file-Container">
            <progress id="file"> </progress>
        </div>
        <div id="map">
            <div id="map-container">
                <div class="container">
                    <h2>Villes de</h2>
                    <h1>France</h1>
                    <p>Localisez les villes.<br> Vous avez 10 secondes par ville.</p>
                    <button id="lancerAvecChrono">Jouer</button>
                    <button id="lancerSansChrono">Jouer sans chrono</button>
                </div>
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