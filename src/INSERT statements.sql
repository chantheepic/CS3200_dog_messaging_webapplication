USE chanmini_cs3200_dog;

-- Breed
-- Inserted dog breeds into table using Import Wizard

-- Temperament
INSERT INTO temperament(temperament_id, temperament_name, description) VALUES
(1, 'Friendly', 'Friendly towards others'),
(2, 'No kids', 'Not good with children'),
(3, 'No puppies', 'Not good with puppies'),
(4, 'No big dogs', 'Not good with big breeds'),
(5, 'No small dogs', 'Not good with small breeds'),
(6, 'Energetic', 'Very active'),
(7, 'Shy', 'Low confidence'),
(8, 'Confident', 'High confidence'),
(9, 'Playful', 'Open to playfulness'),
(10, 'Alert', 'Aware of surroundings'),
(11, 'Responsive', 'Responds to commands');

-- User
INSERT INTO user(name, username, password, gender, zipcode, city) VALUES
('Alex', 'alex12', '21xela', 'Male', '02115', 'Boston'),
('Sarah', 'sarah97', 'dogs101', 'Female', '02115', 'Boston'),
('Tim', 'timmy1', '123lmh', 'Other', '02115', 'Boston'),
('Jen', 'jenny_ss', 'wht2019', 'Female', '02115', 'Boston'),
('Barbs', 'barb_41', 'pond4', 'Other', '02120', 'Boston');

-- Dog
-- weight in lbs
INSERT INTO dog(user_id, breed_id, dog_name, fixed, weight, gender, description) VALUES
(1, 4, 'Max', 1, 60, 'Male', 'Playful adult Akita called Max'), 
(1, 6, 'Loki', 1, 50, 'Male', 'Adorable little pup'),
(2, 7,  'Luna', 0, 65, 'Female', 'Looking to make friends'), 
(3, 24, 'Tucker', 0, 24, 'Male', 'Hi!, I am Tucker'),
(4, 24, 'Bella', 1, 20, 'Female', 'Hi, I am Bella'),
(5, 77, 'Molly', 1, 20, 'Female', 'Puppy looking for friends');

-- Dog_has_temperament
INSERT INTO dog_has_temperament(dog_id, temperament_id) VALUES
(1, 1),
(1, 6),
(1, 9),
(2, 2),
(2, 9),
(3, 4),
(3, 5),
(4, 1),
(4, 8),
(4, 4),
(5, 10),
(5, 11);

-- Photo
INSERT INTO photo(dog_id, photo, caption) VALUES
(1, 'C:/Users/mahwa/Downloads/akita.jpg', 'Out for a walk'),
(1, 'C:/Users/mahwa/Downloads/akita.jpg', 'Playing'),
(2, 'C:\Users\mahwa\Downloads\malamute.jpg', 'Training'),
(3, 'C:\Users\mahwa\Downloads\bulldog.jpg', 'Day out'),
(4, 'C:\Users\mahwa\Downloads\beagle2.JPG', 'Day out'),
(5, 'C:\Users\mahwa\Downloads\beagle1.jpg', 'Playing'),
(6, 'C:\Users\mahwa\Downloads\dalmation.jpeg', 'First walk outside');

-- Seen
INSERT INTO seen(user_id, seen_user_id, liked, ts) VALUES
(1, 2, 1, '2019-03-28 16:43:56'),
(1, 3, 1, '2019-03-26 11:35:45'),
(2, 3, 1, '2019-04-01 18:23:26'),
(3, 1, 1, '2019-03-27 10:37:43'),
(3, 2, 1, '2019-04-01 12:25:36'),
(4, 2, 0, '2019-03-20 10:15:32');

-- Pal
INSERT INTO pal(user1, user2) VALUES
(3, 1),
(2, 3);

-- Blocked
INSERT INTO blocked(blocker_id, blockee_id) VALUES
(4, 2),
(1, 2);

-- Session
INSERT INTO session(session_id, user_id, session_start) VALUES
(1, 4, '2019-03-20 10:15:00'),
(2, 1, '2019-03-26 11:35:15'),
(3, 3, '2019-03-27 10:37:03'),
(4, 1, '2019-03-28 16:43:36'),
(5, 3, '2019-04-01 12:25:00'),
(6, 2, '2019-04-01 18:22:45');

-- Message
INSERT INTO message(time_sent, content, sender_id, pal_id) VALUES
('2019-03-27 10:38:43', 'Hi Alex! I am Tim. When can Tucker and Max meet?', 3, 1),
('2019-03-27 16:23:33', 'Hi Tim! We are available tomorrow at 2 pm', 1, 1),
('2019-04-01 18:25:00', 'Hello. Luna is excited to meet Tucker!', 2, 2),
('2019-04-02 13:50:16', 'Hi Sarah!', 3, 2);