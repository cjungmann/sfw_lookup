
CREATE TABLE IF NOT EXISTS Person
(
   id       INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
   fname    VARCHAR(40),
   lname    VARCHAR(40),
   gender   ENUM('male', 'female'),
   industry VARCHAR(40),
   state    INT UNSIGNED
);


CREATE TABLE IF NOT EXISTS Industry
(
   id       INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
   name     VARCHAR(40)
);

TRUNCATE TABLE Industry;

INSERT INTO Industry(name)
     VALUES('Agriculture'),
           ('Attorney'),
           ('Automotive'),
           ('Banking'),
           ('Construction'),
           ('Education'),
           ('Food'),
           ('Health Care'),
           ('Information Technology'),
           ('Manufacturing'),
           ('Power Generation/Distribution'),
           ('Retired');
