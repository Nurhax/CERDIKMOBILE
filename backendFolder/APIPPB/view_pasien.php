<?php

include("db.php");
$con = dbconnection();

$query = "SELECT * FROM `pasien`";

 $exe=mysqli_query($con,$query);

 $arr=[];

//error handling

 if (!$exe) {
    die("Query failed: " . mysqli_error($con));
}

 
 while($row=mysqli_fetch_array($exe)){
    $arr[]=$row;
 }


print(json_encode($arr));
?>