<?php

include("db.php");
$con = dbconnection();

if(isset($_POST["username"])){
    $username = $_POST["username"];
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


if(isset($_POST["usia"])){
    $usia = $_POST["usia"];
}
else return;

if(isset($_POST["nama"])){
    $nama = $_POST["nama"];
}
else return;

if(isset($_POST["gender"])){
    $gender = $_POST["gender"];
}
else return;

$query = "INSERT INTO `pasien`(`username`, `password`, `email`, `usia`, `nama`, `gender`) VALUES
 ('$username','$password','$email','$usia','$nama','$gender')";

 $exe=mysqli_query($con,$query);

 $arr=[];

if($exe){
    $arr["success"]="true";
}else{
    $arr["success"]="false";
}


print(json_encode($arr));
?>