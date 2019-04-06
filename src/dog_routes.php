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
    return fetch_call($call, $response);
});

$app->get('/api/dogapp/procedure/test2/{string}', function(Request $request, Response $response){
    $string = $request->getAttribute('string');
    $call = "CALL test2('$string')";
    return fetch_call($call, $response);
});


function fetch_d($query, $response){
    try{
        $database = new DogDatabase();
        $database = $database->connect();

        $statement = $database->query($query);
        $result = $statement->fetchAll(PDO::FETCH_OBJ);
        $database = null;
        return $response->withJson($result, 200);
    } catch(PDOException $e){
        return $response->withStatus(500);
    }
}

function fetch_call($call, $response){
    try{
        $database = new DogDatabase();
        $database = $database->connect();

        $statement = $database->query($call);
        $result = $statement->fetchAll(PDO::FETCH_OBJ);
        $statement->nextRowset();
        $database = null;
        return $response->withJson($result, 200);
    } catch(PDOException $e){
        return $response->withStatus(500);
    }
}
?>