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

# SendGrid Email Configuration (works on Render - no SMTP blocking!)
SENDGRID_API_KEY=your-sendgrid-api-key-here
SENDGRID_FROM_EMAIL=noreply@yourdomain.com

# Email Recipient (where form submissions will be sent)
NOTIFY_EMAIL=recipient@example.com
```

## Step 2: Get a SendGrid API Key (FREE - 100 emails/day)

SendGrid uses HTTP/HTTPS instead of SMTP, so it works perfectly on Render and other cloud platforms!

1. Go to SendGrid: https://signup.sendgrid.com/
2. Sign up for a FREE account (no credit card required for 100 emails/day)
3. Verify your email address
4. Once logged in, go to: **Settings → API Keys** (https://app.sendgrid.com/settings/api_keys)
5. Click "Create API Key"
6. Name it "HospiceConnect Backend"
7. Select "Full Access" (or at least "Mail Send" access)
8. Click "Create & View"
9. **IMPORTANT**: Copy the API key immediately (you won't be able to see it again!)
   - It will look like: `SG.xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx`

## Step 3: Verify a Sender Email

SendGrid requires you to verify the email address you'll send FROM:

### Option A: Single Sender Verification (Easiest - FREE)
1. Go to: **Settings → Sender Authentication → Single Sender Verification**
2. Click "Create New Sender"
3. Fill in your details (use your real email, e.g., `yourname@gmail.com`)
4. Check your email and click the verification link
5. Use this verified email as `SENDGRID_FROM_EMAIL` in your `.env`

### Option B: Domain Authentication (Better for production)
1. If you own a domain, you can authenticate your entire domain
2. Go to: **Settings → Sender Authentication → Domain Authentication**
3. Follow the DNS setup instructions

## Step 4: Update your `.env` file

Replace the placeholders in your `.env` file:

```env
# Example configuration:
SENDGRID_API_KEY=SG.xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
SENDGRID_FROM_EMAIL=yourname@gmail.com  # Must be verified in SendGrid
NOTIFY_EMAIL=recipient@example.com  # The email address that will receive form submissions
```

## Step 5: Install dependencies and restart

```bash
npm install
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
http://localhost:4001/api/debug/email
```

This will send a test email to verify your SendGrid configuration.

## Troubleshooting

**Issue**: "Email service not configured"
- **Solution**: Make sure `SENDGRID_API_KEY` is set in `.env`

**Issue**: "No sender email configured"
- **Solution**: Set `SENDGRID_FROM_EMAIL` in `.env` with a verified email address

**Issue**: "No recipient configured"
- **Solution**: Set `NOTIFY_EMAIL` or `RECIPIENT_EMAIL` in `.env`

**Issue**: "The from address does not match a verified Sender Identity"
- **Solution**: 
  - Go to SendGrid → Settings → Sender Authentication
  - Verify the email address you're using as `SENDGRID_FROM_EMAIL`
  - Wait for the verification email and click the link

**Issue**: "Forbidden" or authentication error
- **Solution**: 
  - Check that your API key is correct
  - Make sure the API key has "Mail Send" permission
  - Regenerate a new API key if needed

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

## Deploying to Render

When deploying to Render, add these environment variables in your Render dashboard:

1. Go to your Render service → **Environment**
2. Add the following environment variables:
   ```
   SENDGRID_API_KEY=SG.xxxxxxxxxx...
   SENDGRID_FROM_EMAIL=yourname@gmail.com
   NOTIFY_EMAIL=recipient@example.com
   DATABASE_URL=postgresql://... (Render provides this automatically)
   ```
3. Click "Save Changes"
4. Your service will automatically redeploy

## Why SendGrid instead of Gmail SMTP?

**Render blocks SMTP connections** (ports 465, 587) for security reasons, causing connection timeouts with Gmail SMTP. SendGrid uses HTTP/HTTPS (port 443) which works perfectly on Render and other cloud platforms.

**Benefits of SendGrid:**
- ✅ Works on Render, Heroku, Vercel, etc.
- ✅ No SMTP port blocking issues
- ✅ Free tier: 100 emails/day
- ✅ Better deliverability
- ✅ Email tracking and analytics

## Security Notes

⚠️ **Important**: Never commit your `.env` file to Git!
- The `.env` file should already be in `.gitignore`
- Only commit `.env.example` as a template for others
- Keep your SendGrid API key secret!

