# Dog Recommendations - Returns 10 recommended dogs

DROP PROCEDURE IF EXISTS RecommendDogs;
DELIMITER //
CREATE PROCEDURE RecommendDogs(dogId INT(10))
  BEGIN
    DECLARE dogs_user_id INT;
    DECLARE dogs_zipcode INT;

	SELECT user_id, zipcode
    INTO dogs_user_id, dogs_zipcode
    FROM dog join user using (user_id)
    WHERE dog_id = dogId;

    SELECT DISTINCT d.dog_id, d.dog_name, d.fixed, b.breed_name, d.gender, d.weight, p.photo_id
    FROM dog d JOIN user u using (user_id) 
		JOIN breed b using (breed_id)
		LEFT JOIN photo p using (dog_id)
    WHERE d.dog_id != dogId
    AND d.user_id != dogs_user_id
    AND ROUND(u.zipcode / 100, 0) = ROUND(dogs_zipcode / 100, 0)
    AND d.user_id not in 
		(SELECT blockee_id
        FROM blocked b
		WHERE b.blocker_id = dogs_user_id 
        UNION
        SELECT blocker_id
        FROM blocked b
		WHERE b.blockee_id = dogs_user_id)
	AND d.dog_id not in 
		(SELECT seen_dog_id
        FROM seen s
		WHERE s.dog_id = dogId)
    LIMIT 10;
  END //
DELIMITER ;
    
# Get Basic Info About Dog
DROP PROCEDURE IF EXISTS GetDogInfo;
DELIMITER //
CREATE PROCEDURE GetDogInfo(id INT(10))
  BEGIN

    SELECT fixed, weight, gender, description
    FROM dog
    WHERE dog_id = id;

  END //
DELIMITER ;

# Get Picture(s) of Dog
DROP PROCEDURE IF EXISTS GetDogPictures;
DELIMITER //
CREATE PROCEDURE GetDogPictures(id INT(10))
  BEGIN
  
	SELECT photo
    FROM photo
    WHERE dog_id = id;

  END //
DELIMITER ;

# Get the temperament(s) of the dog
DROP PROCEDURE IF EXISTS GetDogTemperaments;
DELIMITER //
CREATE PROCEDURE GetDogTemperaments(id INT(10))
  BEGIN
  
    SELECT DISTINCT temp.temperament_name
    FROM dog_has_temperament JOIN temperament ON temperament_id
    WHERE dog_id = id;

  END //
DELIMITER ;

# Get the breed of the dog
DROP PROCEDURE IF EXISTS GetDogBreed;
DELIMITER //
CREATE PROCEDURE GetDogBreed(IN id INT(10))
  BEGIN
  
    SELECT breed_name
    FROM breed JOIN dog ON breed_id
    WHERE dog_id = id;

  END //
DELIMITER ;
