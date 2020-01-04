<?php
$servername = "localhost";
$username  = "hireelec_abc";
$password  = "EeqekzmuSDNs";
$dbname    ="hireelec_h_electrician";
$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn  -> connect_error)
{
    die("Connection failed:"  . $conn -> connect_error);
}
   
?>
