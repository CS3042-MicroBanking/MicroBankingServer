<?php 
    include "config.php";
    
    //$accID = mysqli_real_escape_string($connect, $_POST['acc_id']);
    //$accID = 3;

    $query = "SELECT agent_id, acc_id, amount, timestamp FROM user NATURAL JOIN user_to_acc NATURAL JOIN log";
    
    $res = mysqli_query($connect, $query);
    if(mysqli_num_rows($res) > 0)
    {
        $row = mysqli_fetch_array($res);
        //echo $row['balance'].",".$row['acc_type'];
        while($row = mysqli_fetch_assoc($res))
        {
           echo $row['agent_id'].",";
           echo $row['acc_id'].",";
           echo $row['amount'].",";
           echo $row['timestamp'].";";
        }
    }
    else {
        echo "No logs to show";
    }
?>