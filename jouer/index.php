<?php

if(!isset($_SESSION)) 
    { 
        session_start(); 
    }

$id = isset($_SESSION['id'])?($_SESSION['id']):NULL;

require ("index.tpl");
?>