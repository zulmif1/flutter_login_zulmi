<?php

include 'koneksi.php';

$u=$_POST['username'];
$p=$_POST['password'];

$qR=$connect->query("SELECT * FROM tb_admin WHERE username='".$u."' AND password='".$p."'");

$result=array();

while($fetchData=$qR->fetch_assoc()){
	$result[]=$fetchData;
}

echo json_encode($result);