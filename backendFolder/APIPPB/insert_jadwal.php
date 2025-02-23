<?php
include("db.php");
$con = dbconnection();

function sendResponse($statusCode, $message) {
    http_response_code($statusCode);
    echo json_encode([
        "status" => $statusCode === 200 ? "success" : "error",
        "message" => $message,
    ]);
    exit;
}

error_log(print_r($_POST, true));

$IDPasien = $_POST["IDPasien"] ?? null;
$NamaObat = $_POST["NamaObat"] ?? null;
$Gejala = $_POST["Gejala"] ?? null;
$Dosis = $_POST["Dosis"] ?? null;
$Deskripsi = $_POST["Deskripsi"] ?? null;
$JenisObat = $_POST["JenisObat"] ?? null;
$Start_Date = $_POST["Start_Date"] ?? null;
$End_Date = $_POST["End_Date"] ?? null;
$WaktuKonsumsi = $_POST["WaktuKonsumsi"] ?? null;
$IsConfirmedNakes = $_POST["IsConfirmedNakes"] ?? null;

if (!$IDPasien || !$NamaObat || !$Gejala || !$Dosis || !$Start_Date || !$End_Date || !$WaktuKonsumsi) {
    sendResponse(400, "Missing required fields.");
}

$sql = "INSERT INTO Jadwal (IDPasien, Gejala, Dosis, Start_Date, End_Date, IsConfirmedNakes, NamaObat, Deskripsi, JenisObat, WaktuKonsumsi)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
$stmt = $con->prepare($sql);
if (!$stmt) {
    sendResponse(500, "Database error: " . $con->error);
}

$stmt->bind_param(
    "issssissss",
    $IDPasien,
    $Gejala,
    $Dosis,
    $Start_Date,
    $End_Date,
    $IsConfirmedNakes,
    $NamaObat,
    $Deskripsi,
    $JenisObat,
    $WaktuKonsumsi
);

if ($stmt->execute()) {
    sendResponse(200, "Jadwal successfully added.");
} else {
    sendResponse(500, "Failed to add Jadwal: " . $stmt->error);
}

$stmt->close();
$con->close();
?>
