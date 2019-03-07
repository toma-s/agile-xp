truncate table
	exercise_types
restart identity cascade;

INSERT INTO exercise_types (name, value)
VALUES ('Black box', 'black-box'), ('Multiple Choice Quiz', 'quiz'), ('Interactive Lesson', 'white-box'),
('Theory', 'theory'), ('Self-Evaluation', 'self-eval');
