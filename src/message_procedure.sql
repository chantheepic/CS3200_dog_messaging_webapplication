use chanmini_cs3200_dog;

DROP PROCEDURE IF EXISTS retreiveMessage;

DELIMITER //
CREATE PROCEDURE retreiveMessage(sender_id VARCHAR(20), recipient_id VARCHAR(20))
BEGIN
	SELECT sender.dog_name as 'sender', content, time_sent
	FROM message as m INNER JOIN dog as sender ON m.dog_id1 = sender.dog_id
	WHERE (m.dog_id1 LIKE sender_id AND m.dog_id2 LIKE recipient_id) OR (m.dog_id1 LIKE recipient_id AND m.dog_id2 LIKE sender_id)
	order by m.time_sent DESC;
END //   
DELIMITER ;

DROP PROCEDURE IF EXISTS sendMessage;

DELIMITER //
CREATE PROCEDURE sendMessage(sender_id VARCHAR(20), recipient_id VARCHAR(20), content VARCHAR(180))
BEGIN
	INSERT INTO message VALUES (0, now(), content, false, sender_id, recipient_id);
END //   
DELIMITER ;

CALL sendMessage(2, 26, 'hello');
CALL sendMessage(2, 26, 'bye');
CALL sendMessage(2, 26, 'wait');
CALL retreiveMessage(2, 1);
CALL retreiveMessage(1, 2);
select * from message;
truncate message;
select * from dog;