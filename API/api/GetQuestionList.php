<?php
require_once '../includes/DbOperation.php';
$db = new DbOperation ();

// creating response array
$response = array ();

if ($_SERVER ['REQUEST_METHOD'] == 'POST') {
	
	$ques_ans_list = array ();
	
	$cat_id = $_REQUEST ['cat_id'];
	
	if (! $cat_id) {
		$response ['ack'] = false;
		$response ['msg'] = "Please select category.";
		
		echo json_encode ( $response );
		exit ( 0 );
	}
	
	$response = $db->getQuestionList ( $cat_id );
	if ($response ['ack'] == true) {
		$response ['msg'] = 'Successfully.';
	} else {
		$response ['msg'] = 'Failure.';
	}
} else {
	$response ['ack'] = false;
	$response ['msg'] = 'You are not authorized';
}

echo json_encode ( $response );

?>