<?php
if(!isset($_SESSION)) 
    { 
        session_start(); 
    } 

$id = isset($_SESSION['id'])?($_SESSION['id']):NULL;

if($id == NULL) {
    header("Location: ../ident.php");
}

$_SESSION['id'] = NULL;
header("Location: ../ident.php");

?>