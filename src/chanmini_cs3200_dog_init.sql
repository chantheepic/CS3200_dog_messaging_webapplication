-- Use db

USE chanmini_cs3200_dog;

-- Set up the tables

-- User

DROP TABLE IF EXISTS user;
CREATE TABLE user (
    user_id INT(10) PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(60) NOT NULL,
    username VARCHAR(18) NOT NULL,
    password VARCHAR(32) NOT NULL,
    gender ENUM('Male', 'Female', 'Other'),
    zipcode VARCHAR(10) NOT NULL,
    city VARCHAR(30)
);

-- Dog

DROP TABLE IF EXISTS dog;
CREATE TABLE dog (
    dog_id INT(10) PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    breed_id INT DEFAULT NULL,
    fixed BOOLEAN DEFAULT NULL,
    weight INT(3) ,
    gender ENUM('Male', 'Female') DEFAULT NULL,
    description TEXT,

    CONSTRAINT fk_breed_id FOREIGN KEY (breed_id) REFERENCES breed (breed_id),
    CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES user (user_id)
);

-- Photo

DROP TABLE IF EXISTS photo;
CREATE TABLE photo (
    photo_id INT(10) PRIMARY KEY AUTO_INCREMENT,
    dog_id INT NOT NULL,
    photo BLOB NOT NULL,
    caption tinytext,

    CONSTRAINT fk_dog_id FOREIGN KEY (dog_id) REFERENCES dog (dog_id)
);

-- Pal

DROP TABLE IF EXISTS pal;
CREATE TABLE pal (
    pal_id INT(10) PRIMARY KEY AUTO_INCREMENT,
    user1 INT NOT NULL,
    user2 INT NOT NULL,

    CONSTRAINT fk_user1_id FOREIGN KEY (user1) REFERENCES user (user_id),
    CONSTRAINT fk_user2_id FOREIGN KEY (user2) REFERENCES user (user_id)
);

-- Seen

DROP TABLE IF EXISTS seen;
CREATE TABLE seen (
    user_id INT(10) NOT NULL,
    seen_user_id INT(10) NOT NULL,
    liked BOOLEAN NOT NULL,
    ts TIMESTAMP,

    CONSTRAINT fk_seeing_user_id FOREIGN KEY (user_id) REFERENCES user (user_id),
    CONSTRAINT fk_seen_user_id FOREIGN KEY (seen_user_id) REFERENCES user (user_id)
);

-- Message

DROP TABLE IF EXISTS message;
CREATE TABLE message (
    message_id INT(10) PRIMARY KEY AUTO_INCREMENT,
    time_sent TIMESTAMP NOT NULL,
    content TINYTEXT NOT NULL,
    sender_id INT NOT NULL,
    pal_id INT NOT NULL,

    CONSTRAINT fk_sender_id FOREIGN KEY (sender_id) REFERENCES user (user_id),
    CONSTRAINT fk_pal_id FOREIGN KEY (pal_id) REFERENCES pal (pal_id)
);

-- Blocked

DROP TABLE IF EXISTS blocked;
CREATE TABLE blocked (
    blocker_id INT NOT NULL,
    blockee_id INT NOT NULL,

    CONSTRAINT fk_blocker_id FOREIGN KEY (blocker_id) REFERENCES user (user_id),
    CONSTRAINT fk_blockee_id FOREIGN KEY (blockee_id) REFERENCES user (user_id)
);

-- Temperament

DROP TABLE IF EXISTS temperament;
CREATE TABLE temperament (
    temperament_id INT(10) PRIMARY KEY AUTO_INCREMENT,
    temperament_name VARCHAR(15) NOT NULL,
    description TINYTEXT NOT NULL
);

-- Dog_has_temperament

DROP TABLE IF EXISTS dog_has_temperament;
CREATE TABLE dog_has_temperament (
    dog_id INT NOT NULL,
    temperament_id INT NOT NULL,

    CONSTRAINT fk_dog_temp_id FOREIGN KEY (dog_id) REFERENCES dog (dog_id),
    CONSTRAINT fk_temp_id FOREIGN KEY (temperament_id) REFERENCES temperament (temperament_id)
);

-- dog_dislike_temperament

DROP TABLE IF EXISTS dog_dislike_temperament;
CREATE TABLE dog_dislike_temperament (
    dog_id INT NOT NULL,
    temperament_id INT NOT NULL,

    CONSTRAINT fk_temp_dog_id FOREIGN KEY (dog_id) REFERENCES dog (dog_id),
    CONSTRAINT fk_temp_dis_id FOREIGN KEY (temperament_id) REFERENCES temperament (temperament_id)
);

-- Breed

DROP TABLE IF EXISTS breed;
CREATE TABLE breed (
    breed_id INT(10) PRIMARY KEY AUTO_INCREMENT,
    breed_name VARCHAR(40) NOT NULL
);

-- User Session

DROP TABLE IF EXISTS session;
CREATE TABLE session (
    session_id VARCHAR(32) PRIMARY KEY,
    user_id VARCHAR(32) NOT NULL,
    session_start DATETIME NOT NULL
);

