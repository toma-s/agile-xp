truncate table
    courses,
    lessons,
    exercise_types,
    exercises,
    exercise_content
restart identity cascade;

INSERT INTO exercise_types (id, name, value)
VALUES (1, 'Interactive Exercise', 'source-test'),
       (2, 'Interactive Exercise with Files', 'source-test-file'),
       (3, 'Black Box', 'test'),
       (4, 'Black Box with Files', 'test-file'),
       (5, 'Theory', 'theory');
