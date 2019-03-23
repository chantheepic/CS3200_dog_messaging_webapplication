<?php
class DogAppDatabase{
    private $servername = "chanminis.online";
    private $username = "chanmini_dog_api";
    private $password = "cascade";
    private $dbname = "chanmini_cs3200_dog";
    private $conn = null;

    public function connect() {
        try {
            $this->conn = new PDO("mysql:host=$this->servername;dbname=$this->dbname", $this->username, $this->password);
            $this->conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        }
        catch (PDOException $e) {
            echo "connection failed ". $e->getMessage(). "<br>";
        }
        return $this->conn;
    }
}
?>