use chanmini_cs3200_dog;

DROP PROCEDURE IF EXISTS messagesProc;

DELIMITER //

CREATE PROCEDURE messagesProc
(
  user1 VARCHAR(20),
  user2 VARCHAR(20)
)
BEGIN
	select 
		u.username as 'sender',
		m.content as 'message'
	from message as m
		left join user as u on (m.sender_id = u.user_id)
	where m.pal_id =
		(select 
			pal_id 
		from
			pal
		where (user1 message= (select user_id from user where username = user1)
			AND 
			user2 = (select user_id from user where username = user2))
			OR
			(user1 = (select user_id from user where username = user2)
			AND 
			user2 = (select user_id from user where username = user1)))
	order by m.time_sent ASC;
		
END //   

DELIMITER ;


CALL messagesProc('timmy1','alex12');