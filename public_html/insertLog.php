<?php 
    include "config.php";
    // acc_id, amount, timestamp
 
    $acc_id = mysqli_real_escape_string($connect, $_POST['acc_id']);
    $amount = mysqli_real_escape_string($connect, $_POST['amount']);
    $timestamp = mysqli_real_escape_string($connect, $_POST['timestamp']);
    
 
//$acc_id = 19;
//$amount = +400;
// $timestamp = "2021-03-01 13:32:26";
    
    $query = "INSERT INTO log (acc_id,amount,timestamp) VALUES('$acc_id','$amount','$timestamp')";
    
    $res = mysqli_query($connect, $query);
    
    if($res){
        echo mysqli_insert_id($connect);
    }
    else {
        echo "Insertion unsuccessful";
    }
?>