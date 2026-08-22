-- ============================================================
-- KOD4BR UNITED ROLEPLAY
-- CAD SYSTEM FOUNDATION
-- ============================================================

create extension if not exists "pgcrypto";

-- ============================================================
-- ENUMS
-- ============================================================

do $$
begin

    if not exists (
        select 1 from pg_type where typname = 'cad_call_status'
    ) then
        create type public.cad_call_status as enum (
            'PENDING',
            'ACTIVE',
            'HOLD',
            'CLOSED'
        );
    end if;

    if not exists (
        select 1 from pg_type where typname = 'cad_call_priority'
    ) then
        create type public.cad_call_priority as enum (
            'LOW',
            'MEDIUM',
            'HIGH',
            'EMERGENCY'
        );
    end if;

    if not exists (
        select 1 from pg_type where typname = 'cad_unit_status'
    ) then
        create type public.cad_unit_status as enum (
            'AVAILABLE',
            'EN_ROUTE',
            'ON_SCENE',
            'BUSY',
            'TRAFFIC_STOP',
            'TRANSPORTING',
            'PANIC',
            'OUT_OF_SERVICE'
        );
    end if;

end $$;

-- ============================================================
-- CAD PERMISSIONS
-- ============================================================

create table if not exists public.cad_permissions (
    id uuid primary key default gen_random_uuid(),

    user_id uuid not null references auth.users(id) on delete cascade,

    can_view boolean not null default false,
    can_dispatch boolean not null default false,
    can_manage_calls boolean not null default false,
    can_manage_units boolean not null default false,
    can_view_records boolean not null default false,
    can_manage_records boolean not null default false,
    can_create_reports boolean not null default false,
    can_manage_warrants boolean not null default false,
    can_manage_bolos boolean not null default false,
    can_admin boolean not null default false,

    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now(),

    unique(user_id)
);

-- ============================================================
-- CAD UNITS
-- ============================================================

create table if not exists public.cad_units (
    id uuid primary key default gen_random_uuid(),

    unit_number text not null unique,
    officer_user_id uuid references auth.users(id) on delete set null,

    officer_name text,
    department text,
    rank text,

    status public.cad_unit_status not null default 'OUT_OF_SERVICE',

    location text,
    current_call_id uuid,

    radio_identifier text,

    notes text,

    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now()
);

-- ============================================================
-- CAD CALLS
-- ============================================================

create table if not exists public.cad_calls (
    id uuid primary key default gen_random_uuid(),

    case_number text not null unique,

    call_type text not null,
    priority public.cad_call_priority not null default 'MEDIUM',
    status public.cad_call_status not null default 'PENDING',

    caller_name text,
    caller_phone text,

    location text not null,
    description text,

    created_by uuid references auth.users(id) on delete set null,

    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now(),
    closed_at timestamptz
);

-- ============================================================
-- CALL / UNIT RELATIONSHIP
-- ============================================================

create table if not exists public.cad_call_units (
    id uuid primary key default gen_random_uuid(),

    call_id uuid not null references public.cad_calls(id) on delete cascade,
    unit_id uuid not null references public.cad_units(id) on delete cascade,

    assigned_at timestamptz not null default now(),
    arrived_at timestamptz,
    cleared_at timestamptz,

    notes text,

    unique(call_id, unit_id)
);

-- ============================================================
-- PERSON RECORDS
-- ============================================================

create table if not exists public.cad_persons (
    id uuid primary key default gen_random_uuid(),

    first_name text not null,
    middle_name text,
    last_name text not null,

    date_of_birth date,

    address text,
    phone text,
    email text,

    driver_license_number text,
    driver_license_status text default 'VALID',

    wanted boolean not null default false,

    notes text,

    created_by uuid references auth.users(id) on delete set null,

    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now()
);

-- ============================================================
-- VEHICLE RECORDS
-- ============================================================

create table if not exists public.cad_vehicles (
    id uuid primary key default gen_random_uuid(),

    plate text not null unique,
    state text,

    make text,
    model text,
    year integer,
    color text,

    vin text,

    owner_id uuid references public.cad_persons(id) on delete set null,

    registration_status text default 'VALID',
    insurance_status text default 'VALID',

    stolen boolean not null default false,

    notes text,

    created_by uuid references auth.users(id) on delete set null,

    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now()
);

-- ============================================================
-- WARRANTS
-- ============================================================

create table if not exists public.cad_warrants (
    id uuid primary key default gen_random_uuid(),

    warrant_number text not null unique,

    person_id uuid references public.cad_persons(id) on delete cascade,

    warrant_type text,
    charges text,

    issuing_agency text,

    status text not null default 'ACTIVE',

    issued_at timestamptz not null default now(),
    served_at timestamptz,

    notes text,

    created_by uuid references auth.users(id) on delete set null,

    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now()
);

-- ============================================================
-- BOLOS
-- ============================================================

