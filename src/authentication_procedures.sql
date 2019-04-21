# User Registeration
DELIMITER //
DROP PROCEDURE IF EXISTS RegisterUser;
CREATE PROCEDURE RegisterUser(IN name VARCHAR(60), IN username VARCHAR(18), IN password VARCHAR(32), IN gender VARCHAR(10), IN zipcode VARCHAR(10), IN city VARCHAR(30), OUT message VARCHAR(32))
 BEGIN
 
	DECLARE EXIT HANDLER FOR SQLEXCEPTION 
	SET message := 'register failed';
    
    IF(gender != 'Male' AND gender != 'Female' AND gender != 'Other') THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = "not one of predetermined gender";
    END IF;
    
    IF(city NOT REGEXP '[a-z]') THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = "city name should not contain numbers or special characters";
    END IF;
    
    IF(zipcode NOT REGEXP '[0-9]') THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = "zip code should not contain characters or special characters";
    END IF;
 
	INSERT INTO user VALUES(0, name, username, MD5(CONCAT(username, password)), gender, zipcode, city);
    SET message := 'register successful'; 
 END //
DELIMITER ;

SELECT @message;

describe user;
CALL RegisterUser('Alex Name', 'alex3', 'Password', 'Male', 02115, 'Boston', @message);
CALL RegisterUser('Katie', 'asdaa', 'Password', 'Female', 02115, 'Boston', @message);
CALL RegisterUser('Alex Name', 'asda', 'Password', 'MM', 02115, 'Boston', @message);

SELECT * FROM user;

# User LogIn
DROP PROCEDURE IF EXISTS LogIn;

DELIMITER //
CREATE PROCEDURE LogIn(IN usern VARCHAR(18), IN pswd VARCHAR(32), OUT login_status boolean, OUT session_id VARCHAR(32), OUT user_name VARCHAR(32), OUT user_id_out INT(10))
 BEGIN
    DECLARE referencePswd VARCHAR(32);
    DECLARE userId INT(10);
    SELECT password, user_id INTO referencePswd, userId FROM user WHERE username = usern;

    IF(referencePswd = MD5(CONCAT(usern, pswd))) 
    THEN
		INSERT INTO session VALUES (MD5(CONCAT(NOW(), usern)), userId, NOW());
        SET login_status := true;
        SET session_id := MD5(CONCAT(NOW(), usern));
        SET user_name := usern;
        SET user_id_out := userId;
    ELSE 
		SET login_status := false;
        SET session_id := null;
        SET user_name := null;
        SET user_id_out := null;
    END IF;
 END //
DELIMITER ;

SELECT @login_status;
SELECT @session_id;
SELECT @user_name;
SELECT @user_id_out;

# succeed
CALL LogIn('alex1', 'Password', @login_status, @session_id, @user_name, @user_id_out);
SELECT * FROM session;
SELECT * FROM user;
truncate session;
CALL LogIn('chantheepic', 'cascade', @login_status, @session_id, @user_name, @user_id_out);
# fail
CALL LogIn('Alex', 'password', @login_status, @session_id, @user_name, @user_id_out);
# fail
CALL LogIn('alex', 'Password', @login_status, @session_id, @user_name, @user_id_out);
 
# Return LogIn
DELIMITER //
DROP PROCEDURE IF EXISTS ReturnLogIn;
CREATE PROCEDURE ReturnLogIn(IN session_code VARCHAR(32), IN userid INT(10), OUT login_status boolean)
 BEGIN
    DECLARE reference_session_start DATETIME;
    DECLARE reference_session_id VARCHAR(32);
    SELECT session_id, session_start INTO reference_session_id, reference_session_start FROM session WHERE user_id LIKE userid ORDER BY session_start DESC LIMIT 1;

    IF(session_code = reference_session_id AND datediff(now(), reference_session_start) = 0) 
    THEN
        SET login_status := true;
    ELSE 
        SET login_status := false;
    END IF;
 END //
DELIMITER ;

SELECT @login_status2;
CAll ReturnLogIn('fb14241aa5d902919eca5ac768fab59a', '78', @login_status2);
SELECT * FROM session;
# pass
SELECT 'a08372b70196c21a9229cf04db6b7ceb' = 'a08372b70196c21a9229cf04db6b7ceb' AND datediff(now(), '2019-03-26 0:16:10') = 0;
# fail
SELECT 'a08372b70196c21a9229cf04db6b7ceb' = 'a08372b70196c21a9229cf04db6b7ceb' AND datediff(now(), '2019-03-26 0:16:10') = 0;
