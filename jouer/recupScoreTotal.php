<?php

if(!isset($_SESSION)) 
    { 
        session_start(); 
    }

$id = isset($_SESSION['id'])?($_SESSION['id']):NULL;

$scoreActuel = $_POST["pointsTotal"];
$scoreAvant=(getScore($id));
$scoreTotal=$scoreActuel+$scoreAvant;
majScore($id,$scoreTotal);
function getScore($id){
    require('../connectSQL.php'); //$pdo est défini dans ce fichier
            $sql="SELECT scoreTotal FROM `comptes` where id=:id";
            try {
                $commande = $pdo->prepare($sql);
                $commande->bindParam(':id', $id);
                $bool = $commande->execute();
                if ($bool) {
                    $resultat = $commande->fetchAll(PDO::FETCH_ASSOC); //tableau d'enregistrements
                }
            }
            catch (PDOException $e) {
                echo "Echec de select";
                die(); // On arrête tout.
            }
            return json_decode($resultat[0]["scoreTotal"]);
}

function majScore($id,$scoreTotal){
    echo("jesuis la");
    require('../connectSQL.php'); //$pdo est défini dans ce fichier
            $sql="UPDATE `comptes` SET scoreTotal=:scoreTotal WHERE id=:id";
            try {
                $commande = $pdo->prepare($sql);
                $commande->bindParam(':scoreTotal', $scoreTotal);
                $commande->bindParam(':id', $id);
                $bool = $commande->execute();
            }
            catch (PDOException $e) {
                echo "Echec d'update'";
                die(); // On arrête tout.
            }
}

?>