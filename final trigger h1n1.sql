use e2eHHA504FINAL;
show tables;
select * from H1N1_Flu_Vaccines limit 15;
DELIMITER $$
CREATE TRIGGER H1N1_concern_trigger BEFORE INSERT ON H1N1_Flu_Vaccines
FOR EACH ROW 
BEGIN IF NEW.alert >=3 THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'H1N1 concern should be a numerical value between 0 and 3. Please try again.'
;END IF;
END; $$
