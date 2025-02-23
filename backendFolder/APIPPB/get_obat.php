<?php

include("db.php");
$con = dbconnection();

// Get 'id' from the user input (via GET or POST)
// Assuming we're getting it from a GET request
$id = isset($_GET['id']) ? intval($_GET['id']) : 0; // Default to 0 if no id is provided

if ($id == 0) {
    die("Invalid or missing ID parameter");
}

$query = "SELECT * FROM `obat` WHERE `idobat` = $id";

$exe = mysqli_query($con, $query);

// Error handling
if (!$exe) {
    die("Query failed: " . mysqli_error($con));
}

$arr = [];

while ($row = mysqli_fetch_array($exe)) {
    $arr[] = $row;
}

print(json_encode($arr));

?>
