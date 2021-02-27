USE vk;

SHOW TABLES;

DESC users;

SELECT * FROM users LIMIT 10; 

UPDATE users SET username = LOWER(last_name);        

UPDATE users SET updated_at = NOW() WHERE updated_at < created_at;  

DESC profiles;

SELECT * FROM profiles LIMIT 10; 

CREATE TEMPORARY TABLE genderes(name VARCHAR(50));

INSERT INTO genderes VALUES
  ('m'),
  ('f');

UPDATE profiles SET gender = (SELECT name FROM genderes ORDER BY RAND() LIMIT 1);  

CREATE TEMPORARY TABLE countries(name VARCHAR(50));

INSERT INTO countries VALUES
  ('Russian Federation'),
  ('Belarus'),
  ('Germany'),
  ('USA'),
  ('Italy');
 
 UPDATE profiles SET country = (SELECT name FROM countries ORDER BY RAND() LIMIT 1);  

ALTER TABLE profiles MODIFY COLUMN gender ENUM ('M', 'F');

DESC messages;

SELECT * FROM messages;

UPDATE messages SET
  from_user_id = FLOOR(1 + RAND() * 100),
  to_user_id = FLOOR(1 + RAND() * 100);
 
 DESC media;

SELECT * FROM media LIMIT 10;

UPDATE media SET filename = CONCAT(
  'http://dropbox.net/vk/',
  filename,
  '.',
  (SELECT name FROM extensions ORDER BY RAND() LIMIT 1)
 );


UPDATE media SET user_id = FLOOR(1 + RAND() * 100);

CREATE TEMPORARY TABLE extensions (name VARCHAR(10));

INSERT INTO extensions VALUES ('jpeg'), ('avi'), ('mpeg'), ('png');

UPDATE media SET size = FLOOR(10000 + (RAND() * 1000000)) WHERE size < 1000;

UPDATE media SET metadata = CONCAT('{"owner":"', 
  (SELECT CONCAT(first_name, ' ', last_name) FROM users WHERE users.id = media.user_id),
  '"}');  
 
 ALTER TABLE media MODIFY COLUMN metadata JSON;

SELECT * FROM media_types;

SELECT * FROM media;

DELETE FROM media_types;

INSERT INTO media_types (name) VALUES
  ('photo'),
  ('video'),
  ('audio'),
  ('game')
;

TRUNCATE media_types;

SELECT * FROM media LIMIT 10;

UPDATE media SET media_type_id = FLOOR(1 + RAND() * 3);

DESC friendship;

SELECT * FROM friendship LIMIT 10;

UPDATE friendship SET 
  user_id = FLOOR(1 + RAND() * 100),
  friend_id = FLOOR(1 + RAND() * 100);
 
 UPDATE friendship SET friend_id = friend_id + 1 WHERE user_id = friend_id;

SELECT * FROM friendship_statuses;

TRUNCATE friendship_statuses;

INSERT INTO friendship_statuses (name) VALUES
  ('Requested'),
  ('Confirmed'),
  ('Rejected');

UPDATE friendship SET friendship_status_id = FLOOR(1 + RAND() * 3); 

 ALTER TABLE friendship DROP COLUMN requested_at;


DESC communities;

SELECT * FROM communities;

DELETE FROM communities WHERE id > 20;

SELECT * FROM communities_users;

UPDATE communities_users SET
  user_id = FLOOR(1 + RAND() * 100),
  community_id = FLOOR(1 + RAND() * 20);
 
 


 
 
SHOW TABLES;

DESC users;

SELECT * FROM users LIMIT 10; 

ALTER TABLE users ADD new_created_at DATETIME;
UPDATE users SET new_created_at = STR TO DATE(created_at, '%d.%m.%Y %l:%i');
ALTER TABLE users DROP created_at, CHANGE new_created_at created_at DATETIME;

SELECT * FROM users WHERE new_created_at IS NULL;

ALTER TABLE users ADD new_updated_at DATETIME;
UPDATE users SET new_updated_at = STR_TO_DATE (updated_at, '%d.%m.%Y %l:%i');
ALTER TABLE users DROP updated_at, CHANGE new_updated_at updated_at DATETIME;

SELECT * FROM users WHERE updated_at IS NULL;

ALTER TABLE users ADD created_at_dt DATETIME, updated_at_dt DATETIME;
UPDATE users;
SET created_at_dt = STR_TO_DATE(created_at, '%d.%m.%Y %h:%i'),
    updated_at_dt = STR_TO_DATE(updated_at, '%d.%m.%Y %h:%i');
ALTER TABLE users 
    DROP created_at, DROP updated_at, 
    RENAME COLUMN created_at_dt TO created_at, RENAME COLUMN updated_at_dt TO updated_at;

UPDATE users 
SET 
	created_at = NOW(),
	updated_at = NOW();




UPDATE users 
SET 
	created_at = STR_TO_DATE (created_at, '%d.%m.%Y %K:%i'),
	updated_at = STR_TO_DATE (updated_at, '%d.%m.%Y %K:%i');

ALTER TABLE
	users
CHANGE
	created_at created_at DATETIME DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE
	users
CHANGE
	updated_at updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

DESCRIBE users;

DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
	id SERIAL PRIMARY KEY,
	storehouse_id INT UNSIGNED,
	product_id INT UNSIGNED,
	value INT UNSIGNED COMMENT 'Запас товарной позиции на складе',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
)   COMMENT = 'Запасы на складе';
	
INSERT INTO
	storehouses_products (storehouse_id, product_id, value)
VALUES
	(1, 543, 0),
	(1, 789, 2500),
	(1, 3432, 0),
	(1, 826, 30),
	(1, 719, 500),
	(1, 638, 1);

SELECT * FROM
	storehouses_products
ORDER BY
	value = 1, value;



USE vk;

SHOW TABLES;

DESC users;

SELECT * FROM users LIMIT 10; 

SELECT
	AVG(TIMESTAMPDIFF(YEAR, birthday_at, NOW())) AS age
FROM
	users;

SELECT
	DATE_FORMAT(DATE(CONCAT_WS('-', YEAR(NOW()), MONTH(birthday_at), DAY(birthday_at))), '%W') AS day,
	COUNT(*) AS total
FROM
	users
GROUP BY
	day
order by
	total DESC;





