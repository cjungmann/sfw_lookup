USE SFW_Lookup;
DELIMITER $$

-- The following App_Person3_xxx_Lookup procedures will be used
-- in varied situations for the remainder of the examples.
-- There are cases where they are called directly by a response
-- mode.  Other cases call one or more of the lookup procedures
-- from within a list, edit, or add procedures.

-- ---------------------------------------------------
DROP PROCEDURE IF EXISTS App_Person3_Industry_Lookup $$
CREATE PROCEDURE App_Person3_Industry_Lookup()
BEGIN
   SELECT id, name
     FROM Industry;
END $$

-- ------------------------------------------------
DROP PROCEDURE IF EXISTS App_Person3_State_Lookup $$
CREATE PROCEDURE App_Person3_State_Lookup()
BEGIN
   SELECT id, name, abbreviation
     FROM State;
END $$

-- The main MySQL changes, other than having added procedures that
-- generate the lookup tables, are the additions of a call to those
-- new procedures where they can be available for building the forms.
--
-- Aside from the new procedures at the top of this script, the only
-- change needed in this MySQL script is to add a call for the lookup
-- data in the "edit" interaction.  (The "add" interaction directly
-- calls for lookup data in the response mode.)
--
-- An "edit" interaction used two procedures.  In this case, they are:
-- App_Person3_Value:  providing the contents of the indicated record.
--                     The lookup table goes here because it contains
--                     data for building the form.
-- App_Person3_Update: accepts the changed field values.  Since this
--                     is run after the changes, it's too late for the
--                     lookup table.

-- ----------------------------------------
DROP PROCEDURE IF EXISTS App_Person3_List $$
CREATE PROCEDURE App_Person3_List(id INT UNSIGNED)
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
DROP PROCEDURE IF EXISTS App_Person3_Add $$
CREATE PROCEDURE App_Person3_Add(fname VARCHAR(40),
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
      CALL App_Person3_List(newid);
   END IF;
END  $$


-- ----------------------------------------
DROP PROCEDURE IF EXISTS App_Person3_Read $$
CREATE PROCEDURE App_Person3_Read(id INT UNSIGNED)
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
DROP PROCEDURE IF EXISTS App_Person3_Value $$
CREATE PROCEDURE App_Person3_Value(id INT UNSIGNED)
BEGIN
   SELECT p.id,
          p.fname,
          p.lname,
          p.gender,
          p.industry,
          p.state
     FROM Person p
    WHERE p.id = id;

    CALL App_Person3_Industry_Lookup();
END $$


-- ------------------------------------------
DROP PROCEDURE IF EXISTS App_Person3_Update $$
CREATE PROCEDURE App_Person3_Update(id INT UNSIGNED,
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
      CALL App_Person3_List(id);
   END IF;
END $$



-- ------------------------------------------
DROP PROCEDURE IF EXISTS App_Person3_Delete $$
CREATE PROCEDURE App_Person3_Delete(id INT UNSIGNED)
BEGIN
   DELETE
     FROM p USING Person AS p
    WHERE p.id = id;

   SELECT ROW_COUNT() AS deleted;
END  $$

DELIMITER ;
