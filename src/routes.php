<?php
use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;

$app = new \Slim\App;

// Get All Intersections
$app->get('/api/intersections', function(Request $request, Response $response){
    $query = "SELECT DISTINCT intersection FROM intersection";
    fetch($query);
});

function fetch($query){
    try{
        $database = new Database();
        $database = $database->connect();

        $statement = $database->query($query);
        $intersections = $statement->fetchAll(PDO::FETCH_OBJ);
        $database = null;
        echo json_encode($intersections);
    } catch(PDOException $e){
        echo '{"error": {"text": '.$e->getMessage().'}';
    }
}
?>