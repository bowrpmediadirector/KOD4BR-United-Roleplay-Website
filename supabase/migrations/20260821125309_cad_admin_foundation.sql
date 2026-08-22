-- KOD4BR UNITED ROLEPLAY
-- CAD ADMINISTRATION FOUNDATION
-- Additive migration: does not remove existing CAD tables.

create extension if not exists pgcrypto;

create table if not exists public.cad_admin_roles (
    id uuid primary key default gen_random_uuid(),
    name text not null unique,
    level text not null check (
        level in ('admin', 'super_admin', 'owner')
    ),
    description text,
    created_at timestamptz not null default now()
);

create table if not exists public.cad_permissions (
    id uuid primary key default gen_random_uuid(),
    permission_key text not null unique,
    name text not null,
    description text,
    minimum_level text not null default 'admin' check (
        minimum_level in ('admin', 'super_admin', 'owner')
    ),
    created_at timestamptz not null default now()
);

create table if not exists public.cad_permission_keys (
    id uuid primary key default gen_random_uuid(),
    key_hash text not null unique,
    label text,
    permission_key text,
    department_id uuid,
    expires_at timestamptz,
    max_uses integer,
    uses integer not null default 0,
    active boolean not null default true,
    created_by uuid,
    created_at timestamptz not null default now()
);

create table if not exists public.cad_identifiers (
    id uuid primary key default gen_random_uuid(),
    user_id uuid,
    identifier_type text not null,
    identifier_value text not null,
    verified boolean not null default false,
    created_at timestamptz not null default now(),
    unique(identifier_type, identifier_value)
);

create table if not exists public.cad_custom_records (
    id uuid primary key default gen_random_uuid(),
    name text not null,
    slug text not null unique,
    description text,
    schema jsonb not null default '{}'::jsonb,
    active boolean not null default true,
    created_by uuid,
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now()
);

create table if not exists public.cad_ten_codes (
    id uuid primary key default gen_random_uuid(),
    code text not null,
    meaning text not null,
    description text,
    department_id uuid,
    active boolean not null default true,
    created_at timestamptz not null default now()
);

create table if not exists public.cad_penal_codes (
    id uuid primary key default gen_random_uuid(),
    code text not null,
    name text not null,
    description text,
    classification text,
    fine numeric,
    jail_minutes integer,
    active boolean not null default true,
    created_at timestamptz not null default now()
);

create table if not exists public.cad_activity_logs (
    id uuid primary key default gen_random_uuid(),
    actor_id uuid,
    action text not null,
    category text,
    target_type text,
    target_id text,
    details jsonb not null default '{}'::jsonb,
    created_at timestamptz not null default now()
);

create table if not exists public.cad_integrations (
    id uuid primary key default gen_random_uuid(),
    provider text not null unique,
    enabled boolean not null default false,
    configuration jsonb not null default '{}'::jsonb,
    last_connected_at timestamptz,
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now()
);

create table if not exists public.cad_limits (
    id uuid primary key default gen_random_uuid(),
    limit_key text not null unique,
    limit_value integer not null default 0,
    description text,
    updated_at timestamptz not null default now()
);

create table if not exists public.cad_system_settings (
    id uuid primary key default gen_random_uuid(),
    setting_key text not null unique,
    setting_value jsonb not null default '{}'::jsonb,
    updated_by uuid,
    updated_at timestamptz not null default now()
);

create table if not exists public.cad_ownership (
    id uuid primary key default gen_random_uuid(),
    community_id text not null unique,
    owner_user_id uuid,
    active boolean not null default true,
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now()
);

insert into public.cad_admin_roles
    (name, level, description)
values
    ('CAD Administrator', 'admin', 'Standard CAD administration access.'),
    ('CAD Super Administrator', 'super_admin', 'Advanced CAD administration access.'),
    ('CAD Owner', 'owner', 'Full ownership and destructive access.')
on conflict (name) do nothing;

insert into public.cad_permissions
    (permission_key, name, description, minimum_level)
values
    ('admin.accounts', 'Manage Accounts', 'Manage CAD accounts.', 'admin'),
    ('admin.identifiers', 'Manage Identifiers', 'Manage user identifiers.', 'admin'),
    ('admin.permission_keys', 'Manage Permission Keys', 'Manage permission keys.', 'admin'),
    ('admin.customization', 'Manage Customization', 'Manage CAD customization.', 'admin'),
    ('admin.custom_records', 'Manage Custom Records', 'Manage custom record definitions.', 'admin'),
    ('admin.departments', 'Manage Departments', 'Manage CAD departments.', 'admin'),
    ('admin.codes', 'Manage Codes', 'Manage 10-codes and penal codes.', 'admin'),
    ('admin.logs', 'View Logs', 'View administrative logs.', 'admin'),
    ('admin.integrations', 'Manage Integrations', 'Manage external integrations.', 'super_admin'),
    ('admin.limits', 'Manage Limits', 'Manage CAD limits.', 'super_admin'),
    ('admin.wipe', 'Wipe Records', 'Delete selected CAD records.', 'super_admin'),
    ('admin.community', 'Manage Community ID', 'Change the community identifier.', 'super_admin'),
    ('admin.authentication', 'Manage Authentication', 'Manage authentication settings.', 'super_admin'),
    ('admin.transfer', 'Transfer CAD', 'Transfer CAD ownership.', 'owner'),
    ('admin.delete', 'Delete CAD', 'Permanently delete CAD.', 'owner')
on conflict (permission_key) do nothing;

insert into public.cad_integrations (provider, enabled)
values
    ('discord', false),
    ('roblox', false),
    ('erlc', false),
    ('ai', false)
on conflict (provider) do nothing;

insert into public.cad_system_settings
    (setting_key, setting_value)
values
    ('cad_name', '"KOD4BR UNITED CAD"'::jsonb),
    ('ai_enabled', 'false'::jsonb),
    ('maintenance_mode', 'false'::jsonb),
    ('require_authentication', 'true'::jsonb)
on conflict (setting_key) do nothing;

insert into public.cad_ownership
    (community_id)
values
    ('KOD4BR-UNITED')
on conflict (community_id) do nothing;
