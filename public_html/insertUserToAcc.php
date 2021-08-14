<?php 
    include "config.php";
    
    $uname = mysqli_real_escape_string($connect, $_POST['uname']);
    $accID = mysqli_real_escape_string($connect, $_POST['acc_id']);
    
    //$uname = "rach123";
    //$accID = 25;
    
    $query = "INSERT INTO user_to_acc (uname,acc_id) VALUES('$uname','$accID')";
    
    $res = mysqli_query($connect, $query);
    
    if ($res) {
        echo "0";
    }
    else {
        echo "Insertion unsuccessful";
    }
?>