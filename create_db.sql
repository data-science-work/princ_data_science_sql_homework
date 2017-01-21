CREATE DATABASE IF NOT EXISTS lipscomb;

USE lipscomb;


/* ---------- LISPCOMB DB ---------- */


/* ---------- DEFINITIONS ----------
pk                                = primary key
fk                                = foreign key
referential integrity constraints = ric
*/


/*---------- COURSE TABLE ----------
pk: course_id
fk: none
ric:
    on update: none
    on delete: none
*/
CREATE TABLE `course` (
    `course_id` INTEGER PRIMARY KEY AUTO_INCREMENT,
    `course_no` VARCHAR(10) NOT NULL,
    `course_name` VARCHAR(50) NOT NULL,
    `credits` TINYINT NOT NULL
);


/*---------- LOCATION TABLE ----------
pk: loc_id
fk: none
ric:
    on update: none
    on delete: none
*/
CREATE TABLE `location` (
    `loc_id` INTEGER PRIMARY KEY AUTO_INCREMENT,
    `bldg_code` VARCHAR(10) NOT NULL,
    `room` VARCHAR(5) NOT NULL,
    `capacity` INTEGER NOT NULL
);


/*---------- FACULTY TABLE ----------
pk: f_id
fk: loc_id
ric:
    on update: cascade | will update the student table and course_section table.
    on delte: restrict | delete is restricted the location table since
                         location are asigned to faculty members.
*/
CREATE TABLE `faculty` (
    `f_id` INTEGER PRIMARY KEY AUTO_INCREMENT,
    `f_last` VARCHAR(50) NOT NULL,
    `f_first` VARCHAR(50) NOT NULL,
    `f_mi` VARCHAR(1),
    `f_phone` VARCHAR(15),
    `f_rank` VARCHAR(30) NOT NULL,
    `f_super` INTEGER,
    `f_pin` VARCHAR(4) NOT NULL,
    `loc_id` INTEGER,
    FOREIGN KEY (`loc_id`)
        REFERENCES location (`loc_id`)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);


/*---------- STUDENT TABLE ----------
pk: s_id
fk: f_id
ric:
    on update: cascade  | will update the faculty table and enrollment table.
    on delete: restrict | delete is restricted to the faculty table since 
                         students are asigned to faculty members.
*/
CREATE TABLE `student` (
    `s_id` INTEGER PRIMARY KEY AUTO_INCREMENT,
    `s_last` VARCHAR(50) NOT NULL,
    `s_first` VARCHAR(50) NOT NULL,
    `s_mi` VARCHAR(1) NOT NULL,
    `s_address` VARCHAR(75) NOT NULL,
    `s_city` VARCHAR(50) NOT NULL,
    `s_state` VARCHAR(2) NOT NULL,
    `s_zip` VARCHAR(5) NOT NULL,
    `s_phone` VARCHAR(15) NOT NULL,
    `s_class` VARCHAR(5) NOT NULL,
    `s_dob` DATE NOT NULL,
    `s_pin` VARCHAR(4) NOT NULL,
    `date_enrolled` DATE,
    `f_id` INTEGER,
    FOREIGN KEY (`f_id`)
        REFERENCES faculty (`f_id`)
        ON UPDATE CASCADE 
        ON DELETE RESTRICT
);


/*---------- TERM TABLE ----------
pk: term_id
fk: none
ric:
    on update: none
    on delete: none
*/
CREATE TABLE `term` (
    `term_id` INTEGER PRIMARY KEY AUTO_INCREMENT,
    `term_desc` VARCHAR(20) NOT NULL,
    `status` VARCHAR(6) NOT NULL,
    `start_date` DATE NOT NULL
);


/*---------- COURSE_SECTION TABLE ----------
pk: c_sec_id
fk: course_id, term_id, f_id, loc_id
ric:
    on update: cascade  | will update the enrollment table.
    on delete: no action | delete no action on the tabels course,
                          term, faculty and location.
*/
CREATE TABLE `course_section` (
    `c_sec_id` INTEGER PRIMARY KEY AUTO_INCREMENT,
    `course_id` INTEGER NOT NULL,
    `term_id` INTEGER NOT NULL,
    `sec_num` INTEGER NOT NULL,
    `f_id` INTEGER NOT NULL,
    `mtg_days` VARCHAR(7) NOT NULL,
    `start_time` TIME NOT NULL,
    `end_time` TIME NOT NULL,
    `loc_id` INTEGER,
    `max_enrl` INTEGER,
    FOREIGN KEY (`course_id`)
        REFERENCES course (`course_id`)
        ON UPDATE CASCADE 
        ON DELETE NO ACTION,
    FOREIGN KEY (`term_id`)
        REFERENCES term (`term_id`)
        ON UPDATE CASCADE 
        ON DELETE NO ACTION,
    FOREIGN KEY (`f_id`)
        REFERENCES faculty (`f_id`)
        ON UPDATE CASCADE 
        ON DELETE NO ACTION,
    FOREIGN KEY (`loc_id`)
        REFERENCES location (`loc_id`)
        ON UPDATE CASCADE
        ON DELETE NO ACTION
);


/*---------- ENROLLMENT TABLE ----------
pk: enr_id
fk: s_id, c_sec_id
ric:
    on update: cascade                | will update the faculty table and enrollment table.
    on delete: restrict and no action | delete is restricted on course_section table
                                        and no action on student table.
*/
CREATE TABLE `enrollment` (
    `enr_id` INTEGER PRIMARY KEY AUTO_INCREMENT,
    `s_id` INTEGER NOT NULL,
    `c_sec_id` INTEGER NOT NULL,
    `grade` VARCHAR(1),
    FOREIGN KEY (`s_id`)
        REFERENCES student (`s_id`)
        ON UPDATE CASCADE 
        ON DELETE NO ACTION,
    FOREIGN KEY (`c_sec_id`)
        REFERENCES course_section (`c_sec_id`)
        ON UPDATE CASCADE 
        ON DELETE RESTRICT
);