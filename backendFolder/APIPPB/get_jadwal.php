<?php
include("db.php");
$con = dbconnection();

$sql = "SELECT * FROM Jadwal";
$result = $con->query($sql);

$jadwalObat = [];

while ($row = $result->fetch_assoc()) {
    $jadwalObat[] = $row;
}

header('Content-Type: application/json');
echo json_encode($jadwalObat);

$con->close();
?>
