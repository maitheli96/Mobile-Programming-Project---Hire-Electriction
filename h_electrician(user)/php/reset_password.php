<?php
error_reporting(0);
include_once("dbconnect.php");
$email = $_POST['email'];
$tempassword = $_POST['tempassword'];
$tempasswordsha = sha1($tempassword);
$password = $_POST['password'];
$passwordsha = sha1($password);



$sqls = "SELECT * FROM APPLICANT_DETAILS WHERE EMAIL = '$email' AND PASSWORD = '$tempasswordsha' AND VERIFY ='1'";

$result = $conn->query($sqls);

if ($result->num_rows > 0) {
    $sql ="UPDATE APPLICANT_DETAILS SET PASSWORD ='$passwordsha' WHERE EMAIL = '$email' ";
    if ($conn -> query($sql) === TRUE){
  
    echo "success";
    }
    
}else{
    echo "Your Password Not Correct.";
}