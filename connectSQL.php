<?php
	//$hostname = "vs-wamp";
	$hostname = "localhost";
	$base= "projet";
	//$loginBD= "econtact";	
	$loginBD= "root";
	//$passBD="econtact";
	$passBD="";
	//$pdo = null;
	try {
		// DSN (Data Source Name)pour se connecter à MySQL
		$dsn = "mysql:server=$hostname ; dbname=$base";
		// DSN pour se connecter à MS Sql Server
		// $dsn = 'sqlsrv:server=(local)\S2008R2 ; database=mabase';
		//$pdo = new PDO ($dsn, $loginBD, $passBD);
		
		$pdo = new PDO ($dsn, $loginBD, $passBD,
		array(PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES utf8"));
		// Le dernier argument sert à ce que toutes les chaines de caractères 
		// en entrée et sortie de MySql soit dans le codage UTF-8
		
		// On active le mode d'affichage des erreurs, et le lancement d'exception en cas d'erreur
		$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
		// echo "Connexion au DSN: ".$dsn." OK! </br>";
	}
	catch (PDOException $e) {
		// affiche (en UTF8) le message d'erreur associé à l'exception
		echo utf8_encode("Echec de connexion : " . $e->getMessage() . "\n");
		die(); // On arrête tout.
	}
?>	