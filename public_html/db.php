<?php

$dns = 'mysql:localhost;dbname=id16149761_central_db';
$user = 'id16149761_user';
$pass = 'G4@databasesystem';


try{
    $db = new PDO($dns,$user,$pass);
    echo 'connected';
}catch( PDOException $e){
    $error = $e->getMessage();
    echo $error;
}
