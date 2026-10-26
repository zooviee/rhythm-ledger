# Rhythm Ledger

A private, hour-by-hour daily tracker. Log 24 hours a day, see a daily summary with average ratings, and a dashboard of when you're most productive and what you spend time on. Each month is archived automatically and a fresh month starts.

- **Website:** hosted free on GitHub Pages.
- **Data:** stored in your own Supabase database, behind your login. This repository only holds the website's code. None of your entries are stored here.
- **Works offline:** every edit is saved on the device first and syncs when you're back online.
- **Install on your phone:** open the site, then *Share → Add to Home Screen* (iPhone) or *⋮ → Install app* (Android).

## One-time setup

### 1. Create the database tables
Supabase dashboard → **SQL Editor** → **New query** → paste everything in [`schema.sql`](schema.sql) → **Run**.

### 2. Connect the site to Supabase
Supabase → **Project Settings → API**. Copy the **Project URL** and the **anon public** key into [`config.js`](config.js).
The anon key is designed to be public. Row-level security in `schema.sql` means each login can only read and write its own rows.

### 3. Tell Supabase where the site lives
Supabase → **Authentication → URL Configuration**:
- **Site URL:** `https://zooviee.github.io/rhythm-ledger/`
- **Redirect URLs:** add the same address.

### 4. Turn on GitHub Pages
This repo → **Settings → Pages** → Source: **Deploy from a branch** → Branch: **main** / **(root)** → Save. Give it a minute to go live.

### 5. Create your account, then lock the door
Open the site, choose **Create your account**, and confirm the email Supabase sends you. Then go to Supabase → **Authentication → Sign In / Providers** (or *Settings*) and turn **off** "Allow new users to sign up", so nobody else can make an account on your tracker.

## Files
| File | What it is |
|---|---|
| `index.html` | The whole app: Daily Log, Summary, Dashboard, Archive |
| `config.js` | Your Supabase URL and anon key |
| `schema.sql` | Database tables and access rules |
| `sw.js`, `manifest.webmanifest`, `icon*` | Offline support and the home-screen app icon |
