<?php

$connect = new mysqli("localhost", "root", "", "flutter_login_zulmi");
if (!$connect) {
	echo "Koneksi gagal !";
	exit();
}