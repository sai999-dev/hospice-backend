# Hospice Backend

This is the backend server for the hospice form submission application.

## Setup

1. Install PostgreSQL and create a database named `hospice_db`
2. Update the `.env` file with your database credentials
3. Run `npm install` to install dependencies
4. Run the SQL script in `init.sql` to create the database table
5. Run `npm start` to start the server

## Email Notifications (Gmail)

To send an email with the full submission details to a specific address after each submission, configure Gmail SMTP via environment variables (recommended: use a Gmail App Password):

Add the following to your `.env`:

```
# Server
PORT=5000

# Database
DB_HOST=localhost
DB_PORT=5432
DB_NAME=hospice_db
DB_USER=postgres
DB_PASSWORD=your_db_password

# Email (Gmail SMTP)
GMAIL_USER=yourgmail@gmail.com
GMAIL_PASS=your_app_password   # Use Gmail App Password
GMAIL_FROM=HospiceConnect <yourgmail@gmail.com>
NOTIFY_EMAIL=recipient@example.com  # Where to send submissions
```

Notes:
- Use a Google Account with 2FA and create an App Password for `GMAIL_PASS`.
- `NOTIFY_EMAIL` should be the destination mailbox for submissions.
- If email variables are not set, the API will still save to DB but log an email error.

## API Endpoints

- POST /api/submissions: Save a new form submission
- GET /api/admin/submissions: Get all submissions (for admin panel)
