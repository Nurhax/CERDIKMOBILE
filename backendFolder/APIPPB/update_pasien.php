<?php

include("db.php");
$con = dbconnection();

if(isset($_POST["id"])){
    $username = $_POST["id"];
}
else return;

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

if(isset($_POST["gejala"])){
    $username = $_POST["gejala"];
}
else return;


if(isset($_POST["jadwal"])){
    $username = $_POST["jadwal"];
}
else return;


$query = "UPDATE `pasien` SET
`id`='$id',`username`='$username',`password`='$password',`email`='$email',`usia`='$usia',`nama`='$nama',`gender`='$gender',`gejala`='$gejala',`jadwal`='$jadwal' 
WHERE `id` = $id";

 $exe=mysqli_query($con,$query);

 $arr=[];
 
if($exe){
    $arr["success"]="true";
}else{
    $arr["success"]="false";
}


print(json_encode($arr));
?>