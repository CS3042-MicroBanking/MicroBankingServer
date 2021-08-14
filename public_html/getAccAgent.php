<?php 
    include "config.php";
    
    $accID = mysqli_real_escape_string($connect, $_POST['acc_id']);
    //$accID = 12;

    $query = "SELECT agent_id FROM user NATURAL JOIN user_to_acc WHERE acc_id = '$accID'";
    
    $res = mysqli_query($connect, $query);
    if(mysqli_num_rows($res) > 0)
    {
        $row = mysqli_fetch_array($res);
        echo $row['agent_id'];
    }
    else {
        echo "account not found";
    }
?>