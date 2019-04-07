<?php 
require 'src/config/dog_database.php';

    $pdo = new DogDatabase();
    $pdo = $pdo->connect();

    $return_value = null;
    $return_value2 = null;

    $name = $_POST["screenName"];
    $username = $_POST["userName"];
    $password = $_POST["password"];
    $gender = $_POST["gender"];
    $zipcode = $_POST["zipCode"];
    $city = $_POST["cityName"];

    $stmt = $pdo->prepare("CALL RegisterUser('$name', '$username', '$password', '$gender', '$zipcode', '$city', @return)");
    $stmt->bindParam('@return', $return_value);
    $stmt->execute();

    $sql = "SELECT @return as ret1";
    $results = current($pdo->query($sql)->fetchAll());
    echo($results['ret1']);
?>