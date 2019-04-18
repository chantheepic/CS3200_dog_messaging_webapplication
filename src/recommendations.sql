# Dog Recommendations - Returns 10 recommended dogs

DELIMITER //
DROP PROCEDURE IF EXISTS RecommendDogs;
CREATE PROCEDURE RecommendDogs
(
    # The dog_id of the dog we are doing a search for
    IN id INT(3)
)

   BEGIN

    DECLARE dogs_user_id INT;
    DECLARE dogs_zipcode INT;

	SELECT user_id
    INTO dogs_user_id
    FROM dog
    WHERE dog_id = id;

    SELECT zipcode
    INTO dogs_zipcode
    FROM user
	WHERE user_id = dogs_user_id;

    SELECT dog_id
    FROM dog JOIN user ON user_id
    WHERE dog.dog_id != id
    AND user.zipcode = dogs_zipcode
    LIMIT 10;

  END //
DELIMITER ;

# Get Basic Info About Dog

DELIMITER //
DROP PROCEDURE IF EXISTS GetDogInfo;
CREATE PROCEDURE GetDogInfo
(
	IN id INT(3)
)

 BEGIN

    SELECT fixed, weight, gender, description
    FROM dog
    WHERE dog_id = id;

 END //
DELIMITER ;

# Get Picture(s) of Dog

DELIMITER //
DROP PROCEDURE IF EXISTS GetDogPictures;
CREATE PROCEDURE GetDogPictures
(
	IN id INT(3)
)

 BEGIN

	SELECT photo
    FROM photo
    WHERE dog_id = id;

 END //
DELIMITER ;

# Get the temperament(s) of the dog

DELIMITER //
DROP PROCEDURE IF EXISTS GetDogTemperaments;
CREATE PROCEDURE GetDogTemperaments
(
	IN id INT(3)
)

BEGIN

    SELECT UNIQUE temp.temperament_name
    FROM dog_has_temperament JOIN temperament ON temperament_id
    WHERE dog_id = id;

 END //
DELIMITER ;

# Get the breed of the dog

DELIMITER //
DROP PROCEDURE IF EXISTS GetDogBreed;
CREATE PROCEDURE GetDogBreed
(
	IN id INT(3)
)

 BEGIN

    SELECT breed_name
    FROM breed JOIN dog ON breed_id
    WHERE dog_id = id;

 END //
DELIMITER ;
