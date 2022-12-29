<?php
if(!isset($_SESSION)) 
    { 
        session_start(); 
    } 

$id = isset($_SESSION['id'])?($_SESSION['id']):NULL;

if($id == NULL) {
	header("Location: ../ident.php");
}

$login =  isset($_POST['friend'])?($_POST['friend']):'';
$amis = isset($_SESSION['amis'])?($_SESSION['amis']):NULL;
$requetes = isset($_SESSION['requetes'])?($_SESSION['requetes']):NULL;
$friendId = getFriend($login);
$_SESSION['friendId'] = $friendId;

if(areFriends($amis,$login,$friendId)) {
	$_SESSION['msgFriend'] = "Vous êtes déjà amis";
} else {
	if(alreadyAsking($id,$friendId)) {
		$_SESSION['msgFriend'] = "Vous avez déjà fait une demande à cet utilisateur";
	} else {
		if(strcmp($requetes[$friendId][0]["login"],$login)==0) {
			$_SESSION['msgFriend'] = "Cet utilisateur vous demande déjà en ami";
		} else {
			if($friendId == NULL) {
				$_SESSION['msgFriend'] = "Cet utilisateur n'existe pas";
			} else {
				askFriend($friendId,$id);
				$_SESSION['msgFriend'] = "Ami ajouté";
			}
		}
	}
}

header("Location: ../profil.php");

function getFriend($login) {
	require('../connectSQL.php'); //$pdo est défini dans ce fichier
		$sql="SELECT getIdByLogin(:login) FROM `comptes`";
		try {
			$commande = $pdo->prepare($sql);
			$commande->bindParam(':login', $login);
			$bool = $commande->execute();
			if ($bool) {
				$resultat = $commande->fetchAll(PDO::FETCH_ASSOC); //tableau d'enregistrements
			}
		}
		catch (PDOException $e) {
			echo utf8_encode("Echec de select : " . $e->getMessage() . "\n");
			die();
		}

		return $resultat[0]["getIdByLogin('" . $login . "')"];
}

function areFriends($amis,$login,$friendId) {
	if($amis[$friendId] == NULL) return false;
	return strcmp($amis[$friendId][0]["login"], $login) == 0;
}

function askFriend($id,$friendId) {
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
	$liste[] = (int)$friendId;
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

function alreadyAsking($id,$friendId) {
	require('../connectSQL.php');
	$sql="SELECT demandeAmis FROM `comptes` WHERE id = :id";
	try {
		$commande = $pdo->prepare($sql);
		$commande->bindParam(':id', $friendId);
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

	return in_array($id, $liste);
}
?>