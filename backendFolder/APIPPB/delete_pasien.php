<?php

include("db.php");
$con = dbconnection();

if(isset($_POST["id"])){
    $id = $_POST["id"];
}
else return;

$query = "DELETE FROM `pasien` WHERE id='$id'";

 $exe=mysqli_query($con,$query);

 //error handling
 if($exe){
    $arr["success"]="true";
}else{
    $arr["success"]="false";
}


print(json_encode($arr));
?>