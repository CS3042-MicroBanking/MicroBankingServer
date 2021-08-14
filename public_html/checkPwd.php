<?php 
    include "config.php";
    
    $uname = mysqli_real_escape_string($connect, $_POST['uname']);
    $pwd = mysqli_real_escape_string($connect, $_POST['pwd']);
    
    // $uname = 'chan123';
    // $pwd = 'chanchanman';
    
    $query = "SELECT password FROM user WHERE uname = '$uname'";
    
    $res = mysqli_query($connect, $query);
    
    if(mysqli_num_rows($res)>0)
    {
        $row = mysqli_fetch_array($res);
        if($row['password'] == md5($pwd))
        {
            echo '0';
        }
        else
        {
            echo '1';   
        }
    }
    else {
        echo "Account not found";
    }
?>