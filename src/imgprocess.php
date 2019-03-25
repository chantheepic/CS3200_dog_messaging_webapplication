<?php

try{
    $target_dir = "../img/";
    $database = new AlexandraDatabase();
    $database = $database->connect();

    $statement = $database->query($query);
    $result = $statement->fetchAll(PDO::FETCH_OBJ);
    $database = null;
    return $response->withJson($result, 200);
} catch(PDOException $e){
    return $response->withStatus(500);
}

?>