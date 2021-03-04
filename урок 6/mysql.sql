
USE vk;

SHOW TABLES;

DESC users;

SELECT * FROM users LIMIT 10; 

alter table users add username varchar(30) not null comment "Имя пользователя для входа в сервис";


-- Создать и заполнить таблицы лайков и постов.

DROP TABLE IF EXISTS likes;
CREATE TABLE likes (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id INT UNSIGNED NOT NULL,
  target_id INT UNSIGNED NOT NULL,
  target_type_id INT UNSIGNED NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS target_types;
CREATE TABLE target_types (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL UNIQUE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO target_types (name) VALUES 
  ('messages'),
  ('users'),
  ('media'),
  ('posts');

INSERT INTO likes 
  SELECT 
    id, 
    FLOOR(1 + (RAND() * 100)), 
    FLOOR(1 + (RAND() * 100)),
    FLOOR(1 + (RAND() * 4)),
    CURRENT_TIMESTAMP 
  FROM messages;

 
SELECT * FROM likes LIMIT 10;

DROP TABLE IF EXISTS posts;
CREATE TABLE posts (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id INT UNSIGNED NOT NULL,
  community_id INT UNSIGNED,
  head VARCHAR(255),
  body TEXT NOT NULL,
  media_id INT UNSIGNED,
  is_public BOOLEAN DEFAULT TRUE,
  is_archived BOOLEAN DEFAULT FALSE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


DESC profiles;

ALTER TABLE profiles
  ADD CONSTRAINT profiles_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE CASCADE;

DESC messages;

ALTER TABLE messages
  ADD CONSTRAINT messages_from_user_id_fk 
    FOREIGN KEY (from_user_id) REFERENCES users(id),
  ADD CONSTRAINT messages_to_user_id_fk 
    FOREIGN KEY (to_user_id) REFERENCES users(id);


SHOW TABLES;

-- что делать с таблицей storehouses_products?
DESC storehouses_products;
ALTER TABLE storehouses_products
  ADD CONSTRAINT storehouses_products_storehouse_id_fk 
    FOREIGN KEY (storehouse_id) REFERENCES storehouse(id),
  ADD CONSTRAINT storehouses_products_product_id_fk
    FOREIGN KEY (product_id) REFERENCES product(id);

DESC posts;
DESC communities;

ALTER TABLE posts
  ADD CONSTRAINT posts_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id),
  ADD CONSTRAINT posts_community_id_fk 
    FOREIGN KEY (community_id) REFERENCES communities(id),
  ADD CONSTRAINT posts_media_id_fk 
    FOREIGN KEY (media_id) REFERENCES media(id);
   

DESC media;

ALTER TABLE media
  ADD CONSTRAINT media_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id),
  ADD CONSTRAINT media_media_type_id_fk 
    FOREIGN KEY (media_type_id) REFERENCES media_types(id);
  

DESC likes;

ALTER TABLE likes
	ADD CONSTRAINT likes_user_id_fk 
    	FOREIGN KEY (user_id) REFERENCES users(id);
 
    
DESC friendship;

ALTER TABLE friendship
  ADD CONSTRAINT friendship_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id);
    
    
DESC communities_users;

ALTER TABLE communities_users
  ADD CONSTRAINT communities_users_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id),
   ADD CONSTRAINT communities_users_community_id_fk 
    FOREIGN KEY (community_id) REFERENCES communities(id);
   
   
 
   
SHOW TABLES;

DESC likes;
SELECT * FROM likes LIMIT 10;

DESC profiles;
SELECT * FROM profiles LIMIT 10;


-- Определить кто больше поставил лайков (всего) - мужчины или женщины? 
-- хотел для начала проверить чтобы показывало отдельно по женщинам и мужчинам
-- кто лайкнул больше 50 раз а потом уже перейтик сравнению. Но не получилось.

(SELECT gender 
FROM profiles 
WHERE user_id= user_id AND gender = 'M')
UNION
(SELECT user_id 
FROM likes 
WHERE user_id= user_id AND target_id >= 50);


   
    	
    