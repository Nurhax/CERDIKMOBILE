<?php

include("db.php");
$con = dbconnection();

// Check for missing POST parameters
if(isset($_POST["nama"])){
    $nama = $_POST["nama"];
}
else return;

if(isset($_POST["jenis"])){
    $jenis = $_POST["jenis"];
}
else return;

if(isset($_POST["dosis"])){
    $dosisobat = $_POST["dosis"];  // map 'dosis' to 'dosisobat'
}
else return;

if(isset($_POST["gejala"])){
    $gejalaobat = $_POST["gejala"];  // map 'gejala' to 'GejalaObat'
}
else return;

if(isset($_POST["deskripsi"])){
    $deskripsi = $_POST["deskripsi"];
}
else return;

if(isset($_POST["ukuran"])){
    $ukuran = $_POST["ukuran"];  // map 'satuan' to 'ukuran'
}
else return;

$query = "INSERT INTO `obat`(`nama`, `jenis`, `dosisobat`, `GejalaObat`, `ukuran`, `deskripsi`) 
          VALUES ('$nama','$jenis','$dosisobat','$gejalaobat','$ukuran','$deskripsi')";

$exe = mysqli_query($con, $query);
$arr = [];

if($exe){
    $arr["success"] = "true";
} else {
    $arr["success"] = "false";
}

print(json_encode($arr));

?>
