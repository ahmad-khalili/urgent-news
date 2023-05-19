-- Create the database
CREATE DATABASE IF NOT EXISTS UrgentNews;

USE UrgentNews;

-- Create the News table
CREATE TABLE IF NOT EXISTS News (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  content TEXT NOT NULL
);

-- Insert 20 records into the News table
INSERT INTO News (title, content)
VALUES
  ('Title 1', 'Content 1'),
  ('Title 2', 'Content 2'),
  ('Title 3', 'Content 3'),
  ('Title 4', 'Content 4'),
  ('Title 5', 'Content 5'),
  ('Title 6', 'Content 6'),
  ('Title 7', 'Content 7'),
  ('Title 8', 'Content 8'),
  ('Title 9', 'Content 9'),
  ('Title 10', 'Content 10'),
  ('Title 11', 'Content 11'),
  ('Title 12', 'Content 12'),
  ('Title 13', 'Content 13'),
  ('Title 14', 'Content 14'),
  ('Title 15', 'Content 15'),
  ('Title 16', 'Content 16'),
  ('Title 17', 'Content 17'),
  ('Title 18', 'Content 18'),
  ('Title 19', 'Content 19'),
  ('Title 20', 'Content 20');
