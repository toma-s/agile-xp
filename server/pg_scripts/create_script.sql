drop table if exists courses;
create table courses (
	id serial primary key,
	name text,
	created timestamp
);

drop table if exists exercises;
create table exercises (
	id serial primary key,
	name text,
	course_id int references courses on delete cascade,
	created timestamp
);

drop table if exists source_codes;
create table source_codes (
	id serial primary key,
	filename text,
	exercise_id int references exercises on delete cascade
);

drop table if exists hidden_tests;
create table hidden_tests (
	id serial primary key,
	filename text,
	exercise_id int references exercises on delete cascade
);
