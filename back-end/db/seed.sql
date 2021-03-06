DROP DATABASE if exists fashionhackathon;
CREATE DATABASE fashionhackathon;

\c fashionhackathon;

-- DROP TABLE IF EXISTS materials_used;
-- DROP TABLE IF EXISTS manufacture_design;
-- DROP TABLE IF EXISTS materials;
-- DROP TABLE IF EXISTS designs;
-- DROP TABLE IF EXISTS users;
-- DROP TABLE IF EXISTS types;

CREATE TABLE users (
   id SERIAL PRIMARY KEY,
   username VARCHAR NOT NULL UNIQUE,
   password_digest VARCHAR NOT NULL,
   avatar_url VARCHAR NOT NULL,
   email VARCHAR NOT NULL,
   account_type VARCHAR NOT NULL 
);

CREATE TABLE design_companies (
   id SERIAL PRIMARY KEY,
   company_name VARCHAR NOT NULL
);

CREATE TABLE designers (
   id SERIAL PRIMARY KEY,
   user_id INT NOT NULL REFERENCES users(id),
   design_company_id INT NOT NULL REFERENCES design_companies(id)
);

CREATE TABLE manufacturers (
   id SERIAL PRIMARY KEY,
   manufacturer_name VARCHAR NOT NULL,
   specialty VARCHAR NOT NULL
);

CREATE TABLE manufacture_employee (
   id SERIAL PRIMARY KEY,
   employee_id INT NOT NULL REFERENCES users(id),
   manufacture_id INT NOT NULL REFERENCES manufacturers(id)
);

CREATE TABLE product_design (
   id SERIAL PRIMARY KEY,
   product_name VARCHAR NOT NULL,
   design_file VARCHAR NOT NULL,
   -- colors VARCHAR [],
   -- pattern VARCHAR NOT NULL,
   -- height INT NOT NULL,
   -- width INT NOT NULL,
   designer_specs JSON NOT NULL,
   manufacturer_specs JSON,
   complete BOOLEAN NOT NULL DEFAULT FALSE,
   designer_id INT NOT NULL REFERENCES designers(id),
   manufacturer_id INT NOT NULL REFERENCES manufacturers(id)
);

CREATE TABLE materials (
   id SERIAL PRIMARY KEY,
   material VARCHAR NOT NULL UNIQUE
);

CREATE TABLE materials_used (
   id SERIAL PRIMARY KEY,
   product_id INT NOT NULL REFERENCES product_design(id),
   material_id INT NOT NULL REFERENCES materials(id),
   percentage_used INT NOT NULL
);


INSERT INTO  
   users (username, password_digest, email, account_type, avatar_url) 
VALUES
   --1
   ('Test', 'testing', 'testing@email.com', 'DESIGNER', 'https://www.testim.io/wp-content/uploads/2019/11/Automated-Testing.jpg'),
   --2
   ('JON', 'jon', 'JON@email.com', 'MANUFACTURER', 'https://usatftw.files.wordpress.com/2019/04/ad51644215b57ef0cfea49acab180dbff2da45b775f7e9c63d4cd3402c3ed867-e1555335664836.jpg?w=651&h=391&crop=1&zoom=2'),
   --3
   ('PAM', 'pam', 'PAM@email.com', 'DESIGNER', 'https://imgix.bustle.com/uploads/image/2019/5/28/44774e68-1522-49ec-87c8-6c966a499b8c-pamtheoffice.png?w=1020&h=574&fit=crop&crop=faces&auto=format&q=70'),
   --4
   ('kam', 'kam', 'kam@email.com', 'DESIGNER', 'https://miro.medium.com/max/3150/1*XHa-3O0Q-uS7t0r8Ibgekw.jpeg'),
   --5
   ('von', 'von', 'von@email.com', 'DESIGNER', 'https://www.thenewdealer.org/wp-content/uploads/2013/03/pg-5-pic-4-800x533.jpg'),
   --6
   ('mlq', 'mlq', 'mlq@email.com', 'MANUFACTURER', 'https://media-exp1.licdn.com/dms/image/C4D03AQHKGTVYMBEsVw/profile-displayphoto-shrink_200_200/0?e=1588204800&v=beta&t=voUzhmapGHIwZXMP0Lp4K8n3vwcuBrOihGFOkx2JVks'),
   --7
   ('mik', 'mik', 'mik@email.com', 'DESIGNER', 'https://athletics.baruch.cuny.edu/images/2015/9/22/MichaelDAmparo2015.jpg?width=300'),
   --8
   ('jim', 'jim', 'jim@email.com', 'MANUFACTURER', 'https://www.indiewire.com/wp-content/uploads/2018/09/shutterstock_5886251df-e1535987220890.jpg?w=780');


INSERT INTO 
   manufacturers (manufacturer_name, specialty) 
VALUES
   --1
   ('Cotton emporium.', 'we do all things wool and cotton'),
   --2
   ('Leather', 'Leather good'),
   --3
   ('Green and Clean', 'Sustainably sourced hemp and cotton'),
   --4
   ('Hippie Dyes', 'We specialize in sustainable dying of fabrics');


INSERT INTO 
   design_companies (company_name) 
