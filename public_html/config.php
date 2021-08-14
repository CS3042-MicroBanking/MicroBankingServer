<?php
$username="id16149761_user";
$password="G4@databasesystem";
$host="localhost";
$db_name="id16149761_central_db";

$connect=mysqli_connect($host,$username,$password,$db_name);

if(!$connect)
{
	echo json_encode("Connection Failed");
}
/*
else {
    echo "connected to db";
}*/

?>