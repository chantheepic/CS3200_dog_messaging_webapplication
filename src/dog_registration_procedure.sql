# Dog Registration

DELIMITER //
DROP PROCEDURE IF EXISTS RegisterDog;
CREATE PROCEDURE RegisterDog
(
    IN user_id INT(10),
    IN breed VARCHAR(40),
    IN name VARCHAR(60),
    IN fixed BOOLEAN,
    IN weight INT(3),
    IN gender VARCHAR(10),
    IN description TEXT,
    OUT message VARCHAR(40)
)
  BEGIN
  
	DECLARE dog_breed_id INT;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION 
	SET message := 'register failed';
    
    SELECT breed_id
    INTO dog_breed_id
    FROM breed
    WHERE breed_name = breed;

    IF(gender != 'Male' AND gender != 'Female') THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = "Not one of the pre-determined genders";
    END IF;

    IF(weight NOT REGEXP '[0-9]') THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = "Dog's weight should only contain numbers";
    END IF;

    INSERT INTO dog VALUES(dog_id, user_id, dog_breed_id, name, fixed, weight, gender, description);
    SET message := 'register successful';
  END //
DELIMITER ;

#test
SELECT @message;
CALL RegisterDog(2, 'Akita', 'Dirk', 1, 40, 'Female', 'Dirk is dog', @message);
CALL RegisterDog(78, 'Akita', 'AAA', 1, 40, 'Male', 'AAA is a dog', @message);

SELECT * FROM dog;
SELECT * FROM user;

# Retreive dogs
DELIMITER //
DROP PROCEDURE IF EXISTS retreiveUserDogs;
CREATE PROCEDURE retreiveUserDogs(IN userId INT(10))
  BEGIN
    SELECT dog_id, dog_name FROM dog WHERE user_id = userId;
  END //
DELIMITER ;

#test
delete from dog where user_id = 78;
select * from dog;
CALL retreiveUserDogs(78);

# Retreive Dog Pals
DELIMITER //
DROP PROCEDURE IF EXISTS retreiveDogPals;
CREATE PROCEDURE retreiveDogPals(IN userId INT(10), IN dogID INT(10))
  BEGIN

    DECLARE authenticatedDog_id INT;
    
    SELECT dog_id 
    INTO dog_id
    FROM dog 
    WHERE user_id = userId AND dog_id = dogID;

    SELECT dog_id, dog_name
    FROM pal
    WHERE (dog1 = authenticatedDog_id || dog2 = authenticatedDog_id)

  END //
DELIMITER ;


# Block users
DELIMITER //
DROP PROCEDURE IF EXISTS block;
CREATE PROCEDURE block(IN dog1_id INT(10), IN dog2_id INT(10))
  BEGIN

    DECLARE user_id INT;
    DECLARE blocker_id INT;

    SELECT user_id
    INTO user_id
    FROM dog
    WHERE dog1_id = dog_id;

    SELECT user_id
    INTO blocker_id
    FROM dog
    WHERE dog2_id = dog_id;

    INSERT INTO blocked VALUES(user_id, blocker_id);

    DELETE 
    FROM pal 
	WHERE (dog1 = dog1_id && dog2 = dog2_id) || (dog2 = dog1_id && dog1 = dog2_id)

  END //
DELIMITER ;
