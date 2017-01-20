\c jonathonlaylo;

DROP USER "michael";
CREATE USER "michael" WITH password 'stonebreak';
DROP DATABASE IF EXISTS "todo_app";
CREATE DATABASE "todo_app";
\c "todo_app";

CREATE TABLE "tasks" (id serial NOT NULL,
  title varchar(255),
  description text,
  created_at timestamp WITHOUT TIME ZONE NOT NULL default NOW(),
  updated_at timestamp,
  completed boolean default false
);

-- i. remove the column named completed
ALTER TABLE tasks
  DROP COLUMN completed;

-- ii. add a column to tasks named completed_at:timestamp, that may be NULL, and has a default value of NULL.
ALTER TABLE tasks
  ADD COLUMN completed_at timestamp NULL default NULL;

-- iii. change the updated_at column to not allow NULL values, and have a default value of now()
ALTER TABLE tasks
  ALTER COLUMN updated_at SET NOT NULL;
ALTER TABLE tasks
  ALTER COLUMN updated_at SET default NOW();

-- iv. create a new task, by only setting values (not defining which columns) id = default value
INSERT INTO tasks (title, description, created_at, updated_at, completed_at) VALUES(
  'Study SQL',
  'Compete this exercise',
  now(),
  now(),
  NULL
);

-- v. create a new task
INSERT INTO tasks (title, description) VALUES(
  'Study PostgreSQL',
  'Read all the documentation'
);

-- vi. select all the titles of tasks that are not yet completed
SELECT * FROM tasks
  WHERE completed_at is NULL;

-- vii. update the task with a title of 'Study SQL' to be completed as of now
UPDATE tasks
  SET completed_at = NOW()
  WHERE title = 'Study SQL';

-- viii. select all titles and descriptions of tasks that are not yet completed
SELECT * FROM tasks
  WHERE completed_at is NULL;

-- ix. select all fields of every task sorted by creation date in descending order
SELECT * FROM tasks
  ORDER BY created_at DESC;

-- x. create a new task
INSERT INTO tasks (title, description) VALUES(
  'mistake 1',
  'a test entry'
);

-- xi. create a new task
INSERT into tasks (title, description) VALUES(
  'mistake 2',
  'another test entry'
);

-- xii. create a new task
INSERT into tasks (title, description) VALUES(
  'third mistake',
  'another test entry'
);

-- xiii. select title fields of all tasks with a title that includes the word 'mistake'
SELECT title FROM tasks
  WHERE title LIKE '%mistake%';

-- xiv. delete the task that has a title of mistake 1
DELETE FROM tasks
  WHERE title LIKE 'mistake 1';

-- xv. select title and description fields of all tasks with a title that includes the word 'mistake'
SELECT title FROM tasks
  WHERE title LIKE '%mistake%';

-- xvi. delete all tasks that includes the word 'mistake' in the title
DELETE FROM tasks
  WHERE title like '%mistake%';

-- xvii. select all fields of all tasks sorted by title in ascending order
SELECT * FROM tasks
  ORDER BY title ASC;
-- \d+ "tasks";