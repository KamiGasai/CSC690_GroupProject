<?php

/**
 * Created by Andrew.
 * Date: 4/23/18
 */
class DbOperation {
	private $conn;
	
	// Constructor
	function __construct() {
		require_once dirname ( __FILE__ ) . '/Config.php';
		require_once dirname ( __FILE__ ) . '/DbConnect.php';
		// opening db connection
		$db = new DbConnect ();
		$this->conn = $db->connect ();
	}
	
	// create user
	public function createUser($user_list) {
		$sql = "INSERT INTO users(user_name, user_pwd, user_email) VALUES(?, ?, ?)";
		
		$stmt = $this->conn->prepare ( $sql );
		$stmt->bind_param ( "sss", $user_list ['user_name'], md5 ( $user_list ['user_pwd'] ), $user_list ['user_email'] );
		$result = $stmt->execute ();
		$stmt->close ();
		if ($result) {
			return true;
		} else {
			return false;
		}
	}
	
	// verify if user exists
	public function isUserExist($user_list) {
		if ($user_list ['user_name'] != '') {
			$sql = "SELECT * FROM users WHERE user_name = '" . $user_list ['user_name'] . "' LIMIT 1 ";
			$result = $this->conn->query ( $sql );
			
			if ($result->num_rows > 0) {
				return true;
			} else {
				return false;
			}
		} else {
			return false;
		}
	}
	
	// verify if user exists, if yes return user info
	public function userLogin($user_list) {
		$response = array ();
		
		if ($user_list ['user_name'] != '' && $user_list ['user_pwd'] != '') {
			$sql = "SELECT * FROM users WHERE user_name = '" . $user_list ['user_name'] . "' AND user_pwd = '" . md5 ( $user_list ['user_pwd'] ) . "' AND user_status = 1 LIMIT 1 ";
			$result = $this->conn->query ( $sql );
			
			if ($result->num_rows > 0) {
				/* fetch associative array */
				$object_set = array ();
				while ( $row = $result->fetch_assoc () ) {
					$object_set [] = $row;
				}
				
				/* free result set */
				$result->free ();
				
				$response ['ack'] = true;
				$response ['user'] = $object_set;
				
				return $response;
			} else {
				$response ['ack'] = false;
				$response ['user'] = null;
				
				return $response;
			}
		} else {
			$response ['ack'] = false;
			$response ['user'] = null;
			
			return $response;
		}
	}
	public function getQuestionList($cat_id) {
		$response = array ();
		
		if ($cat_id) {
			$sql = "SELECT * FROM questions WHERE cat_id = " . $cat_id . " AND ques_is_show = 1 ";
			$result_ques = $this->conn->query ( $sql );
			
			if ($result_ques->num_rows > 0) {
				$object_set = array ();
				
				while ( $row = $result_ques->fetch_assoc () ) {
					$sql_answers = "SELECT * FROM answers WHERE ques_id = " . $row ['ques_id'] . " AND ans_is_show = 1 ";
					$result_ans = $this->conn->query ( $sql_answers );
					while ( $row_ans = $result_ans->fetch_assoc () ) {
						$row ['answers'] [] = $row_ans;
					}
					
					$object_set [] = $row;
				}
				
				$result_ques->free ();
				$result_ans->free ();
				
				$response ['ack'] = true;
				$response ['ques_ans_list'] = $object_set;
				
				return $response;
			} else {
				$response ['ack'] = false;
				$response ['ques_ans_list'] = null;
			}
		} else {
			$response ['ack'] = false;
			$response ['ques_ans_list'] = null;
		}
	}
}

?>