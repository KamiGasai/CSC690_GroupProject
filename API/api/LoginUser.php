<?php

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
		$response ['msg'] = "Please input username.";
		
		echo json_encode ( $response );
		exit ( 0 );
	}
	
	if ($user_list ['user_pwd'] == '') {
		$response ['ack'] = false;
		$response ['msg'] = "Please input password.";
		
		echo json_encode ( $response );
		exit ( 0 );
	}
	
	$response = $db->userLogin ( $user_list );
	if ($response['ack'] == true) {
		$response ['msg'] = 'User login successfully.';
	} else {
		$response ['msg'] = 'User login failure.';
	}
} else {
	$response ['ack'] = false;
	$response ['msg'] = 'You are not authorized';
}

echo json_encode ( $response );

?>