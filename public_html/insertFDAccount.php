<?php 
    include "config.php";
    
    $accID = mysqli_real_escape_string($connect, $_POST['acc_id']);
    $balance = mysqli_real_escape_string($connect, $_POST['balance']);
    $period = mysqli_real_escape_string($connect, $_POST['period']);
    
    /*$accID = 3;
    $balance = 2000;
    $period = 6;*/
    
    $query = "INSERT INTO fd_account (acc_id, balance, period) VALUES('$accID','$balance','$period')";
    
    $res = mysqli_query($connect, $query);
    
    if ($res) {
        /******************* EVENT FOR SCHEDULING INTEREST UPDATES ON SAVINGS ACCOUNT *************************/
        $fdAccID = mysqli_insert_id($connect);
        $interest = (mysqli_query($connect, "SELECT interest FROM fd_plan WHERE period = '$period'")->fetch_assoc())['interest'];
        $change = $interest * $balance/1200;
        $query2 = "CREATE EVENT event_$fdAccID ON SCHEDULE EVERY 1 MONTH STARTS CURRENT_TIMESTAMP ENDS CURRENT_TIMESTAMP + INTERVAL $period MONTH DO UPDATE account SET balance = ((SELECT balance FROM account WHERE acc_id = '$accID') + $change) WHERE acc_id = '$accID'";
        $result = mysqli_query($connect, $query2);
        echo $fdAccID;
        // echo mysqli_error($connect);
    }
    else {
        echo "Insertion unsuccessful";
    }
?>