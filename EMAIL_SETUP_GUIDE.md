# Email Configuration Guide

Your landing page already has email functionality built-in! Follow these steps to configure it:

## Step 1: Create a `.env` file

In the `backend` folder, create a file named `.env` with the following content:

```env
# Database Configuration
DB_HOST=localhost
DB_PORT=5432
DB_NAME=hospice_db
DB_USER=your_db_user
DB_PASSWORD=your_db_password

# Server Configuration
PORT=5001

# Gmail SMTP Configuration (for sending emails)
GMAIL_USER=your-email@gmail.com
GMAIL_PASS=your-app-password-here
GMAIL_FROM=your-email@gmail.com

# Email Recipient (where form submissions will be sent)
NOTIFY_EMAIL=recipient@example.com
```

## Step 2: Get a Gmail App Password

1. Go to your Google Account: https://myaccount.google.com/
2. Click on "Security" in the left sidebar
3. Enable "2-Step Verification" if not already enabled
4. After enabling 2FA, go back to Security settings
5. Search for "App passwords" or visit: https://myaccount.google.com/apppasswords
6. Select "Mail" and "Other (Custom name)" - name it "HospiceConnect"
7. Click "Generate"
8. Copy the 16-character password (it will look like: `abcd efgh ijkl mnop`)

## Step 3: Update your `.env` file

Replace the placeholders in your `.env` file:

```env
# Example configuration:
GMAIL_USER=youremail@gmail.com
GMAIL_PASS=abcdefghijklmnop  # (remove spaces from the app password)
GMAIL_FROM=youremail@gmail.com
NOTIFY_EMAIL=recipient@example.com  # The email address that will receive form submissions
```

## Step 4: Restart your backend server

```bash
cd backend
npm start
```

## How it works

When a user submits the form at Step 4, the backend will:

1. ✅ Save the submission to the PostgreSQL database
2. ✅ Send an email notification to the address specified in `NOTIFY_EMAIL`
3. ✅ The email will contain all form details including:
   - Care recipient information
   - Medical situation
   - Contact details (name, phone, email)
   - Urgency level
   - Care preferences
   - Special requests

## Testing the email

You can test if email is working by visiting:
```
http://localhost:5001/api/debug/email
```

This will send a test email to verify your SMTP configuration.

## Troubleshooting

**Issue**: "Email transporter not configured"
- **Solution**: Make sure `GMAIL_USER` and `GMAIL_PASS` are set in `.env`

**Issue**: "SMTP verification failed"
- **Solution**: 
  - Ensure 2-Factor Authentication is enabled on your Google account
  - Use an App Password, not your regular Gmail password
  - Remove any spaces from the App Password

**Issue**: "No recipient configured"
- **Solution**: Set either `NOTIFY_EMAIL` or `RECIPIENT_EMAIL` in `.env`

## Email Preview

The email will look like this:

```
Subject: New HospiceConnect submission #123

New submission received (ID: 123)

Situation:
- Care recipient: [value]
- Main concern: [value]
- Medical situation: [value]
- Current care location: [value]
- Urgency level: [value]

Contact:
- First name: [value]
- Phone: [value]
- Email: [value]
- Best time to call: [value]

Preferences:
- Care preference: [value]
- Insurance coverage: [value]
- Special requests: [value]
- Agreed to terms: Yes
```

## Security Notes

⚠️ **Important**: Never commit your `.env` file to Git!
- The `.env` file should already be in `.gitignore`
- Only commit `.env.example` as a template for others

