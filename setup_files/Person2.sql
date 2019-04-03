USE SFW_Lookup;
DELIMITER $$

-- ----------------------------------------
DROP PROCEDURE IF EXISTS App_Person2_List $$
CREATE PROCEDURE App_Person2_List(id INT UNSIGNED)
BEGIN
   SELECT p.id,
          p.fname,
          p.lname,
          p.gender,
          p.industry,
          p.state
     FROM Person p
    WHERE (id IS NULL OR p.id = id);
END  $$


-- ---------------------------------------
DROP PROCEDURE IF EXISTS App_Person2_Add $$
CREATE PROCEDURE App_Person2_Add(fname VARCHAR(40),
                                lname VARCHAR(40),
                                gender ENUM('male','female'),
                                industry VARCHAR(40),
                                state INT UNSIGNED)
BEGIN
   DECLARE newid INT UNSIGNED;
   DECLARE rcount INT UNSIGNED;

   INSERT INTO Person
          (fname, 
           lname, 
           gender, 
           industry, 
           state)
   VALUES (fname, 
           lname, 
           gender, 
           industry, 
           state);

   SELECT ROW_COUNT() INTO rcount;
   IF rcount > 0 THEN
      SET newid = LAST_INSERT_ID();
      CALL App_Person2_List(newid);
   END IF;
END  $$


-- ----------------------------------------
DROP PROCEDURE IF EXISTS App_Person2_Read $$
CREATE PROCEDURE App_Person2_Read(id INT UNSIGNED)
BEGIN
   SELECT p.id,
          p.fname,
          p.lname,
          p.gender,
          p.industry,
          p.state
     FROM Person p
    WHERE (id IS NULL OR p.id = id);
END  $$


-- -----------------------------------------
DROP PROCEDURE IF EXISTS App_Person2_Value $$
CREATE PROCEDURE App_Person2_Value(id INT UNSIGNED)
BEGIN
   SELECT p.id,
          p.fname,
          p.lname,
          p.gender,
          p.industry,
          p.state
     FROM Person p
    WHERE p.id = id;
END $$


-- ------------------------------------------
DROP PROCEDURE IF EXISTS App_Person2_Update $$
CREATE PROCEDURE App_Person2_Update(id INT UNSIGNED,
                                   fname VARCHAR(40),
                                   lname VARCHAR(40),
                                   gender ENUM('male','female'),
                                   industry VARCHAR(40),
                                   state INT UNSIGNED)
BEGIN
   UPDATE Person p
      SET p.fname = fname,
          p.lname = lname,
          p.gender = gender,
          p.industry = industry,
          p.state = state
    WHERE p.id = id;

   IF ROW_COUNT() > 0 THEN
      CALL App_Person2_List(id);
   END IF;
END $$



-- ------------------------------------------
DROP PROCEDURE IF EXISTS App_Person2_Delete $$
CREATE PROCEDURE App_Person2_Delete(id INT UNSIGNED)
BEGIN
   DELETE
     FROM p USING Person AS p
    WHERE p.id = id;

   SELECT ROW_COUNT() AS deleted;
END  $$

DELIMITER ;
