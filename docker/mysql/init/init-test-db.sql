-- Create the testing database
CREATE DATABASE IF NOT EXISTS testing_db;

-- Grant permissions to the user. The user should match the .env user.
GRANT ALL ON testing_db.* TO 'laravel'@'%';