create table if not exists public.cad_bolos (
    id uuid primary key default gen_random_uuid(),

    bolo_number text not null unique,

    bolo_type text not null,

    subject text,
    description text,

    person_id uuid references public.cad_persons(id) on delete set null,
    vehicle_id uuid references public.cad_vehicles(id) on delete set null,

    location text,

    status text not null default 'ACTIVE',

    created_by uuid references auth.users(id) on delete set null,

    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now()
);

-- ============================================================
-- INCIDENT REPORTS
-- ============================================================

create table if not exists public.cad_reports (
    id uuid primary key default gen_random_uuid(),

    report_number text not null unique,

    call_id uuid references public.cad_calls(id) on delete set null,

    title text not null,
    report_type text,

    narrative text,

    primary_officer uuid references auth.users(id) on delete set null,

    status text not null default 'DRAFT',

    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now(),
    submitted_at timestamptz
);

-- ============================================================
-- CAD ACTIVITY
-- ============================================================

create table if not exists public.cad_activity (
    id uuid primary key default gen_random_uuid(),

    user_id uuid references auth.users(id) on delete set null,

    action text not null,
    category text,

    description text,

    call_id uuid references public.cad_calls(id) on delete set null,
    unit_id uuid references public.cad_units(id) on delete set null,

    metadata jsonb default '{}'::jsonb,

    created_at timestamptz not null default now()
);

-- ============================================================
-- INDEXES
-- ============================================================

create index if not exists cad_calls_status_idx
on public.cad_calls(status);

create index if not exists cad_calls_priority_idx
on public.cad_calls(priority);

create index if not exists cad_calls_created_idx
on public.cad_calls(created_at desc);

create index if not exists cad_units_status_idx
on public.cad_units(status);

create index if not exists cad_units_department_idx
on public.cad_units(department);

create index if not exists cad_persons_name_idx
on public.cad_persons(last_name, first_name);

create index if not exists cad_persons_license_idx
on public.cad_persons(driver_license_number);

create index if not exists cad_vehicles_plate_idx
on public.cad_vehicles(plate);

create index if not exists cad_vehicles_vin_idx
on public.cad_vehicles(vin);

create index if not exists cad_activity_created_idx
on public.cad_activity(created_at desc);

-- ============================================================
-- PERMISSION FUNCTION
-- ============================================================

create or replace function public.cad_has_permission(
    permission_name text
)
returns boolean
language plpgsql
security definer
set search_path = public
as $$
declare
    allowed boolean;
begin

    select
        case permission_name
            when 'view' then can_view
            when 'dispatch' then can_dispatch
            when 'manage_calls' then can_manage_calls
            when 'manage_units' then can_manage_units
            when 'view_records' then can_view_records
            when 'manage_records' then can_manage_records
            when 'create_reports' then can_create_reports
            when 'manage_warrants' then can_manage_warrants
            when 'manage_bolos' then can_manage_bolos
            when 'admin' then can_admin
            else false
        end
    into allowed
    from public.cad_permissions
    where user_id = auth.uid();

    return coalesce(allowed, false);
end;
$$;

-- ============================================================
-- RLS
-- ============================================================

alter table public.cad_permissions enable row level security;
alter table public.cad_calls enable row level security;
alter table public.cad_units enable row level security;
alter table public.cad_call_units enable row level security;
alter table public.cad_persons enable row level security;
alter table public.cad_vehicles enable row level security;
alter table public.cad_warrants enable row level security;
alter table public.cad_bolos enable row level security;
alter table public.cad_reports enable row level security;
alter table public.cad_activity enable row level security;

-- ============================================================
-- PERMISSIONS
-- ============================================================

drop policy if exists cad_permissions_self on public.cad_permissions;

create policy cad_permissions_self
on public.cad_permissions
for select
to authenticated
using (
    user_id = auth.uid()
    or public.cad_has_permission('admin')
);

drop policy if exists cad_permissions_admin on public.cad_permissions;

create policy cad_permissions_admin
on public.cad_permissions
for all
to authenticated
using (
    public.cad_has_permission('admin')
)
with check (
    public.cad_has_permission('admin')
);

-- ============================================================
-- CALL POLICIES
-- ============================================================

drop policy if exists cad_calls_select on public.cad_calls;

create policy cad_calls_select
on public.cad_calls
for select
to authenticated
using (
    public.cad_has_permission('view')
);

drop policy if exists cad_calls_insert on public.cad_calls;

create policy cad_calls_insert
on public.cad_calls
for insert
to authenticated
with check (
    public.cad_has_permission('manage_calls')
);

drop policy if exists cad_calls_update on public.cad_calls;

create policy cad_calls_update
on public.cad_calls
for update
to authenticated
using (
    public.cad_has_permission('manage_calls')
)
with check (
    public.cad_has_permission('manage_calls')
);

-- ============================================================
-- UNIT POLICIES
-- ============================================================

drop policy if exists cad_units_select on public.cad_units;

create policy cad_units_select
on public.cad_units
for select
to authenticated
using (
    public.cad_has_permission('view')
);

drop policy if exists cad_units_insert on public.cad_units;

create policy cad_units_insert
on public.cad_units
for insert
to authenticated
with check (
    public.cad_has_permission('manage_units')
);

