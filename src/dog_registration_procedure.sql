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
	
    SELECT DISTINCT d.dog_id, d.dog_name
    FROM pal p join dog d on (p.dog1 = dog_id) 
    WHERE (p.dog2 = authenticatedDog_id)
	UNION
	SELECT DISTINCT d.dog_id, d.dog_name
    FROM pal p join dog d on (p.dog2 = dog_id) 
    WHERE (p.dog1 = authenticatedDog_id)
    
  END //
DELIMITER ;
