USE SFW_Lookup;
DELIMITER $$

-- ---------------------------------------------------
DROP PROCEDURE IF EXISTS App_Person4_Industry_Lookup $$
CREATE PROCEDURE App_Person4_Industry_Lookup()
BEGIN
   SELECT id, name
     FROM Industry;
END $$

-- ------------------------------------------------
DROP PROCEDURE IF EXISTS App_Person4_State_Lookup $$
CREATE PROCEDURE App_Person4_State_Lookup()
BEGIN
   SELECT id, name, abbreviation
     FROM State;
END $$

-- ----------------------------------------
DROP PROCEDURE IF EXISTS App_Person4_List $$
CREATE PROCEDURE App_Person4_List(id INT UNSIGNED)
BEGIN
   SELECT p.id,
          p.fname,
          p.lname,
          p.gender,
          p.industry,
          p.state
     FROM Person p
    WHERE (id IS NULL OR p.id = id);

   CALL App_Person4_Industry_Lookup();
   CALL App_Person4_State_Lookup();
END  $$


-- ---------------------------------------
DROP PROCEDURE IF EXISTS App_Person4_Add $$
CREATE PROCEDURE App_Person4_Add(fname VARCHAR(40),
                                lname VARCHAR(40),
                                gender VARCHAR(6),
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
      CALL App_Person4_List(newid);
   END IF;
END  $$


-- ----------------------------------------
DROP PROCEDURE IF EXISTS App_Person4_Read $$
CREATE PROCEDURE App_Person4_Read(id INT UNSIGNED)
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
DROP PROCEDURE IF EXISTS App_Person4_Value $$
CREATE PROCEDURE App_Person4_Value(id INT UNSIGNED)
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
DROP PROCEDURE IF EXISTS App_Person4_Update $$
CREATE PROCEDURE App_Person4_Update(id INT UNSIGNED,
                                   fname VARCHAR(40),
                                   lname VARCHAR(40),
                                   gender VARCHAR(6),
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
      CALL App_Person4_List(id);
   END IF;
END $$



-- ------------------------------------------
DROP PROCEDURE IF EXISTS App_Person4_Delete $$
CREATE PROCEDURE App_Person4_Delete(id INT UNSIGNED)
BEGIN
   DELETE
     FROM p USING Person AS p
    WHERE p.id = id;

   SELECT ROW_COUNT() AS deleted;
END  $$

DELIMITER ;
