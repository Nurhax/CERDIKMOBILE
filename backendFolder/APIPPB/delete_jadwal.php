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

if (!$IDPasien) {
    sendResponse(400, "Missing required fields.");
}

$sql = "DELETE FROM Jadwal WHERE IDPasien=?";
$stmt = $con->prepare($sql);
if (!$stmt) {
    sendResponse(500, "Database error: " . $con->error);
}

$stmt->bind_param("s", $IDPasien);

if ($stmt->execute()) {
    sendResponse(200, "Jadwal successfully deleted.");
} else {
    sendResponse(500, "Failed to delete Jadwal: " . $stmt->error);
}

$stmt->close();
$con->close();
?>
