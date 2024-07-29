<?php
$host = 'mysql-db';
$user = 'root';
$pass = '';
$db = 'dev_pmb';

$conn = new mysqli($host, $user, $pass, $db);

if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

echo "Connected to MySQL successfully";

$conn->close();
?>