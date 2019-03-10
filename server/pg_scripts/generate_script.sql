truncate table
	courses,
	lessons,
	exercise_types,
	exercises
restart identity cascade;

INSERT INTO courses (id, name, created, description)
VALUES (1, 'Course One', '2019-03-09 20:53:09.851', 'Course description');

INSERT INTO lessons (id, name, course_id, created, description)
VALUES	(1, 'Lesson one', 1, '2019-03-09 20:53:09.851', 'Lesson description'),
		(2, 'Lesson two', 1, '2019-03-09 20:53:09.851', 'Lesson description');

INSERT INTO exercise_types (id, name, value)
VALUES	(1, 'Black box', 'black-box'),
		(2, 'Multiple Choice Quiz', 'quiz'),
		(3, 'Interactive Lesson', 'white-box'),
		(4, 'Theory', 'theory'),
		(5, 'Self-Evaluation', 'self-eval');

INSERT INTO exercises (id, name, lesson_id, type, created, description)
VALUES	(1, 'Exercise one', 1, 'white-box', '2019-03-09 20:53:09.851', 'Exercise one description'),
		(2, 'Exercise two', 1, 'black-box', '2019-03-09 20:53:09.851', 'Exercise two description'),
		(3, 'Exercise three', 1, 'quiz', '2019-03-09 20:53:09.851', 'Exercise three description');

