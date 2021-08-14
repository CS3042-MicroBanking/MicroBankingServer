<?php 
    include "config.php";
    
    $accID = mysqli_real_escape_string($connect, $_POST['acc_id']);
    $amount = mysqli_real_escape_string($connect, $_POST['amount']);
    $periodic = mysqli_real_escape_string($connect, $_POST['periodic']);
    
    $query = "CALL updateAccount($accID, $amount, $periodic)";
    $res = mysqli_query($connect, $query);

    /*$query = "SELECT balance FROM account WHERE acc_id = '$accID'";
    
    $res = mysqli_query($connect, $query);
    
    if(mysqli_num_rows($res) > 0)
    {
        $balance = mysqli_fetch_array($res)['balance'] + $amount;
        $query2 = "UPDATE account SET balance = $balance WHERE acc_id=$accID";
        $res2 = mysqli_query($connect, $query2);
        echo '$res2';
    } else {
        echo "account not found";
    }*/
?>