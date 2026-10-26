-- Rhythm Ledger — database setup.
-- Run once in Supabase: SQL Editor → New query → paste this file → Run.
-- Every table is locked so each signed-in user can only see and change their own rows.

-- One row per day: the 24 hourly entries live in the "hours" JSON array.
create table if not exists public.days (
  user_id    uuid        not null default auth.uid() references auth.users(id) on delete cascade,
  date       date        not null,
  month      text        not null,               -- 'YYYY-MM'
  hours      jsonb       not null,               -- [{h, activity, category, rating, notes} x 24]
  updated_at timestamptz not null default now(),
  primary key (user_id, date)
);

-- One row per closed month: the archive summary.
create table if not exists public.archives (
  user_id     uuid        not null default auth.uid() references auth.users(id) on delete cascade,
  month       text        not null,
  summary     jsonb       not null,
  archived_at timestamptz not null default now(),
  primary key (user_id, month)
);

-- Your saved prefill template.
create table if not exists public.settings (
  user_id    uuid        primary key default auth.uid() references auth.users(id) on delete cascade,
  template   jsonb,
  updated_at timestamptz not null default now()
);

alter table public.days     enable row level security;
alter table public.archives enable row level security;
alter table public.settings enable row level security;

drop policy if exists "own days"     on public.days;
drop policy if exists "own archives" on public.archives;
drop policy if exists "own settings" on public.settings;

create policy "own days"     on public.days     for all to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "own archives" on public.archives for all to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "own settings" on public.settings for all to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);
