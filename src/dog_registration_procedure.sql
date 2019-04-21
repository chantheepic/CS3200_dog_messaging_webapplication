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

# Retreive Pal
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