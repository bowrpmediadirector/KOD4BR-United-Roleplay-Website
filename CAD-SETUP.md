# KOD4BR United Roleplay CAD

The website now contains a professional CAD foundation.

## CAD URL

/cad

## Modules

- Dispatch Dashboard
- Calls
- Units
- Persons
- Vehicles
- BOLOs
- Warrants
- Reports
- Settings
- Realtime updates

## Database

The database schema is located at:

supabase/cad-schema.sql

Run this SQL in:

Supabase Dashboard
→ SQL Editor
→ New Query
→ Paste cad-schema.sql
→ Run

## Environment

The CAD browser client requires:

NEXT_PUBLIC_SUPABASE_URL=
NEXT_PUBLIC_SUPABASE_ANON_KEY=

Do NOT expose:

SUPABASE_SERVICE_ROLE_KEY

to browser-side code.

## Realtime

Calls, units, and CAD activity are designed for Supabase Realtime.

## AI

AI functionality is intentionally disabled.

## Backup

Existing CAD files are backed up under:

.cad-backups/

before this upgrade modifies them.
