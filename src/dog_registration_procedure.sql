# Dog Registration

DELIMITER //
DROP PROCEDURE IF EXISTS RegisterDog;
CREATE PROCEDURE RegisterDog
(
    IN user_id INT(3),
    IN breed VARCHAR(40),
    IN name VARCHAR(60),
    IN fixed BOOLEAN,
    IN weight INT(3),
    IN gender VARCHAR(10),
    IN description TEXT
)
  BEGIN

    DECLARE dog_breed_id INT;

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
  END //
DELIMITER ;

CALL RegisterDog(2, 'Akita', 'Dirk', 1, 40, 'Female', 'Dirk is dog');
