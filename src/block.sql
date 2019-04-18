# Block a User

DELIMITER //
DROP PROCEDURE IF EXISTS BlockUser;
CREATE PROCEDURE BlockUser
(
    IN user_name1 VARCHAR(40),
    IN user_name2 VARCHAR(40),
)
  BEGIN

    DECLARE user_id1 INT;
    DECLARE user_id2 INT;

    SELECT user_id
    INTO user_id1
    FROM user
    WHERE username = user_name1;

    SELECT user_id
    INTO user_id2
    FROM user
    WHERE username = user_name2;

    INSERT INTO blocked VALUES(user_id1, user_id2);
  END //
DELIMITER ;

CALL BlockUser(1, 2);
