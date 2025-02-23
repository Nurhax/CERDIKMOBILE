<?php

include("db.php");
$con = dbconnection();

if(isset($_POST["username"])){
    $username = $_POST["username"];
}
else return;

if(isset($_POST["nama"])){
    $nama = $_POST["nama"];
}
else return;


if(isset($_POST["password"])){
    $password = $_POST["password"];
}
else return;


if(isset($_POST["email"])){
    $email = $_POST["email"];
}
else return;


if(isset($_POST["nomorSTR"])){
    $nomorSTR = $_POST["nomorSTR"];
}
else return;


$query = "INSERT INTO `nakes`(`username`, `namalengkap`, `email`, `password`, `nomorSTR`) VALUES
 ('$username','$nama','$email','$password','$nomorSTR')";

 $exe=mysqli_query($con,$query);

 $arr=[];

if($exe){
    $arr["success"]="true";
}else{
    $arr["success"]="false";
}


print(json_encode($arr));
?>