VALUES
   --1
   ('INDEPENDENT'),
   --2
   ('Cool Designs'),
   --3
   ('Lather Greats'),
   --4
   ('Vonielian Design');

INSERT INTO
   -- 1, 3, 4, 5, 7
   designers (user_id, design_company_id)
VALUES
   -- 1
   (1, 2),
   -- 2
   (3, 3),
   --3
   (4, 2),
   --4
   (5, 4),
   --5
   (7, 4);

INSERT INTO
   -- 2, 6, 8
   manufacture_employee (employee_id, manufacture_id)
VALUES
   -- 1
   (2, 1),
   -- 2
   (6, 3),
   --3
   (8, 4);


INSERT INTO 
   product_design (designer_id, manufacturer_id, product_name, designer_specs, design_file)
VALUES
   (2, 1,'Spring 2020 Long Sleeve','{  "colors": ["red", "white"], "bust": "25in", "above_bust": "15in", "under_bust": "10in", "across_shoulder": "30in", "across_back": "31in"}', 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcT4wRrSyDHTs_93veLkgHiN-PCowkeHZjP-HkfoJungVXYRKm1W'),
   (1, 2,'Fall 2019 Denim Jacket ','{  "colors": ["red", "white"], "bust": "25in", "above_bust": "15in", "under_bust": "10in", "across_shoulder": "30in", "across_back": "31in"}', 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcT4wRrSyDHTs_93veLkgHiN-PCowkeHZjP-HkfoJungVXYRKm1W'),
   (3, 3,'Spring 2020 SKirt','{  "colors": ["red", "white"], "bust": "25in", "above_bust": "15in", "under_bust": "10in", "across_shoulder": "30in", "across_back": "31in"}', 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRPqngJDpVFAJk4u1sHI0qg7FUaeZO5xLTkAY2xy5LiWeeyqKGh'),
   (3, 4,'Spring 2020 Jackal Collection','{  "colors": ["red", "white"], "bust": "25in", "above_bust": "15in", "under_bust": "10in", "across_shoulder": "30in", "across_back": "31in"}', 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQd8LiepcBFc-NMgC7VJYjxH3Zw9itr1zgGa_uqQdzzf4CvmH2A'),
   (3, 2,'Fall 2020 Jackal Collection','{  "colors": ["red", "white"], "bust": "25in", "above_bust": "15in", "under_bust": "10in", "across_shoulder": "30in", "across_back": "31in"}', 'https://img.forfansbyfans.com/image/cache/data/productimages/GuildWars2/WomensTees/17/WGDW139CDD1_Jackal_Mount_Icon_BLK-1000x1000.png'),
   (4, 1,'Fall 2109 Randal Shirt','{  "colors": ["red", "white"], "bust": "25in", "above_bust": "15in", "under_bust": "10in", "across_shoulder": "30in", "across_back": "31in"}', 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcT4wRrSyDHTs_93veLkgHiN-PCowkeHZjP-HkfoJungVXYRKm1W'),
   (4, 1,'Fall 2109 Randal Shirt','{  "colors": ["red", "white"], "bust": "25in", "above_bust": "15in", "under_bust": "10in", "across_shoulder": "30in", "across_back": "31in"}', 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcT4wRrSyDHTs_93veLkgHiN-PCowkeHZjP-HkfoJungVXYRKm1W'),
   (5, 1,'Spring 2020 Explorer Tee','{  "colors": ["red", "white"], "bust": "25in", "above_bust": "15in", "under_bust": "10in", "across_shoulder": "30in", "across_back": "31in"}', 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcT4wRrSyDHTs_93veLkgHiN-PCowkeHZjP-HkfoJungVXYRKm1W'),
   (5, 2,'Spring 2020 Adventurer Tee','{  "colors": ["red", "white"], "bust": "25in", "above_bust": "15in", "under_bust": "10in", "across_shoulder": "30in", "across_back": "31in"}', 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcT4wRrSyDHTs_93veLkgHiN-PCowkeHZjP-HkfoJungVXYRKm1W');


INSERT INTO 
   materials (material) 
VALUES 
   ('cotton'),
   ('wool'),
   ('silk'),
   ('polyester'),
   ('rayon');


INSERT INTO 
   materials_used (product_id, material_id, percentage_used) 
VALUES 
   (1, 1, 20),
   (1, 2, 20),
   (1, 3, 20),
   (1, 4, 40),
   (2, 1, 20),
   (2, 2, 20),
   (2, 3, 20),
   (2, 4, 40),
   (3, 1, 20),
   (3, 2, 20),
   (3, 3, 20),
   (3, 4, 40),
   (4, 1, 20),
   (4, 2, 20),
   (4, 3, 20),
   (4, 4, 40),
   (5, 1, 20),
   (5, 2, 20),
   (5, 3, 20),
   (5, 4, 40),
   (6, 1, 20),
   (6, 2, 20),
   (6, 3, 20),
   (6, 4, 40),
   (7, 1, 20),
   (7, 2, 20),
   (7, 3, 20),
   (7, 4, 40),
   (8, 1, 20),
   (8, 2, 20),
   (8, 3, 20),
   (8, 4, 40),
   (9, 1, 20),
   (9, 2, 20),
   (9, 3, 20),
   (9, 4, 40);