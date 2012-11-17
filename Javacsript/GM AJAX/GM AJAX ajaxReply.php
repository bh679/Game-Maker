<?php

/* This is a copy of the PHP script the GM AJAX example is requesting - so you 
   can see what's going on behind the scenes.*/

header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");
header("Cache-Control: no-cache");
header("Pragma: no-cache");
header("Access-Control-Allow-Origin: *");

$ip=$_SERVER['REMOTE_ADDR'];

if (isset($_POST['browser']) && isset($_POST['os']))
{
	switch($_POST['browser'])
	{
		case "-1":
			$browser = "Not a Browser";
			break;
		case "1":
			$browser = "Internet Explorer";
			break;
		case "2":
			$browser = "Firefox";
			break;
		case "3":
			$browser = "Chrome";
			break;
		case "4":
			$browser = "Safari";
			break;
		case "5":
			$browser = "Opera";
			break;
		case "6":
			$browser = "Safari Mobile";
			break;
		default:
			$browser = "Unknown";
			break;
	}
	
	switch($_POST['os'])
	{
		case "0":
			$os = "Windows 32-Bit";
			break;
		case "1":
			$os = "Windows 64-Bit";
			break;
		case "2":
			$os = "Android";
			break;
		case "3":
			$os = "PSP";
			break;
		case "4":
			$os = "Linux";
			break;
		case "5":
			$os = "Mac OS X";
			break;
		case "6":
			$os = "iOS";
			break;
		default:
			$os = "Unknown";
			break;
	}

	exit("##Hello IP: " . $ip . "!#Your POST Request was received!#The current UNIX time is: " . time() . "##Using the POST data sent:#Browser: " . $browser . "#OS: " . $os);
}

if ($_SERVER['REQUEST_METHOD'] == 'GET')
{
	exit("##Hello IP: " . $ip . "!#Your GET Request was received!#The current UNIX time is: " . time());
}

if ($_SERVER['REQUEST_METHOD'] == 'POST')
{
	exit("##Hello IP: " . $ip . "!#Your POST Request was received!#The current UNIX time is: " . time());
}

exit("##Hello IP: " . $ip . "!#Your request was received!#The current UNIX time is: " . time());

?>