<?php
	if(!isset($_SESSION)) 
    { 
        session_start(); 
    } 

$id = isset($_SESSION['id'])?($_SESSION['id']):NULL;

if($id == NULL) {
	header("Location: ../../ident.php");
}

	$email = isset($_POST['mail'])?($_POST['mail']):'';

	if(verifMail($email)) {
		$_SESSION['msgMail'] = "Ce mail est déjà utilisé";
	} else {
		changeMail($id,$email);
		$_SESSION['msgMail'] = "adresse mail a été changée";
	}

	header("Location: ../profil.php");

	function verifMail($email) {
		require('../../connectSQL.php'); //$pdo est défini dans ce fichier
		$sql="SELECT emailExists(:mail) FROM `comptes`";
		try {
			$commande = $pdo->prepare($sql);
			$commande->bindParam(':mail', $email);
			$bool = $commande->execute();
			if ($bool) {
				$resultat = $commande->fetchAll(PDO::FETCH_ASSOC); //tableau d'enregistrements
			}
		}
		catch (PDOException $e) {
			echo utf8_encode("Echec de select : " . $e->getMessage() . "\n");
			die();
		}

		$param = "emailExists('" . $email . "')";
		$int = (int)$resultat[0][$param];
		
		if ($int == 0) return false; 
		else {
			return true;
		}
	}

	function changeMail($id,$email) {
		require('../connectSQL.php'); //$pdo est défini dans ce fichier
		$sql="CALL updateMail(:id,:mail)";
		try {
			$commande = $pdo->prepare($sql);
			$commande->bindParam(':id', $id);
			$commande->bindParam(':mail', $email);
			$commande->execute();
		}
		catch (PDOException $e) {
			echo utf8_encode("Echec de select : " . $e->getMessage() . "\n");
			die();
		}
	}	

?>