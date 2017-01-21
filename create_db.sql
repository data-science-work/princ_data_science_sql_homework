CREATE DATABASE IF NOT EXISTS lipscomb;

USE lipscomb;

CREATE TABLE `course` (
    `course_id` INTEGER PRIMARY KEY AUTO_INCREMENT,
    `course_no` VARCHAR(10) NOT NULL,
    `course_name` VARCHAR(50) NOT NULL,
    `credits` TINYINT NOT NULL
);

CREATE TABLE `location` (
    `loc_id` INTEGER PRIMARY KEY AUTO_INCREMENT,
    `bldg_code` VARCHAR(10) NOT NULL,
    `room` VARCHAR(5) NOT NULL,
    `capacity` TINYINT NOT NULL
);

CREATE TABLE `faculty` (
    `f_id` INTEGER PRIMARY KEY AUTO_INCREMENT,
    `f_last` VARCHAR(50) NOT NULL,
    `f_first` VARCHAR(50) NOT NULL,
    `f_mi` VARCHAR(1) NOT NULL,
    `f_phone` VARCHAR(15) NOT NULL,
    `f_rank` VARCHAR(30) NOT NULL,
    `f_super` TINYINT,
    `f_pin` VARCHAR(4) NOT NULL,
    `loc_id` INTEGER,
    FOREIGN KEY (`loc_id`)
        REFERENCES location (`loc_id`)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

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
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE `term` (
    `term_id` INTEGER PRIMARY KEY AUTO_INCREMENT,
    `term_desc` VARCHAR(10) NOT NULL,
    `term_desc_year` YEAR NOT NULL,
    `status` VARCHAR(6) NOT NULL,
    `start_date` DATE NOT NULL
);

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
    `max_enrl` TINYINT,
    FOREIGN KEY (`course_id`)
        REFERENCES course (`course_id`)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (`term_id`)
        REFERENCES term (`term_id`)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (`f_id`)
        REFERENCES faculty (`f_id`)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (`loc_id`)
        REFERENCES location (`loc_id`)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE `enrollment` (
    `enr_id` INTEGER PRIMARY KEY AUTO_INCREMENT,
    `s_id` INTEGER NOT NULL,
    `c_sec_id` INTEGER NOT NULL,
    `grade` VARCHAR(1),
    FOREIGN KEY (`s_id`)
        REFERENCES student (`s_id`)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (`c_sec_id`)
        REFERENCES course_section (`c_sec_id`)
        ON UPDATE CASCADE ON DELETE RESTRICT
);