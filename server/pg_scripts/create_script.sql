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
	load_solution_sources int,
	load_solution_tests int,
    load_solution_files int
-- 	constraint unique_index_lesson_id unique (index, lesson_id)
);

alter table exercises alter column load_solution_sources set default -1;
alter table exercises alter column load_solution_tests set default -1;
alter table exercises alter column load_solution_files set default -1;

drop table if exists exercise_content cascade;
create table exercise_content (
    id serial primary key,
    filename text,
    content text,
    exercise_id int references exercises on delete cascade,
    exercise_content_type text
);

drop table if exists bugs_number cascade;
create table bugs_number (
    id serial primary key,
    exercise_id int references exercises on delete cascade,
    number int
);

drop table if exists solutions cascade;
create table solutions (
	id serial primary key,
    created timestamp,
	exercise_id int references exercises on delete cascade
);

drop table if exists solution_content cascade;
create table solution_content (
    id serial primary key,
    filename text,
    content text,
    solution_id int references solutions on delete cascade,
    solution_content_type text
);

drop table if exists solution_estimations cascade;
create table solution_estimations (
	id serial primary key,
	estimation text,
    solution_id int references solutions on delete cascade
);