-----------------------
-- AFTER ADDING DATA --
-----------------------

ALTER TABLE `faculty`
ADD CONSTRAINT 
    FOREIGN KEY (`f_super`)
REFERENCES `faculty`(`f_id`);
    ON DELETE RESTRICT
    ON UPDATE CASCADE;