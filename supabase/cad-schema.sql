-- ============================================================
-- KOD4BR UNITED ROLEPLAY
-- CAD DATABASE FOUNDATION
-- ============================================================

create extension if not exists pgcrypto;

-- ------------------------------------------------------------
-- CALLS
-- ------------------------------------------------------------

create table if not exists public.cad_calls (
    id uuid primary key default gen_random_uuid(),
    call_number bigint generated always as identity unique,
    title text not null,
    description text,
    location text,
    postal text,
    priority text not null default 'P3'
        check (priority in ('P1','P2','P3','P4')),
    status text not null default 'PENDING'
        check (
            status in (
                'PENDING',
                'DISPATCHED',
                'ACTIVE',
                'ON_SCENE',
                'CLOSED',
                'CANCELLED'
            )
        ),
    caller_name text,
    caller_phone text,
    created_by uuid references auth.users(id) on delete set null,
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now()
);

-- ------------------------------------------------------------
-- UNITS
-- ------------------------------------------------------------

create table if not exists public.cad_units (
    id uuid primary key default gen_random_uuid(),
    unit_number text not null unique,
    officer_id uuid references auth.users(id) on delete set null,
    officer_name text,
    department_id uuid,
    department_name text,
    department_abbreviation text,
    status text not null default 'AVAILABLE'
        check (
            status in (
                'AVAILABLE',
                'EN_ROUTE',
                'ON_SCENE',
                'BUSY',
                'TRAFFIC_STOP',
                'TRANSPORTING',
                'PANIC',
                'OUT_OF_SERVICE'
            )
        ),
    location text,
    current_call_id uuid references public.cad_calls(id) on delete set null,
    is_supervisor boolean not null default false,
    updated_at timestamptz not null default now(),
    created_at timestamptz not null default now()
);

-- ------------------------------------------------------------
-- PERSONS
-- ------------------------------------------------------------

create table if not exists public.cad_persons (
    id uuid primary key default gen_random_uuid(),
    first_name text not null,
    last_name text not null,
    date_of_birth date,
    phone text,
    address text,
    driver_license text unique,
    wanted boolean not null default false,
    notes text,
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now()
);

-- ------------------------------------------------------------
-- VEHICLES
-- ------------------------------------------------------------

create table if not exists public.cad_vehicles (
    id uuid primary key default gen_random_uuid(),
    plate text not null unique,
    state text,
    make text,
    model text,
    year integer,
    color text,
    vin text unique,
    owner_name text,
    registration_status text default 'VALID',
    insurance_status text default 'VALID',
    stolen boolean not null default false,
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now()
);

-- ------------------------------------------------------------
-- BOLOS
-- ------------------------------------------------------------

create table if not exists public.cad_bolos (
    id uuid primary key default gen_random_uuid(),
    title text not null,
    description text,
    subject_name text,
    vehicle_description text,
    plate text,
    location text,
    active boolean not null default true,
    created_by uuid references auth.users(id) on delete set null,
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now()
);

-- ------------------------------------------------------------
-- WARRANTS
-- ------------------------------------------------------------

create table if not exists public.cad_warrants (
    id uuid primary key default gen_random_uuid(),
    subject_name text not null,
    type text not null default 'ARREST',
    charge text,
    description text,
    active boolean not null default true,
    issued_by uuid references auth.users(id) on delete set null,
    issued_at timestamptz default now(),
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now()
);

-- ------------------------------------------------------------
-- REPORTS
-- ------------------------------------------------------------

create table if not exists public.cad_reports (
    id uuid primary key default gen_random_uuid(),
    report_number bigint generated always as identity unique,
    type text not null default 'INCIDENT',
    title text not null,
    narrative text,
    author_id uuid references auth.users(id) on delete set null,
    author_name text,
    call_id uuid references public.cad_calls(id) on delete set null,
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now()
);

-- ------------------------------------------------------------
-- ACTIVITY
-- ------------------------------------------------------------

create table if not exists public.cad_activity (
    id uuid primary key default gen_random_uuid(),
    type text not null,
    message text not null,
    unit_number text,
    created_by uuid references auth.users(id) on delete set null,
    created_at timestamptz not null default now()
);

-- ------------------------------------------------------------
-- CAD USER PERMISSIONS
-- ------------------------------------------------------------

create table if not exists public.cad_user_permissions (
    id uuid primary key default gen_random_uuid(),
    user_id uuid not null references auth.users(id) on delete cascade,
    permission text not null,
    granted_by uuid references auth.users(id) on delete set null,
    created_at timestamptz not null default now(),
    unique(user_id, permission)
);

-- ------------------------------------------------------------
-- INDEXES
-- ------------------------------------------------------------

create index if not exists cad_calls_status_idx
    on public.cad_calls(status);

