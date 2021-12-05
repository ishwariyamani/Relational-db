CREATE TABLE candidates (
                            inscription_id character varying(15) NOT NULL,
                            candidate_name character varying(15) NOT NULL,
                            email_address character varying(20) NOT NULL,
                            payment_id character varying(15)
);

CREATE TABLE students (
                        student_id smallint NOT NULL,
                        student_name character varying(15) NOT NULL,
						program_id character varying(15) NOT NULL,
						group_id character varying(15) NOT NULL,
						inscription_id character varying(15) NOT NULL
);

CREATE TABLE intakes (
                        student_id smallint NOT NULL,
                        type_of_intake character varying(15) NOT NULL,
						year_of_intake character varying(5) NOT NULL
);

CREATE TABLE programs (
                        program_id character varying(15) NOT NULL,
                        program_name character varying(30) NOT NULL,
						program_duration smallint NOT NULL
);

CREATE TABLE courses (
                        course_id character varying(10) NOT NULL,
                        course_name character varying(30) NOT NULL,
						course_duration real NOT NULL,
						program_id character varying(15) NOT NULL
);

CREATE TABLE exams (
						student_id smallint NOT NULL,
						course_id character varying(10) NOT NULL,
						type_of_exam character varying(15) NOT NULL,
                        weight real NOT NULL,
						grade character varying(10) NOT NULL
);

CREATE TABLE groups (
                        group_id character varying(15) NOT NULL,
                        number_of_students smallint NOT NULL
);

CREATE TABLE teachers (
                        email_teacher character varying(15) NOT NULL,
                        teacher_name character varying(30) NOT NULL,
						type_of_teacher character varying(10) NOT NULL,
						bank_account character varying(50) NOT NULL,
						contact_details character varying(15) NOT NULL
);

CREATE TABLE payment_to_admin (
								payment_id character varying(15) NOT NULL,
								payment_amount real,
								pay_date_time timestamp
);

CREATE TABLE payment_from_admin (
									payment_id character varying(15) NOT NULL,
									email_teacher character varying(15) NOT NULL,
									payment_amount real,
									pay_date_time timestamp
);

CREATE TABLE sessions (
						session_id smallint NOT NULL,
						type_of_session character varying(15) NOT NULL,
						start_date_time timestamp NOT NULL,
						end_date_time timestamp NOT NULL,
						group_id character varying(15) NOT NULL,
						course_id character varying(10) NOT NULL,
						email_teacher character varying(15) NOT NULL			
);

CREATE TABLE attendance (
							session_id smallint NOT NULL,
							student_id smallint NOT NULL,
							present_missing character varying(10) NOT NULL
);

CREATE TABLE rooms (
						room_id  character varying(10)NOT NULL,
						session_id smallint NOT NULL
);

CREATE TABLE admin (
						admin_name character varying(15) NOT NULL,
						username character varying(15) NOT NULL,
						password character varying(15) NOT NULL
);


CREATE TABLE courses_teachers (
								email_teacher character varying(15) NOT NULL,
								course_id character varying(10) NOT NULL
);

CREATE TABLE courses_programs (
								program_id character varying(15) NOT NULL,
								course_id character varying(10) NOT NULL
);


ALTER TABLE ONLY payment_to_admin
    ADD CONSTRAINT pk_payment_to_admin PRIMARY KEY (payment_id);
	
ALTER TABLE ONLY candidates
    ADD CONSTRAINT pk_candidates PRIMARY KEY (inscription_id);

ALTER TABLE ONLY students
    ADD CONSTRAINT pk_students PRIMARY KEY (student_id);
	
ALTER TABLE ONLY programs
    ADD CONSTRAINT pk_programs PRIMARY KEY (program_id);
	
ALTER TABLE ONLY courses
    ADD CONSTRAINT pk_courses PRIMARY KEY (course_id);
	
ALTER TABLE ONLY groups
    ADD CONSTRAINT pk_groups PRIMARY KEY (group_id);
	
ALTER TABLE ONLY teachers
    ADD CONSTRAINT pk_teachers PRIMARY KEY (email_teacher);
	
ALTER TABLE ONLY sessions
    ADD CONSTRAINT pk_sessions PRIMARY KEY (session_id);
	
----- Altering Tables for foreign Keys
	
ALTER TABLE ONLY candidates
    ADD CONSTRAINT fk_candidates_payment_id FOREIGN KEY (payment_id) REFERENCES payment_to_admin;
	
ALTER TABLE ONLY students
    ADD CONSTRAINT fk_students_program_id FOREIGN KEY (program_id) REFERENCES programs;

ALTER TABLE ONLY students
    ADD CONSTRAINT fk_students_group_id FOREIGN KEY (group_id) REFERENCES groups;

ALTER TABLE ONLY students
    ADD CONSTRAINT fk_students_inscription_id FOREIGN KEY (inscription_id) REFERENCES candidates;

ALTER TABLE ONLY exams
    ADD CONSTRAINT fk_exams_student_id FOREIGN KEY (student_id) REFERENCES students;
	
ALTER TABLE ONLY exams
    ADD CONSTRAINT fk_exams_course_id FOREIGN KEY (course_id) REFERENCES courses;
	
ALTER TABLE ONLY courses
    ADD CONSTRAINT fk_courses_program_id FOREIGN KEY (program_id) REFERENCES programs;
	
