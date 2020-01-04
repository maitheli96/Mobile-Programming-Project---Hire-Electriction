<?php
error_reporting(0);
include_once("dbconnect.php");
$email = $_POST['email'];

//function randompassword($chars)
//{
//    $random ='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%&*_';
    //return substr(str_shuffle($random),0,15);
//}

//$tempass = randompassword();
$tempasssha = sha1($tempass);

$sql ="UPDATE APPLICANT_DETAILS SET PASSWORD='$tempasssha' WHERE EMAIL = '$email' ";


$sqls = "SELECT * FROM APPLICANT_DETAILS 
WHERE EMAIL = '$email' AND VERIFY ='1'";
$result = $conn->query($sqls);

if ($conn -> query($sql) ===TRUE && $result->num_rows > 0) {
    sendEmail($email,$tempass);
    echo "Please reset password on your application.";
} else {
    echo "Email is does not exist";
}


function sendEmail($useremail,$tpw) {
    $to      = $useremail; 
    $subject = 'Reset Password for Hire Electrian'; 
    $message = 'Your temporary password is: '.$tpw; 
    $headers = 'From: noreply@myhire.com.my' . "\r\n" . 
    'Reply-To: '.$useremail . "\r\n" . 
    'X-Mailer: PHP/' . phpversion(); 
    mail($to, $subject, $message, $headers); 
}

?>