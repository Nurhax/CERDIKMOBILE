<?php

include("db.php");
$con = dbconnection();

if(isset($_POST["idobat"])){
    $idobat = $_POST["idobat"];
}
else return;

$query = "DELETE FROM `obat` WHERE idobat='$idobat'";

 $exe=mysqli_query($con,$query);

 //error handling
 if($exe){
    $arr["success"]="true";
}else{
    $arr["success"]="false";
}


print(json_encode($arr));
?>