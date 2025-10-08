-- Create database (run this separately if needed)
-- CREATE DATABASE hospice_db;

-- Connect to the database
-- \c hospice_db;

-- Create submissions table
CREATE TABLE IF NOT EXISTS submissions (
  id SERIAL PRIMARY KEY,
  care_recipient TEXT,
  main_concern TEXT,
  medical_situation TEXT,
  current_care_location TEXT,
  urgency_level TEXT,
  first_name TEXT,
  phone TEXT,
  email TEXT,
  best_time TEXT,
  care_preference TEXT,
  insurance_coverage TEXT,
  special_requests TEXT,
  terms_consent BOOLEAN,
  submitted_at TIMESTAMP DEFAULT NOW()
);

-- Create index on submitted_at for faster queries
CREATE INDEX IF NOT EXISTS idx_submitted_at ON submissions(submitted_at);
