<?php
if(!isset($_SESSION)) 
    { 
        session_start(); 
    } 

$id = isset($_SESSION['id'])?($_SESSION['id']):NULL;

if($id == NULL) {
	header("Location: ../ident.php");
}

$friendId = isset($_POST['fid'])?($_POST['fid']):NULL;
removeRequete($id,$friendId);
echo json_encode((int)$friendId);

function removeRequete($id,$friendId) {
	require('../connectSQL.php');
	$sql="SELECT demandeAmis FROM `comptes` WHERE id = :id";
	try {
		$commande = $pdo->prepare($sql);
		$commande->bindParam(':id', $id);
		$bool = $commande->execute();
		if ($bool) {
			$resultat = $commande->fetchAll(PDO::FETCH_ASSOC); //tableau d'enregistrements
		}
	}
	catch (PDOException $e) {
		echo utf8_encode("Echec de select : " . $e->getMessage() . "\n");
		die();
	}

	$liste = json_decode($resultat[0]["demandeAmis"]);
	$arr[] = (int)$friendId;
	$liste = array_diff($liste,$arr);
	$temp = array_values($liste);
	$json = json_encode($temp);
		
	$sql="UPDATE `comptes` SET demandeAmis = :amis WHERE id = :id";
	try {
		$commande = $pdo->prepare($sql);
		$commande->bindParam(':amis', $json);
		$commande->bindParam(':id', $id);
		$bool = $commande->execute();
	}
	catch (PDOException $e) {
		echo utf8_encode("Echec de select : " . $e->getMessage() . "\n");
		die();
	}
}

?>