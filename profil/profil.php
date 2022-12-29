<?php
if(!isset($_SESSION)) 
    { 
        session_start(); 
    } 

$id = isset($_SESSION['id'])?($_SESSION['id']):NULL;
$login = isset($_SESSION['login'])?($_SESSION['login']):NULL;

if($id == NULL) {
	header("Location: ../connexion/ident.php");
}

$msgMdp = isset($_SESSION['msgMdp'])?($_SESSION['msgMdp']):'';
$msgMail = isset($_SESSION['msgMail'])?($_SESSION['msgMail']):'';
$msgFriend = isset($_SESSION['msgFriend'])?($_SESSION['msgFriend']):'';
$meilleurScore = getMeilleurScore($id);
$scoreTotal = getScoreTotal($id);
$amis = getAmis($id);
$requetes = getRequetes($id);

$_SESSION['amis'] = $amis;
$_SESSION['requetes'] = $requetes;

require("profil.tpl");

function getMeilleurScore($id) {
		require('../connectSQL.php'); //$pdo est défini dans ce fichier
		$sql="SELECT meilleurScore FROM `comptes` WHERE id = :id";
		try {
			$commande = $pdo->prepare($sql);
			$commande->bindParam(':id', $id);
			$bool = $commande->execute();
			if ($bool) {
				$resultat = $commande->fetchAll(PDO::FETCH_ASSOC);
			}
		}
		catch (PDOException $e) {
			echo utf8_encode("Echec de select : " . $e->getMessage() . "\n");
			die(); // On arrête tout.
		}

		return $resultat[0]["meilleurScore"];
	}

function getScoreTotal($id) {
		require('../connectSQL.php'); //$pdo est défini dans ce fichier
		$sql="SELECT scoreTotal FROM `comptes` WHERE id = :id";
		try {
			$commande = $pdo->prepare($sql);
			$commande->bindParam(':id', $id);
			$bool = $commande->execute();
			if ($bool) {
				$resultat = $commande->fetchAll(PDO::FETCH_ASSOC);
			}
		}
		catch (PDOException $e) {
			echo utf8_encode("Echec de select : " . $e->getMessage() . "\n");
			die(); // On arrête tout.
		}

		return $resultat[0]["scoreTotal"];
	}

function getAmis($id) {
	require('../connectSQL.php'); //$pdo est défini dans ce fichier
		$sql="SELECT amis FROM `comptes` WHERE id = :id";
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
			die(); // On arrête tout.
		}

		$contacts = json_decode($resultat[0]["amis"]);
		$liste = array();

		if($contacts == NULL) {
			return;
		}

		foreach ($contacts as $ida) {
			$sql= "select id, login, email, meilleurScore, scoreTotal from comptes where id = :idu";
			try {
				$commande = $pdo->prepare($sql);
				$commande->bindParam(':idu', $ida);
				$bool = $commande->execute();
				if ($bool) {
					$resultat = $commande->fetchAll(PDO::FETCH_ASSOC);
				}
			}
			catch (PDOException $e) {
				echo utf8_encode("Echec de select : " . $e->getMessage() . "\n");
				die(); // On arrête tout.
			}

			$liste[$ida] = $resultat;
		}

		return $liste;
}

function getRequetes($id) {
	require('../connectSQL.php');
	$sql= "SELECT demandeAmis from `comptes` where id = :idu";
		try {
			$commande = $pdo->prepare($sql);
			$commande->bindParam(':idu', $id);
			$bool = $commande->execute();
			if ($bool) {
				$resultat = $commande->fetchAll(PDO::FETCH_ASSOC); //tableau d'enregistrements
			}
		}
		catch (PDOException $e) {
			echo utf8_encode("Echec de select : " . $e->getMessage() . "\n");
			die(); // On arrête tout.
		}

		$contacts = json_decode($resultat[0]["demandeAmis"]);
		$liste = array();

		if($contacts == NULL) {
			return;
		}

		foreach ($contacts as $ida) {
			$sql= "select id, login from comptes where id = :idu";
			try {
				$commande = $pdo->prepare($sql);
				$commande->bindParam(':idu', $ida);
				$bool = $commande->execute();
				if ($bool) {
					$resultat = $commande->fetchAll(PDO::FETCH_ASSOC); //tableau d'enregistrements
				}
			}
			catch (PDOException $e) {
				echo utf8_encode("Echec de select : " . $e->getMessage() . "\n");
				die(); // On arrête tout.
			}

			$liste[$ida] = $resultat;
		}

		return $liste;
}
?>