drop policy if exists cad_units_update on public.cad_units;

create policy cad_units_update
on public.cad_units
for update
to authenticated
using (
    public.cad_has_permission('manage_units')
)
with check (
    public.cad_has_permission('manage_units')
);

-- ============================================================
-- CALL UNIT POLICIES
-- ============================================================

drop policy if exists cad_call_units_select on public.cad_call_units;

create policy cad_call_units_select
on public.cad_call_units
for select
to authenticated
using (
    public.cad_has_permission('view')
);

drop policy if exists cad_call_units_manage on public.cad_call_units;

create policy cad_call_units_manage
on public.cad_call_units
for all
to authenticated
using (
    public.cad_has_permission('manage_calls')
)
with check (
    public.cad_has_permission('manage_calls')
);

-- ============================================================
-- PERSON POLICIES
-- ============================================================

drop policy if exists cad_persons_select on public.cad_persons;

create policy cad_persons_select
on public.cad_persons
for select
to authenticated
using (
    public.cad_has_permission('view_records')
);

drop policy if exists cad_persons_manage on public.cad_persons;

create policy cad_persons_manage
on public.cad_persons
for all
to authenticated
using (
    public.cad_has_permission('manage_records')
)
with check (
    public.cad_has_permission('manage_records')
);

-- ============================================================
-- VEHICLE POLICIES
-- ============================================================

drop policy if exists cad_vehicles_select on public.cad_vehicles;

create policy cad_vehicles_select
on public.cad_vehicles
for select
to authenticated
using (
    public.cad_has_permission('view_records')
);

drop policy if exists cad_vehicles_manage on public.cad_vehicles;

create policy cad_vehicles_manage
on public.cad_vehicles
for all
to authenticated
using (
    public.cad_has_permission('manage_records')
)
with check (
    public.cad_has_permission('manage_records')
);

-- ============================================================
-- WARRANT POLICIES
-- ============================================================

drop policy if exists cad_warrants_select on public.cad_warrants;

create policy cad_warrants_select
on public.cad_warrants
for select
to authenticated
using (
    public.cad_has_permission('view_records')
);

drop policy if exists cad_warrants_manage on public.cad_warrants;

create policy cad_warrants_manage
on public.cad_warrants
for all
to authenticated
using (
    public.cad_has_permission('manage_warrants')
)
with check (
    public.cad_has_permission('manage_warrants')
);

-- ============================================================
-- BOLO POLICIES
-- ============================================================

drop policy if exists cad_bolos_select on public.cad_bolos;

create policy cad_bolos_select
on public.cad_bolos
for select
to authenticated
using (
    public.cad_has_permission('view_records')
);

drop policy if exists cad_bolos_manage on public.cad_bolos;

create policy cad_bolos_manage
on public.cad_bolos
for all
to authenticated
using (
    public.cad_has_permission('manage_bolos')
)
with check (
    public.cad_has_permission('manage_bolos')
);

-- ============================================================
-- REPORT POLICIES
-- ============================================================

drop policy if exists cad_reports_select on public.cad_reports;

create policy cad_reports_select
on public.cad_reports
for select
to authenticated
using (
    public.cad_has_permission('view')
);

drop policy if exists cad_reports_manage on public.cad_reports;

create policy cad_reports_manage
on public.cad_reports
for all
to authenticated
using (
    public.cad_has_permission('create_reports')
)
with check (
    public.cad_has_permission('create_reports')
);

-- ============================================================
-- ACTIVITY LOG
-- ============================================================

drop policy if exists cad_activity_select on public.cad_activity;

create policy cad_activity_select
on public.cad_activity
for select
to authenticated
using (
    public.cad_has_permission('view')
);

drop policy if exists cad_activity_insert on public.cad_activity;

create policy cad_activity_insert
on public.cad_activity
for insert
to authenticated
with check (
    auth.uid() = user_id
);

-- ============================================================
-- REALTIME
-- ============================================================

do $$
begin

    begin
        alter publication supabase_realtime add table public.cad_calls;
    exception when duplicate_object then
        null;
    end;

    begin
        alter publication supabase_realtime add table public.cad_units;
    exception when duplicate_object then
        null;
    end;

    begin
        alter publication supabase_realtime add table public.cad_activity;
    exception when duplicate_object then
        null;
    end;

end $$;

-- ============================================================
-- DEFAULT ADMIN TEMPLATE
-- ============================================================
-- DO NOT automatically grant permissions to every user.
-- After migration, insert the specific administrator's UUID.
--
-- Example:
--
-- insert into public.cad_permissions (
--     user_id,
--     can_view,
--     can_dispatch,
--     can_manage_calls,
--     can_manage_units,
--     can_view_records,
--     can_manage_records,
--     can_create_reports,
--     can_manage_warrants,
--     can_manage_bolos,
--     can_admin
-- )
-- values (
--     'YOUR-AUTH-USER-UUID',
--     true,
--     true,
--     true,
--     true,
--     true,
--     true,
--     true,
--     true,
--     true,
--     true
-- );

-- ============================================================
-- END CAD FOUNDATION
-- ============================================================
