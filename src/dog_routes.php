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

$app->get('/api/dogapp/procedure/test2/{string}', function(Request $request, Response $response){
    $string = $request->getAttribute('string');
    $call = "CALL test2('$string')";
    return fetch_procedure($call, $response);
});

// $app->get('/api/dogapp/procedure/test3', function(Request $request, Response $response){
//     $pdo = new DogDatabase();
//     $pdo = $pdo->connect();

//     $stmt = $pdo->prepare("CALL test3(hello, @ostring)");
//     $stmt->bindParam(':istring', 'AAZZ');
//     $stmt->execute();
//     $outputArray = $this->dbh->query("select @ostring")->fetch(PDO::FETCH_ASSOC);
//     // $outputArray['@ostring']
//     echo('aaa');
// });

$app->get('/api/dogapp/procedure/test3', function(Request $request, Response $response){
    $pdo = new DogDatabase();
    $pdo = $pdo->connect();

    $stmt = $pdo->query("CALL test3('hello', @ostring)");
    // $stmt->bindParam(1, 'AAZZ');
    $stmt->execute();
    $outputArray = $this->dbh->query("select @ostring")->fetch(PDO::FETCH_ASSOC);
    // $outputArray['@ostring']
    echo('aaa');
});

$app->get('/api/dogapp/procedure/test4', function(Request $request, Response $response){
    $pdo = new DogDatabase();
    $pdo = $pdo->connect();

    $ppp = 'katie';
    $stmt = $pdo->prepare("CALL test4('$ppp')");
    $stmt->execute();
    $result = $stmt->fetchAll(PDO::FETCH_OBJ);
    $stmt->nextRowset();
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