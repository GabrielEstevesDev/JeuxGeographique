<?php
		require('connectSQL.php'); //$pdo est défini dans ce fichier
		$sql="SELECT * FROM `ville`";
		try {
			$commande = $pdo->prepare($sql);
			$bool = $commande->execute();
			if ($bool) {
				$resultat = $commande->fetchAll(PDO::FETCH_ASSOC); //tableau d'enregistrements
				//var_dump($resultat); 
				//die();
				/*while ($ligne = $commande->fetch()) { // ligne par ligne
					print_r($ligne);
				}*/
			}
		}
		catch (PDOException $e) {
			echo "Echec de select";
			die(); // On arrête tout.
		}
		echo json_encode($resultat);
?>

