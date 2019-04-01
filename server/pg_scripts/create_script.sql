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

drop table if exists exercise_configs cascade;
create table exercise_configs (
    id serial primary key,
    filename text,
    text text,
    exercise_id int references exercises on delete cascade
);

drop table if exists exercise_controllers cascade;
create table exercise_controllers (
    id serial primary key,
    filename text,
    code text,
	exercise_id int references exercises on delete cascade
    -- TODO unique constraint
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
	code text,
    solution_id int references solutions on delete cascade
);

drop table if exists solution_tests cascade;
create table solution_tests (
	id serial primary key,
	filename text,
	code text,
    solution_id int references solutions on delete cascade
);

drop table if exists solution_configs cascade;
create table solution_configs (
    id serial primary key,
    filename text,
    text text,
    solution_id int references solutions on delete cascade
);

drop table if exists solution_estimations cascade;
create table solution_estimations (
	id serial primary key,
	estimation text,
    solution_id int references solutions on delete cascade
);