--1. Создать таблицу с факультетами: id, имя факультета, стоимость обучения
--2. Создать таблицу с курсами: id, номер курса, id факультета
--3. Создать таблицу с учениками: id, имя, фамилия, отчество, бюджетник/частник, id курса

CREATE TABLE faculty (id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY, 
					  "name" varchar (100), 
					  price numeric);
CREATE TABLE course (id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY, 
					  number int, 
					  id_faculty int REFERENCES faculty(id));
CREATE TABLE student (id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY, 
					  student_name varchar (50), 
					  student_surname varchar (50), 
					  student_second_name char (50), 
					  budget boolean, 
					  id_course int REFERENCES course (id));
					  
--Часть 2. Заполнение данными:
--1. Создать два факультета: Инженерный (30 000 за курс) , Экономический (49 000 за курс)

INSERT INTO faculty ("name", price) values('Инженерный', 30000);
INSERT INTO faculty ("name", price) values('Экономический', 49000);

--2. Создать 1 курс на Инженерном факультете: 1 курс
--3. Создать 2 курса на экономическом факультете: 1, 4 курс

INSERT INTO course (number, id_faculty) values(1, 1);
INSERT INTO course (number, id_faculty) values(1, 2);
INSERT INTO course (number, id_faculty) values(4, 2);

--4. Создать 5 учеников:
--Петров Петр Петрович, 1 курс инженерного факультета, бюджетник
--Иванов Иван Иваныч, 1 курс инженерного факультета, частник
--Михно Сергей Иваныч, 4 курс экономического факультета, бюджетник
--Стоцкая Ирина Юрьевна, 4 курс экономического факультета, частник
--Младич Настасья (без отчества), 1 курс экономического факультета, частник

INSERT INTO student (student_surname, student_name, student_second_name, budget, id_course) 
VALUES('Петров', 'Петр', 'Петрович', true, 1);

INSERT INTO student (student_surname, student_name, student_second_name, budget, id_course)
VALUES('Иванов', 'Иван', 'Иваныч', false, 1);

INSERT INTO student (student_surname, student_name, student_second_name, budget, id_course)
VALUES('Михно', 'Сергей', 'Иваныч', true, 3);

INSERT INTO student (student_surname, student_name, student_second_name, budget, id_course)
VALUES('Стоцкая', 'Ирина', 'Юрьевна', false, 3);

INSERT INTO student (student_surname, student_name, student_second_name, budget, id_course)
VALUES('Младич', 'Настасья', null, false, 2);

-- Часть 3. Выборка данных. Необходимо написать запросы, которые выведут на экран:
-- 1. Вывести всех студентов, кто платит больше 30_000.

SELECT student.student_name, student.student_surname, student.student_second_name, student.id_course, faculty.price
FROM student
join course on student.id_course = course.id
join faculty on course.id_faculty = faculty.id
WHERE faculty.price > 30000;

-- 2. Перевести всех студентов Петровых на 1 курс экономического факультета.

UPDATE student SET id_course = 2 WHERE student_surname = 'Петров';
select * from student;

-- 3. Вывести всех студентов без отчества или фамилии.

SELECT * 
FROM student
WHERE student_surname ISNULL OR student_second_name ISNULL;

-- 4. Вывести всех студентов содержащих в фамилии или в имени или в отчестве "ван". (пример name like '%Петр%' - найдет всех Петров, Петровичей, Петровых)

SELECT * FROM student
WHERE student_surname LIKE 'ван' OR student_name LIKE 'ван' OR student_second_name LIKE '%ван%';

-- 5. Удалить все записи из всех таблиц.

DELETE FROM student;
DELETE FROM course;
DELETE FROM faculty;

