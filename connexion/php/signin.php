<?php
if(!isset($_SESSION)) 
    { 
        session_start(); 
    } 

$id = isset($_SESSION['id'])?($_SESSION['id']):NULL;

if($id == NULL) {
	header("Location: ../ident.php");
}

	$login =  isset($_POST['silogin'])?($_POST['silogin']):'';
	$email =  isset($_POST['siemail'])?($_POST['siemail']):'';
	$mdp =  isset($_POST['simdp'])?($_POST['simdp']):'';


	if(identExists($login, $email)) {
		$msgAcc = "Le login et/ou le mail existe déjà";
		$_SESSION['msgAcc'] = $msgAcc;
		header("Location: ../ident.php");
	} else {
		signIn($login,$email,$mdp);
		$msgAcc = "Compte créé, vous pouvez vous connecter";
		$_SESSION['msgAcc'] = $msgAcc;
		header("Location: ../ident.php");
	}
	
	// IMPORTANT Rappel PDO
	//PDOStatement::prepare() et PDOStatement::execute()
	//pour préparer des requêtes et les exécuter qu'elles rendent OU PAS des lignes 
	
	function identExists($login, $email) {
		var_dump(verifLogin($login));
		var_dump(verifEmail($email));
		if(verifLogin($login) /*|| verifEmail($email)*/) {
			return true;
		} else {
			return false;
		}
	}
	
	function verifEmail($email) {
		require('../connectSQL.php'); //$pdo est défini dans ce fichier
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

	function verifLogin($login) {
		require('../connectSQL.php'); //$pdo est défini dans ce fichier
		$sql="SELECT loginExists(:log) FROM `comptes`";
		try {
			$commande = $pdo->prepare($sql);
			$commande->bindParam(':log', $login);
			$bool = $commande->execute();
			if ($bool) {
				$resultat = $commande->fetchAll(PDO::FETCH_ASSOC); //tableau d'enregistrements
			}
		}
		catch (PDOException $e) {
			echo utf8_encode("Echec de select : " . $e->getMessage() . "\n");
			die();
		}

		$param = "loginExists('" . $login . "')";
		$int = (int)$resultat[0][$param];

		if ($int == 0) return false; 
		else {
			return true;
		}
	}

	function signIn($login, $email, $mdp) {
		require('../connectSQL.php'); //$pdo est défini dans ce fichier
		$sql="CALL signIn(:log,:email,:mdp)";
		try {
			$commande = $pdo->prepare($sql);
			$commande->bindParam(':log', $login);
			$commande->bindParam(':email', $email);
			$commande->bindParam(':mdp', $mdp);
			$commande->execute();
		}
		catch (PDOException $e) {
			echo utf8_encode("Echec de select : " . $e->getMessage() . "\n");
			die();
		}
	}
?>