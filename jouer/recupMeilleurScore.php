<?php

if(!isset($_SESSION)) 
    { 
        session_start(); 
    }

$id = isset($_SESSION['id'])?($_SESSION['id']):NULL;

$scoreActuel = $_POST["points"];
echo($scoreActuel);
$scoreAvant=(getMeilleurScore($id));
echo($scoreAvant);
if($scoreActuel>$scoreAvant) majScore($id,$scoreActuel);
echo(getMeilleurScore($id));
function getMeilleurScore($id){
    require('../connectSQL.php'); //$pdo est défini dans ce fichier
            $sql="SELECT meilleurScore FROM `comptes` where id=:id";
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
            return json_decode($resultat[0]["meilleurScore"]);
}

function majScore($id,$scoreActuel){
    echo("jesuis la");
    require('../connectSQL.php'); //$pdo est défini dans ce fichier
            $sql="UPDATE `comptes` SET meilleurScore=:scoreActuel WHERE id=:id";
            try {
                $commande = $pdo->prepare($sql);
                $commande->bindParam(':scoreActuel', $scoreActuel);
                $commande->bindParam(':id', $id);
                $bool = $commande->execute();
            }
            catch (PDOException $e) {
                echo "Echec d'update'";
                die(); // On arrête tout.
            }
}

?>