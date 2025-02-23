<?php

include("db.php");
$con = dbconnection();

$query = "SELECT * FROM `obat`";

 $exe=mysqli_query($con,$query);

 //error handling
 if (!$exe) {
    die("Query failed: " . mysqli_error($con)); // Error handling
}


 $arr=[];
 
 while($row=mysqli_fetch_array($exe)){
    $arr[]=$row;
 }


print(json_encode($arr));
?>