<?php
use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;

// Get All Intersections
$app->get('/api/dogapp/test', function(Request $request, Response $response){
    $query = "SELECT DISTINCT pk, intersection, type FROM intersection";
    return fetch_d($query, $response);
});

$app->get('/api/dogapp/users', function(Request $request, Response $response){
    $query = "SELECT * FROM user;";
    return fetch_d($query, $response);
});

$app->get('/api/dogapp/procedure/test1', function(Request $request, Response $response){
    $call = "CALL test1()";
    return fetch_procedure($call, $response);
});

$app->get('/api/dogapp/procedure/test2', function(Request $request, Response $response){
    return $response->withJson(registerUser(), 200);
});

$app->get('/api/dogapp/procedure/test3', function(Request $request, Response $response){
    $pdo = new DogDatabase();
    $pdo = $pdo->connect();

    $stmt = $pdo->prepare("CALL test3('asdahsbj', @return)");
    $stmt->bindParam('@return', $return_value, PDO::PARAM_STR, 4000); 
    $return_value = null;
    $stmt->execute();

    $sql = "SELECT @return";
    $results = current($pdo->query($sql)->fetchAll());
    return $response->withJson($results, 200);
});

$app->get('/api/dogapp/procedure/test4', function(Request $request, Response $response){
    $pdo = new DogDatabase();
    $pdo = $pdo->connect();

    $stmt = $pdo->prepare("CALL test4(:name)");
    $stmt->bindParam(':name', $name);
    $name = 'one';
    $stmt->execute();
    $result = $stmt->fetchAll(PDO::FETCH_OBJ);
    
    return $response->withJson($result, 200);
});

function fetch_d($query, $response){
    try{
        $database = new DogDatabase();
        $database = $database->connect();

        $statement = $database->query($query);
        $statement->fetchAll(PDO::FETCH_OBJ);
        
        $result = $statement->nextRowset();
        $database = null;
        return $response->withJson($result, 200);
    } catch(PDOException $e){
        return $response->withStatus(500);
    }
}

function fetch_procedure($procedure, $response){
    try{
        $database = new DogDatabase();
        $database = $database->connect();

        $procedure = $database->query($procedure);
        $result = $procedure->fetchAll(PDO::FETCH_OBJ);
        $database = null;
        return $response->withJson($result, 200);
    } catch(PDOException $e){
        return $response->withStatus(500);
    }
}
?>