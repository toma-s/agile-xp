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

drop table if exists source_codes CASCADE;
create table source_codes (
	id serial primary key,
	filename text,
	code text,
	exercise_id int references exercises on delete cascade
);

drop table if exists hidden_tests CASCADE;
create table hidden_tests (
	id serial primary key,
	filename text,
	code text,
	exercise_id int references exercises on delete cascade
);


