<!DOCTYPE HTML>
<html lang="fr">
<meta charset="UTF-8">

<head>
    <title>PROJET WEB</title>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"
        integrity="sha512-aVKKRRi/Q/YV+4mjoKBsE4x3H+BkegoM/em46NNlCqNTmUYADjBbeNefNxYV7giUp0VxICtqdrbqU7iVaeZNXA=="
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <link href="./classement.css" rel="stylesheet">
    <link rel="stylesheet" href="../nav.css">
</head>

<body>
    <header>
        <nav id="navbar">
            <div class="nav-container">
                <ul>
                    <a href="../jouer/index.php">
                        <li>jouer</li>
                    </a>
                    <a href="">
                        <li>classement</li>
                    </a>
                    <?php if(isset($_SESSION['id']) && $_SESSION['id'] != NULL) {
                            echo '<a href="../profil/profil.php"><li>profil</li></a>';
                            echo '<a href="../connexion/php/logout.php"><li>déconnexion</li></a>';
                        } else {
                            echo '<a href="../connexion/ident.php"><li>se connecter</li></a>';
                        }  ?>
                </ul>
            </div>
        </nav>
    </header>
    <div>
        <h1 class="Titre">Classement par meilleur score</h1>
        <table class="classement">
            <tr>
                <th>PSEUDO</th>
                <th>MEILLEUR SCORE</th>
            </tr>
            <tr>
                <?php
                    foreach ($meilleurScoreC as $u) {
                            echo "<tr class='contact'>";
                            echo ("<td>" . utf8_encode($u['login']) . "</td>");
                            echo ("<td>" . utf8_encode($u['meilleurScore']) . "</td>");
                            echo "</tr>";
                        }
                ?>
            </tr>
        </table>
        <h1 class="Titre">Classement par score total</h1>
        <table class="classement">
            <tr>
                <th>PSEUDO</th>
                <th>SCORE TOTAL</th>
            </tr>
            <tr>
                <?php
                    foreach ($totalScoreC as $u) {
                            echo "<tr class='contact'>";
                            echo ("<td>" . utf8_encode($u['login']) . "</td>");
                            echo ("<td>" . utf8_encode($u['scoreTotal']) . "</td>");
                            echo "</tr>";
                        }
                ?>
            </tr>
        </table>
    </div>
</body>

</html>