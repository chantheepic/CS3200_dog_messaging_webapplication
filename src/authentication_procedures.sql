# User Registeration
DELIMITER //
DROP PROCEDURE IF EXISTS RegisterUser;
CREATE PROCEDURE RegisterUser(IN name VARCHAR(60), IN username VARCHAR(18), IN password VARCHAR(32), IN gender VARCHAR(10), IN zipcode VARCHAR(10), IN city VARCHAR(30))
 BEGIN

    IF(gender != 'Male' OR gender != 'Female' OR gender != 'Other') THEN
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
 END //
DELIMITER ;

describe user;

CALL RegisterUser('Alex Name', 'asda', 'Password', 'MM', 02115, 'Boston');

SELECT * FROM user;

# User LogIn
DELIMITER //
DROP PROCEDURE IF EXISTS LogIn;
CREATE PROCEDURE LogIn(IN usern VARCHAR(18), IN pswd VARCHAR(32), OUT login_status boolean, OUT session_id VARCHAR(32), OUT user_hash VARCHAR(32))
 BEGIN
    DECLARE standard VARCHAR(32);
    SELECT password INTO standard FROM user WHERE username = usern;

    IF(standard = MD5(CONCAT(usern, pswd))) 
    THEN
		INSERT INTO session VALUES (MD5(CONCAT(NOW(), usern)), MD5(usern), NOW());
        SET login_status = true;
        SET session_id = MD5(CONCAT(NOW(), usern));
        SET user_hash = MD5(usern);
    ELSE 
		SET login_status = false;
        SET session_id = null;
        SET user_hash = null;
    END IF;
 END //
DELIMITER ;

SELECT @login_status;
SELECT @session_id;
SELECT @user_hash;

# succeed
CALL LogIn('Alex', 'Password', @login_status, @session_id, @user_hash);
SELECT * FROM session;
# fail
CALL LogIn('Alex', 'password', @login_status, @session_id, @user_hash);
# fail
CALL LogIn('alex', 'Password', @login_status, @session_id, @user_hash);

# Return LogIn
DELIMITER //
DROP PROCEDURE IF EXISTS ReturnLogIn;
CREATE PROCEDURE ReturnLogIn(IN session_id VARCHAR(32), IN user_hash VARCHAR(32), OUT login_status boolean)
 BEGIN
    DECLARE standard_session_start DATETIME;
    DECLARE standard_session_id VARCHAR(32);
    SELECT session_id INTO standard_session_id, session_start INTO  FROM session WHERE user_id = 'a08372b70196c21a9229cf04db6b7ceb' ORDER BY session_start DESC LIMIT 1;

    IF(session_id = standard_session_id AND datediff(now(), standard_session_start) = 0) 
    THEN
        SET login_status = true;
    ELSE 
        SET login_status = false;
    END IF;
 END //
DELIMITER ;

# pass
SELECT 'a08372b70196c21a9229cf04db6b7ceb' = 'a08372b70196c21a9229cf04db6b7ceb' AND datediff(now(), '2019-03-26 0:16:10') = 0;
# fail
SELECT 'a08372b70196c21a9229cf04db6b7ceb' = 'a08372b70196c21a9229cf04db6b7ceb' AND datediff(now(), '2019-03-26 0:16:10') = 0;
