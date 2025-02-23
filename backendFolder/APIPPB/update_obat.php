<?php

include("db.php");
$con = dbconnection();

if(isset($_POST["nama"])){
    $nama = $_POST["nama"];
}
else return;


if(isset($_POST["jenis"])){
    $jenis = $_POST["jenis"];
}
else return;


if(isset($_POST["saranPenyajian"])){
    $saranPenyajian = $_POST["saranPenyajian"];
}
else return;

$query = "UPDATE `obat` SET 
`nama`='$nama',`jenis`='$jenis',`saranPenyajian`='$saranPenyajian' WHERE `nama` = '$nama'";

 $exe=mysqli_query($con,$query);

 $arr=[];
 
if($exe){
    $arr["success"]="true";
}else{
    $arr["success"]="false";
}


print(json_encode($arr));
?>