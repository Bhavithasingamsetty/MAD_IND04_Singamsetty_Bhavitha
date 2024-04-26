<?php
// Section for DB Connection.
class DBConnection {
    private $DBHost_Name = "mysql.cs.okstate.edu";
    private $DBName = "bsingam";
    private $DBUser_Name = "bsingam";
    private $DBPassword = "@ngryBoot44";
    private $DBCon;
 
    public function __construct() {
    	try {
        	$this->DBCon = new PDO("mysql:host=$this->DBHost_Name;dbname=$this->DBName", $this->DBUser_Name, $this->DBPassword);    
        	$this->DBCon->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
	    } catch(PDOException $error) {
			echo "Database Connection Failed ! Validate Credentials!" . $error->getMessage();
		}
     }
    // Section for connection return.
    public function DBConnect() {
        return $this->DBCon;
    }
}
//Section for Fetching data.
class RetrieveData  
{
    protected $DBConObj;
    private $statename_;
    private $statenickname_;

    public function setName($name_) {
        $this->statename_ = $name_;
    }
    public function setNickName($nickname_) {
        $this->statenickname_ = $nickname_;
    }
    public function __construct() {
        $this->DBConObj = new DBConnection();
        $this->DBConObj = $this->DBConObj->DBConnect();
    }
	//Section for retrieve all data row by row.
    public function stateTableRow() {
    	try {
    	       	$sql_query = "SELECT * FROM states";
				$prepared_sql_query_statement = $this->DBConObj->prepare($sql_query);
				$prepared_sql_query_statement->execute();
				$sql_result = $prepared_sql_query_statement->fetchAll(\PDO::FETCH_ASSOC);
				return $sql_result;
		} catch (Exception $error) {
				die("Execution Failed ! Please verify SQL query.");
		}
    }
}
	$retrieveData  = new RetrieveData ();  
	$fetched_state_details = $retrieveData ->stateTableRow();
	if(!empty($fetched_state_details)) {
		$convertToJSON = json_encode(array('Execution_Status'=>TRUE, 'Fetched_state_details'=>$fetched_state_details), true);
    } else {
		$convertToJSON = json_encode(array('Execution_Status'=>FALSE, 'Execution_message'=>'NULL! No records available.'), true);
    }
	header('Content-Type: application/json');
	echo $convertToJSON;
	header("HTTP/1.0 405 Method Not Allowed");
?>
