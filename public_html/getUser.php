<?php 
    include "config.php";
    
    $userN = mysqli_real_escape_string($connect, $_POST['uname']);
    //$userN = "chan1233";

    $query = "SELECT name,password FROM user WHERE uname = '$userN'";
    
    $res = mysqli_query($connect, $query);
    if(mysqli_num_rows($res) > 0)
    {
        $row = mysqli_fetch_array($res);
        echo $row['name'].",".$row['password'];
    }
    else {
        echo "uname not found";
    }
?>