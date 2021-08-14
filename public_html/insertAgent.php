<?php 
    include "config.php";
    
    $name = mysqli_real_escape_string($connect, $_POST['name']);
    
    $query = "INSERT INTO agent (name) VALUES('$name')";
    
    $res = mysqli_query($connect, $query);
    
    if($res){
        echo mysqli_insert_id($connect);
    }
    else {
        echo "Insertion unsuccessful";
    }
?>