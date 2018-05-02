<?php

// including the db operation file
require_once '../includes/DbOperation.php';
$db = new DbOperation ();

// creating response array
$response = array ();

if ($_SERVER ['REQUEST_METHOD'] == 'POST') {
	
	// getting values
	$user_list = array ();
	
	$user_list ['user_name'] = strtolower ( trim ( $_REQUEST ['user'] ) );
	$user_list ['user_pwd'] = trim ( $_REQUEST ['pwd'] );
	
	if ($user_list ['user_name'] == '') {
		$response ['ack'] = false;
		$response ['msg'] = "Please input user name.";
		
		echo json_encode ( $response );
		exit ( 0 );
	}
	
	if ($user_list ['user_pwd'] == '') {
		$response ['ack'] = false;
		$response ['msg'] = "Please input password.";
		
		echo json_encode ( $response );
		exit ( 0 );
	}
	
	if ($db->isUserExist ( $user_list )) {
		$response ['ack'] = false;
		$response ['msg'] = "The user has been used. Please create another one.";
		
		echo json_encode ( $response );
		exit ( 0 );
	}
	
	$user_list ['user_email'] = strtolower ( trim ( $_REQUEST ['email'] ) );
	
	// inserting values
	if ($db->createUser ( $user_list )) {
		$response ['ack'] = true;
		$response ['msg'] = 'The user was successfully created.';
	} else {
		$response ['ack'] = false;
		$response ['msg'] = 'The user was failure created.';
	}
} else {
	$response ['ack'] = false;
	$response ['msg'] = 'You are not authorized';
}

echo json_encode ( $response );

?>