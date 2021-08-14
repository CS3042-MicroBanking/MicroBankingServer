<?php 
    include "config.php";
    
    $userName = mysqli_real_escape_string($connect, $_POST['uname']);
    //$userName = "rach123";
    $query = "SELECT agent_id FROM user WHERE uname = '$userName'";
    $res = mysqli_query($connect, $query);
    if(mysqli_num_rows($res)>0)
    {
        $row = mysqli_fetch_array($res);
        echo $row['agent_id'];
    }
    else {
        echo "account not found";
    }
?>