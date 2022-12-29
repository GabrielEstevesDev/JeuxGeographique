<?php
	if(!isset($_SESSION)) 
    { 
        session_start(); 
    } 

$id = isset($_SESSION['id'])?($_SESSION['id']):NULL;

if($id == NULL) {
	header("Location: ../ident.php");
}

	$exmdp = isset($_POST['exmdp'])?($_POST['exmdp']):'';
	$nmdp = isset($_POST['nmdp'])?($_POST['nmdp']):'';

	if(!verifMdp($id, $exmdp)) {
		$_SESSION['msgMdp'] = "L'ancien mot de passe est incorrect";
		header("Location: ../profil.php");
	} else {
		changeMdp($id,$nmdp);
		$_SESSION['msgMdp'] = "Le mot de passe a été changé";
		header("Location: ../profil.php");
	}

	function verifMdp($id, $mdp) {
		require('../connectSQL.php'); //$pdo est défini dans ce fichier
		$sql="SELECT samePassword(:id,:mdp) FROM `comptes`";
		try {
			$commande = $pdo->prepare($sql);
			$commande->bindParam(':id', $id);
			$commande->bindParam(':mdp', $mdp);
			$bool = $commande->execute();
			if ($bool) {
				$resultat = $commande->fetchAll(PDO::FETCH_ASSOC); //tableau d'enregistrements
			}
		}
		catch (PDOException $e) {
			echo utf8_encode("Echec de select : " . $e->getMessage() . "\n");
			die();
		}

		$param = "samePassword('" . $id . "','" . $mdp ."')";
		$int = (int)$resultat[0][$param];
		
		var_dump($int);

		if ($int == 0) return false; 
		else {
			return true;
		}
	}

	function changeMdp($id,$mdp) {
		require('../connectSQL.php'); //$pdo est défini dans ce fichier
		$sql="CALL updateMdp(:id,:mdp)";
		try {
			$commande = $pdo->prepare($sql);
			$commande->bindParam(':id', $id);
			$commande->bindParam(':mdp', $mdp);
			$commande->execute();
		}
		catch (PDOException $e) {
			echo utf8_encode("Echec de select : " . $e->getMessage() . "\n");
			die();
		}
	}	

?>