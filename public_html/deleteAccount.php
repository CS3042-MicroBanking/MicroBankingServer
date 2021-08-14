<?php 
    include "config.php";
    
    $accID = mysqli_real_escape_string($connect, $_POST['acc_id']);
    $query = "DELETE FROM account WHERE acc_id = $accID";
    $res = mysqli_query($connect, $query);
    
    if($res > 0)
    {
        echo "0";
    } else {
        echo "Account not found";
    }
?>