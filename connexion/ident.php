<?php
	if(!isset($_SESSION)) 
    { 
        session_start(); 
    } 

    if(isset($_SESSION['id']) && $_SESSION['id'] != NULL) {
    	header("Location: ../profil/profil.php");
    }
	
	$login =  isset($_POST['cologin'])?($_POST['cologin']):'';
	$mdp =  isset($_POST['comdp'])?($_POST['comdp']):'';
	$msg = '';
	$msgAcc = isset($_SESSION['msgAcc'])?($_SESSION['msgAcc']):'';
	
	$resId;

	if(count($_POST)==0) {
		require ("ident.tpl");
	}
    else {
	    if(!verif_ident($login,$mdp)) {
	        $msg ="Erreur de saisie OU utilisateur inconnu";
	        require ("ident.tpl") ;
		}
	    else { 
	    	$msg = "Vous êtes connectés";
			$_SESSION['id'] = $resId;
			$_SESSION['login'] = $login;
			$url = "../profil/profil.php";
			header("Location:" . $url) ;
		}
	}	
	
	
	function verif_ident($login,$mdp) {
		global $resId;
		require('../connectSQL.php'); //$pdo est défini dans ce fichier
		$sql="SELECT logUser(:log,:mdp) FROM `comptes`";
		try {
			$commande = $pdo->prepare($sql);
			$commande->bindParam(':log', $login);
			$commande->bindParam(':mdp', $mdp);
			$bool = $commande->execute();
			if ($bool) {
				$resultat = $commande->fetchAll(PDO::FETCH_ASSOC); //tableau d'enregistrements
			}
		}
		catch (PDOException $e) {
			echo utf8_encode("Echec de select : " . $e->getMessage() . "\n");
			die(); // On arrête tout.
		}

		//echo json_encode($resultat);

		$param = "logUser('" . $login . "','" . $mdp . "')";
		
		if ($resultat[0][$param] == NULL) return false; 
		// ou if (empty($resultat)) return false;
		else {
			$resId = $resultat[0][$param];
			//var_dump($renvoi) ; die();
			return true;
		}
	}
?>

