<?php

function dbconnection(){
    $con = mysqli_connect("localhost","root","","cerdik");
    return $con;
}


?>