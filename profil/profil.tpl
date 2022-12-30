<!DOCTYPE HTML>
<html lang="fr">
<meta charset="UTF-8">
<head>
<title>PROJET WEB</title>
<link rel="stylesheet" href="./Css/profil.css">
<link rel="stylesheet" href="../nav.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css"integrity="sha512-MV7K8+y+gLIBoVD59lQIYicR65iaqukzvf/nwasF0nqhPay5w/9lJmVM2hMDcnK1OnMGCdVK+iQrJ7lzPJQd1w==" crossorigin="anonymous" referrerpolicy="no-referrer"/>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"
        integrity="sha512-aVKKRRi/Q/YV+4mjoKBsE4x3H+BkegoM/em46NNlCqNTmUYADjBbeNefNxYV7giUp0VxICtqdrbqU7iVaeZNXA=="
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="./profil.js"></script>
</head>
<body>
    <header>
        <div class="nav-container">
            <nav id="navbar">
                <ul>
                    <a href="../jouer/index.php"> <li>jouer</li></a>
                    <a href="../classement/classement.php"><li>classement</li></a>
                    <a href="#"><li>profil</li></a>
                    <a href="../connexion/php/logout.php"><li>déconnexion</li></a>
                </ul>
            </nav>
        </div>
    </header>
    <h1 class="Titre">Bienvenue <?php echo $login ?></h1>
    <div>
        <section>
            <h1 class="Titre" >Statistiques</h1>
            <h3>Meilleur score</h3>
            <div><?php echo $meilleurScore; ?><div>
            <h3>Score total</h3>
            <div><?php echo $scoreTotal; ?><div>
            <br><br><br><br><br>
        </section>

        <section>
            <h1 class="Titre">Changer d'adresse mail</h1>
            <br>
            <form action="php/changeMail.php" method="post">
                <label for="mail">Email</label><br>
                <input type="mail" id="mail" name="mail" value="" required><br>
                <label for="emailc">Confirmer l'email</label><br>
                <input type="mail" id="mailc" name="mailc" value="" required><br><br>
                <input  class="BtnInput" type="submit" value="Envoyer" id="submitMail" disabled="true">
                <div id="msgMailc"></div>
            </form>
            <div><?php echo $msgMail; $_SESSION['msgMail'] = ''; ?></div>
            <br><br>
        </section>

        <section>
            <h1 class="Titre" >Changer de mot de passe</h1>
            <br>
            <form action="php/changeMdp.php" method="post">
            <label for="exmdp">Ancien mot de passe</label><br>
            <input type="password" id="exmdp" name="exmdp" value="" required><br>
            <label for="nmdp">Nouveau mot de passe</label><br>
            <input type="password" id="nmdp" name="nmdp" value="" required><br>
            <label for="password">Confirmer le nouveau mot de passe</label><br>
            <input type="password" id="mdpc" name="mdpc" value="" required><br><br>
            <input class="BtnInput" type="submit" value="Envoyer" id="submitMdp" disabled>
            <div id="msgMdpc"></div>
            </form>
            <div><?php echo $msgMdp; $_SESSION['msgMdp'] = ''; ?></div>
            <br><br>
        </section>

        <section>
            <h1 class="Titre">Amis</h1>
            
            <br><?php
                if (count($amis) != 0) {
                    echo ("<h2>Voici la liste de vos amis :</h2><br>");
                    echo ('<table id="TableAmis">');
                    echo ('<tr><th> PSEUDO </th> <th> MAIL </th> <th> SCORE TOTAL </th> <th> MEILLEUR SCORE </th> <th> SUPPRIMER </th></tr>');
                    foreach ($amis as $u) {
                        $fid = $u[0]['id'];
                        echo "<tr class='contact' id='ami$fid'>";
                        echo ("<td> <div class='td'>" . utf8_encode($u[0]['login']) . "</div></td>");
                        echo ("<td> <div class='td'>" . utf8_encode($u[0]['email']) . "</div></td>");
                        echo ("<td> <div class='td'>" . utf8_encode($u[0]['scoreTotal']) . "</div></td>");
                        echo ("<td> <div class='td'>" . utf8_encode($u[0]['meilleurScore']) . "</div></td>");
                        echo ("<td><div class='supprimer' name='$fid'>Supprimer</div></td>");
                        echo "</tr>";
                    }
                    echo ('</table>');
                } else echo ("Vous n'avez pas encore ajouté d'amis");
            ?>
            <br>
            <h1 class="Titre">Demande d'amis</h1><br>
            <form class="form" id="Demandeamis" action="php/askFriend.php" method="post">
                <label for="friend">Ajouter un ami</label><br>
                <input type="text" id="friend" name="friend" value="">
                <input class="BtnInput" type="submit" value="Ajouter" id="addFriend">
                <div><?php echo $msgFriend; $_SESSION['msgFriend'] = '';?></div>
            </form>
            <?php
                if ($requetes != NULL) {
                    echo ("<br><h2>Requêtes d'amis</h2><br>");
                    echo ('<table>');
                    echo ('<tr><th>PSEUDO</th><th> </th><th> </th></tr>');
                    foreach ($requetes as $u) {
                        $log = $u[0]['login'];
                        $fid = $u[0]['id'];
                        echo "<tr class='requetes' id='req$fid'>";
                        echo ("<td><div>$log</div></td>");
                        echo ("<td><div class='reqAccepter' name='$fid'>Accepter</div></td>");
                        echo ("<td><div class='reqRefuser' name='$fid'>Refuser</div></td>");
                        echo "</tr>";
                    }
                    echo ('</table>');
                };
            ?>
        </section>
    </div>
</body>
</html>