<?php
if(!isset($_SESSION)) 
    { 
        session_start(); 
    }

    $meilleurScoreC = getMeilleurScoreC();
    $totalScoreC = getTotalScoreC();

    $_SESSION['meilleurScoreC'] = getMeilleurScoreC();
    $_SESSION['totalScoreC'] = getTotalScoreC();

    require("classement.tpl");

    function getMeilleurScoreC() {
        require('../connectSQL.php'); //$pdo est défini dans ce fichier
        $sql="SELECT login, meilleurScore FROM `comptes` ORDER BY `meilleurScore` DESC LIMIT 30";
        try {
            $commande = $pdo->prepare($sql);
            $bool = $commande->execute();
            if ($bool) {
                $resultat = $commande->fetchAll(PDO::FETCH_ASSOC); //tableau d'enregistrements
            }
        }
        catch (PDOException $e) {
            echo utf8_encode("Echec de select : " . $e->getMessage() . "\n");
            die();
        }

        return $resultat;
    }

    function getTotalScoreC() {
        require('../connectSQL.php'); //$pdo est défini dans ce fichier
        $sql="SELECT login, scoreTotal FROM `comptes` ORDER BY `scoreTotal` DESC LIMIT 30";
        try {
            $commande = $pdo->prepare($sql);
            $bool = $commande->execute();
            if ($bool) {
                $resultat = $commande->fetchAll(PDO::FETCH_ASSOC); //tableau d'enregistrements
            }
        }
        catch (PDOException $e) {
            echo utf8_encode("Echec de select : " . $e->getMessage() . "\n");
            die();
        }

        return $resultat;
    }
?>