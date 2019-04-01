drop table if exists courses CASCADE;
create table courses (
	id serial primary key,
	name text,
    description text,
	created timestamp
);

drop table if exists lessons CASCADE;
create table lessons (
	id serial primary key,
	name text,
    description text,
    created timestamp,
	course_id int references courses on delete cascade
);

drop table if exists exercise_types CASCADE;
create table exercise_types (
	id serial primary key,
	name text,
	value text,
	constraint unique_value unique (value)
);

drop table if exists exercises CASCADE;
create table exercises (
	id serial primary key,
	name text,
    description text,
	index int,
    created timestamp,
    type_id int references exercise_types on delete cascade,
	lesson_id int references lessons on delete cascade,
	constraint unique_index_lesson_id unique (index, lesson_id)
);

drop table if exists exercise_content cascade;
create table exercise_content (
    id serial primary key,
    filename text,
    content text,
    exercise_id int references exercises on delete cascade,
    content_type text
);

drop table if exists solutions cascade;
create table solutions (
	id serial primary key,
    created timestamp,
	exercise_id int references exercises on delete cascade
);

drop table if exists solution_sources cascade;
create table solution_sources (
	id serial primary key,
    filename text,
	content text,
    solution_id int references solutions on delete cascade
);

drop table if exists solution_tests cascade;
create table solution_tests (
	id serial primary key,
	filename text,
	content text,
    solution_id int references solutions on delete cascade
);

drop table if exists solution_files cascade;
create table solution_files (
    id serial primary key,
    filename text,
	content text,
    solution_id int references solutions on delete cascade
);

drop table if exists solution_estimations cascade;
create table solution_estimations (
	id serial primary key,
	estimation text,
    solution_id int references solutions on delete cascade
);