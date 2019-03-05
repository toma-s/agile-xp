truncate table
	exercise_types
restart identity cascade;


INSERT INTO exercise_types (name)
VALUES (''Black box''), (''Multiple Choise Quiz''), (''Interactive Lesson'');