drop table if exists courses CASCADE;
create table courses (
	id serial primary key,
	name text,
	created timestamp,
	description text
);

drop table if exists lessons CASCADE;
create table lessons (
	id serial primary key,
	name text,
	course_id int references courses on delete cascade,
	created timestamp,
	description text
);

drop table if exists exercise_types CASCADE;
create table exercise_types (
	id serial,
	name text,
	value text primary key
);

drop table if exists exercises CASCADE;
create table exercises (
	id serial primary key,
	name text,
	lesson_id int references lessons on delete cascade,
	type text references exercise_types on delete cascade,
	created timestamp,
	description text
);

drop table if exists exercise_sources CASCADE;
create table exercise_sources (
	id serial primary key,
	filename text,
	code text,
	exercise_id int references exercises on delete cascade
);

drop table if exists exercise_tests CASCADE;
create table exercise_tests (
	id serial primary key,
	filename text,
	code text,
	exercise_id int references exercises on delete cascade
);

drop table if exists solutions cascade;
create table solutions (
	id serial primary key,
	exercise_id int references exercises on delete cascade
);

drop table if exists solution_sources cascade;
create table solution_sources (
	id serial primary key,
	solution_id int references solutions on delete cascade,
	filename text,
	code text
);

drop table if exists solution_tests cascade;
create table solution_tests (
	id serial primary key,
	solution_id int references solutions on delete cascade,
	filename text,
	code text
);

drop table if exists solution_estimations cascade;
create table solution_estimations (
	id serial primary key,
	solution_id int references solutions on delete cascade,
	estimation text
);