create index if not exists cad_calls_priority_idx
    on public.cad_calls(priority);

create index if not exists cad_calls_created_idx
    on public.cad_calls(created_at desc);

create index if not exists cad_units_status_idx
    on public.cad_units(status);

create index if not exists cad_persons_name_idx
    on public.cad_persons(last_name, first_name);

create index if not exists cad_vehicles_plate_idx
    on public.cad_vehicles(plate);

create index if not exists cad_activity_created_idx
    on public.cad_activity(created_at desc);

-- ------------------------------------------------------------
-- ROW LEVEL SECURITY
-- ------------------------------------------------------------

alter table public.cad_calls enable row level security;
alter table public.cad_units enable row level security;
alter table public.cad_persons enable row level security;
alter table public.cad_vehicles enable row level security;
alter table public.cad_bolos enable row level security;
alter table public.cad_warrants enable row level security;
alter table public.cad_reports enable row level security;
alter table public.cad_activity enable row level security;
alter table public.cad_user_permissions enable row level security;

-- Basic authenticated access.
-- Fine-grained permission policies can be added once your
-- existing website role system is connected to CAD.

drop policy if exists "CAD authenticated read calls"
on public.cad_calls;

create policy "CAD authenticated read calls"
on public.cad_calls
for select
to authenticated
using (true);

drop policy if exists "CAD authenticated manage calls"
on public.cad_calls;

create policy "CAD authenticated manage calls"
on public.cad_calls
for all
to authenticated
using (true)
with check (true);

drop policy if exists "CAD authenticated read units"
on public.cad_units;

create policy "CAD authenticated read units"
on public.cad_units
for select
to authenticated
using (true);

drop policy if exists "CAD authenticated manage units"
on public.cad_units;

create policy "CAD authenticated manage units"
on public.cad_units
for all
to authenticated
using (true)
with check (true);

drop policy if exists "CAD authenticated read persons"
on public.cad_persons;

create policy "CAD authenticated read persons"
on public.cad_persons
for select
to authenticated
using (true);

drop policy if exists "CAD authenticated manage persons"
on public.cad_persons;

create policy "CAD authenticated manage persons"
on public.cad_persons
for all
to authenticated
using (true)
with check (true);

drop policy if exists "CAD authenticated read vehicles"
on public.cad_vehicles;

create policy "CAD authenticated read vehicles"
on public.cad_vehicles
for select
to authenticated
using (true);

drop policy if exists "CAD authenticated manage vehicles"
on public.cad_vehicles;

create policy "CAD authenticated manage vehicles"
on public.cad_vehicles
for all
to authenticated
using (true)
with check (true);

drop policy if exists "CAD authenticated read bolos"
on public.cad_bolos;

create policy "CAD authenticated read bolos"
on public.cad_bolos
for select
to authenticated
using (true);

drop policy if exists "CAD authenticated manage bolos"
on public.cad_bolos;

create policy "CAD authenticated manage bolos"
on public.cad_bolos
for all
to authenticated
using (true)
with check (true);

drop policy if exists "CAD authenticated read warrants"
on public.cad_warrants;

create policy "CAD authenticated read warrants"
on public.cad_warrants
for select
to authenticated
using (true);

drop policy if exists "CAD authenticated manage warrants"
on public.cad_warrants;

create policy "CAD authenticated manage warrants"
on public.cad_warrants
for all
to authenticated
using (true)
with check (true);

drop policy if exists "CAD authenticated read reports"
on public.cad_reports;

create policy "CAD authenticated read reports"
on public.cad_reports
for select
to authenticated
using (true);

drop policy if exists "CAD authenticated manage reports"
on public.cad_reports;

create policy "CAD authenticated manage reports"
on public.cad_reports
for all
to authenticated
using (true)
with check (true);

drop policy if exists "CAD authenticated read activity"
on public.cad_activity;

create policy "CAD authenticated read activity"
on public.cad_activity
for select
to authenticated
using (true);

drop policy if exists "CAD authenticated create activity"
on public.cad_activity;

create policy "CAD authenticated create activity"
on public.cad_activity
for insert
to authenticated
with check (true);

drop policy if exists "CAD authenticated read permissions"
on public.cad_user_permissions;

create policy "CAD authenticated read permissions"
on public.cad_user_permissions
for select
to authenticated
using (user_id = auth.uid());

-- ------------------------------------------------------------
-- REALTIME
-- ------------------------------------------------------------

do $$
begin
    alter publication supabase_realtime
    add table public.cad_calls;
exception
    when duplicate_object then null;
end $$;

do $$
begin
    alter publication supabase_realtime
    add table public.cad_units;
exception
    when duplicate_object then null;
end $$;

do $$
begin
    alter publication supabase_realtime
    add table public.cad_activity;
exception
    when duplicate_object then null;
end $$;
