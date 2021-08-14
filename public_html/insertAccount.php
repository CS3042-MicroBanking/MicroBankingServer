<?php 
    include "config.php";
    
    $uname = mysqli_real_escape_string($connect, $_POST['uname']);
    $accType = mysqli_real_escape_string($connect, $_POST['acc_type']);
    $balance = mysqli_real_escape_string($connect, $_POST['balance']);
    $jUname = mysqli_real_escape_string($connect, $_POST['j_uname']);
    
    /*$uname = 'joey123';
    $accType = 'joint';
    $balance = 25254;
    $jUname = 'chan123';*/
    
    $res = mysqli_query($connect, "CALL addAccount('$uname', '$accType', $balance, '$jUname', @id)");
    if (mysqli_num_rows($res) > 0) {
        $row = mysqli_fetch_array($res);
        $accID =  $row['acc_id'];
        $res->free();
        $connect->next_result();
        echo "$accID";
        
        $res2 = mysqli_query($connect, "SELECT interest FROM interest_rates WHERE acc_type = '$accType'");
        echo mysqli_error($connect);
        $interest = ($res2->fetch_assoc())['interest'];
        $factor = $interest/1200 + 1;
        $query2 = "CREATE EVENT savings_$accID ON SCHEDULE EVERY 1 MONTH STARTS CURRENT_TIMESTAMP DO UPDATE account SET balance = ((SELECT balance FROM account WHERE acc_id = '$accID') * $factor) WHERE acc_id = '$accID'";
        $result = mysqli_query($connect, $query2);
    }
?>