ALTER TABLE ONLY intakes
    ADD CONSTRAINT fk_intakes_student_id FOREIGN KEY (student_id) REFERENCES students;

ALTER TABLE ONLY payment_from_admin
    ADD CONSTRAINT fk_payment_from_admin_email_teacher FOREIGN KEY (email_teacher) REFERENCES teachers;
	
ALTER TABLE ONLY rooms
    ADD CONSTRAINT fk_rooms_session_id FOREIGN KEY (session_id) REFERENCES sessions;
	
ALTER TABLE ONLY sessions
    ADD CONSTRAINT fk_sessions_group_id FOREIGN KEY (group_id) REFERENCES groups;
	
ALTER TABLE ONLY sessions
    ADD CONSTRAINT fk_sessions_course_id FOREIGN KEY (course_id) REFERENCES courses;

ALTER TABLE ONLY sessions
    ADD CONSTRAINT fk_sessions_email_teacher FOREIGN KEY (email_teacher) REFERENCES teachers;

ALTER TABLE ONLY attendance
    ADD CONSTRAINT fk_attendance_session_id FOREIGN KEY (session_id) REFERENCES sessions;

ALTER TABLE ONLY attendance
    ADD CONSTRAINT fk_attendance_student_id FOREIGN KEY (student_id) REFERENCES students;
    
   
   
INSERT INTO payment_to_admin VALUES ('EPI12345678',6000.0,'2021-12-08 14:00:50');
INSERT INTO payment_to_admin VALUES ('EPI13345678',6500.0,'2021-11-08 11:30:00');
INSERT INTO payment_to_admin VALUES ('EPI12545678',7000.0,'2021-10-08 11:30:05');

INSERT INTO candidates VALUES ('Alice','alice@xyz','IM21F1234','EPI12345678');
INSERT INTO candidates VALUES ('Bob','bob@xyz','IM21F1334','EPI13345678');
INSERT INTO candidates VALUES ('sam','sam@xyz','IM21F1434','EPI12545678');

INSERT INTO students VALUES (2700,'Alice','CS123','G1','IM21F1234');
INSERT INTO students VALUES (2701,'BOB','DS123','G2','IM21F1244');
INSERT INTO students VALUES (2702,'SAM','AI123','G3','IM21F1434');

INSERT INTO exams VALUES (2700,'PMP01','quiz',2.0,'A+');
INSERT INTO exams VALUES (2701,'CMP02','project',1.0,'A');
INSERT INTO exams VALUES (2703,'ALG1','paper',5.0,'B');

INSERT INTO courses VALUES ('PMP01','computer security',20.0,'CS123');
INSERT INTO courses VALUES ('CMP02','Data Science',15.0,'DS123');
INSERT INTO courses VALUES ('ALG1','Artificial Intelligence',25.0,'CS123');

INSERT INTO programs VALUES ('CS123','computer security',18.0);
INSERT INTO programs VALUES ('DS123','data science',18.0);
INSERT INTO programs VALUES ('AI123','artificial intelligence',24.0);

INSERT INTO intakes VALUES (2700,'spring','2021');
INSERT INTO intakes VALUES (2701,'fall','2021');
INSERT INTO intakes VALUES (2702,'spring','2020');

INSERT INTO groups VALUES ('G1',5);
INSERT INTO groups VALUES ('G2',4);
INSERT INTO groups VALUES ('G3',10);

INSERT INTO teachers VALUES ('oliver@xyz','oliver', 'internal', '123455667-BNP', '919191919');
INSERT INTO teachers VALUES ('perth@xyz','perth', 'external', '1673455667-SG', '9161891919');
INSERT INTO teachers VALUES ('tom@xyz','tom', 'internal', '623456667-HSBC', '919167919');

INSERT INTO payment_from_admin VALUES ('F1234568','oliver@xyz', 3000.0, '2021-12-07 12:07:00');
INSERT INTO payment_from_admin VALUES ('G1234568','perth@xyz', 2000.0, '2020-12-07 16:40:00');
INSERT INTO payment_from_admin VALUES ('H1234568','tom@xyz', 3500.0,'2021-09-07 17:40:06');

INSERT INTO rooms VALUES ('601',P1);
INSERT INTO rooms VALUES ('online',DT1);
INSERT INTO rooms VALUES ('605',AL3);

INSERT INTO sessions VALUES ('P1','LABS', '2021-10-05 14:00:00', '2020-10-05 16:00:00', 'G1','PMP01','oliver@xyz');
INSERT INTO sessions VALUES ('AL3','exams', '2021-10-06 10:00:00', '2021-10-06 13:00:00', 'G2','ALG1','perth@xyz');
INSERT INTO sessions VALUES ('DT1','project', '2021-10-07 09:00:00', '2021-10-07 12:00:00', 'G3','CMP02','tom@xyz');

INSERT INTO attendance VALUES ('P1',2700,'present');
INSERT INTO attendance VALUES ('AL3',2701,'missing');
INSERT INTO attendance VALUES ('DT1',2703,'present');

INSERT INTO admin VALUES ('thomas','thomas@xyz','123#$%%');
INSERT INTO admin VALUES ('maride','maride@xyz','6789#$%%');
INSERT INTO admin VALUES ('srinath','srinath@xyz','srinathisgreat!@');