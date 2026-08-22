$ErrorActionPreference = "Stop"

$root = (Get-Location).Path
$src = Join-Path $root "src"

Write-Host ""
Write-Host "=============================================" -ForegroundColor Cyan
Write-Host " KOD4BR UNITED ROLEPLAY - CAD UPGRADE" -ForegroundColor Cyan
Write-Host "=============================================" -ForegroundColor Cyan
Write-Host ""

# ------------------------------------------------------------
# Helpers
# ------------------------------------------------------------

function Write-ProjectFile {
    param(
        [string]$Path,
        [string]$Content
    )

    $full = Join-Path $root $Path
    $dir = Split-Path $full -Parent

    if (!(Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir -Force | Out-Null
    }

    Set-Content -Path $full -Value $Content -Encoding UTF8
    Write-Host "Created: $Path" -ForegroundColor Green
}

function Backup-ProjectFile {
    param(
        [string]$Path
    )

    $full = Join-Path $root $Path

    if (Test-Path $full) {
        $timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
        $backupDir = Join-Path $root ".cad-backups\$timestamp"

        New-Item -ItemType Directory -Path $backupDir -Force | Out-Null

        $destination = Join-Path $backupDir (Split-Path $Path -Leaf)
        Copy-Item $full $destination -Force

        Write-Host "Backed up: $Path" -ForegroundColor Yellow
    }
}

# ------------------------------------------------------------
# Backup existing CAD
# ------------------------------------------------------------

$existingFiles = @(
    "src/app/cad/page.tsx",
    "src/app/cad/bolos/page.tsx",
    "src/app/cad/calls/page.tsx",
    "src/app/cad/persons/page.tsx",
    "src/app/cad/reports/page.tsx",
    "src/app/cad/settings/page.tsx",
    "src/app/cad/units/page.tsx",
    "src/app/cad/vehicles/page.tsx",
    "src/app/cad/warrants/page.tsx",
    "src/lib/cad/activity.ts",
    "src/lib/cad/supabase.ts",
    "src/lib/cad/types.ts",
    "src/componants/Layout/Navbar.tsx"
)

foreach ($file in $existingFiles) {
    Backup-ProjectFile $file
}

# ------------------------------------------------------------
# CAD TYPES
# ------------------------------------------------------------

Write-ProjectFile "src/lib/cad/types.ts" @'
export type CadCallPriority = "P1" | "P2" | "P3" | "P4";

export type CadCallStatus =
  | "PENDING"
  | "DISPATCHED"
  | "ACTIVE"
  | "ON_SCENE"
  | "CLOSED"
  | "CANCELLED";

export type CadUnitStatus =
  | "AVAILABLE"
  | "EN_ROUTE"
  | "ON_SCENE"
  | "BUSY"
  | "TRAFFIC_STOP"
  | "TRANSPORTING"
  | "PANIC"
  | "OUT_OF_SERVICE";

export type CadDepartmentType =
  | "POLICE"
  | "SHERIFF"
  | "STATE_POLICE"
  | "FIRE"
  | "EMS"
  | "CORRECTIONS"
  | "OTHER";

export interface CadCall {
  id: string;
  call_number: string;
  title: string;
  description: string | null;
  location: string | null;
  postal: string | null;
  priority: CadCallPriority;
  status: CadCallStatus;
  caller_name: string | null;
  caller_phone: string | null;
  created_at: string;
  updated_at: string;
}

export interface CadUnit {
  id: string;
  unit_number: string;
  officer_name: string | null;
  department_name: string | null;
  department_abbreviation: string | null;
  status: CadUnitStatus;
  location: string | null;
  current_call_id: string | null;
  is_supervisor: boolean;
  updated_at: string;
}

export interface CadPerson {
  id: string;
  first_name: string;
  last_name: string;
  date_of_birth: string | null;
  phone: string | null;
  address: string | null;
  driver_license: string | null;
  wanted: boolean;
  notes: string | null;
  created_at: string;
  updated_at: string;
}

export interface CadVehicle {
  id: string;
  plate: string;
  state: string | null;
  make: string | null;
  model: string | null;
  year: number | null;
  color: string | null;
  vin: string | null;
  owner_name: string | null;
  registration_status: string | null;
  insurance_status: string | null;
  stolen: boolean;
  created_at: string;
  updated_at: string;
}

export interface CadActivity {
  id: string;
  type: string;
  message: string;
  unit_number: string | null;
  created_at: string;
}
'@

# ------------------------------------------------------------
# SUPABASE CLIENT
# ------------------------------------------------------------

Write-ProjectFile "src/lib/cad/supabase.ts" @'
import { createClient } from "@supabase/supabase-js";

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseAnonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;

if (!supabaseUrl || !supabaseAnonKey) {
  throw new Error(
    "Missing NEXT_PUBLIC_SUPABASE_URL or NEXT_PUBLIC_SUPABASE_ANON_KEY"
  );
}

export const cadSupabase = createClient(
  supabaseUrl,
  supabaseAnonKey
);
'@

# ------------------------------------------------------------
# ACTIVITY
# ------------------------------------------------------------

Write-ProjectFile "src/lib/cad/activity.ts" @'
import { cadSupabase } from "./supabase";

export async function createCadActivity(
  type: string,
  message: string,
  unitNumber?: string
) {
  return cadSupabase.from("cad_activity").insert({
    type,
    message,
    unit_number: unitNumber ?? null,
  });
}

export async function getRecentCadActivity(limit = 25) {
  return cadSupabase
    .from("cad_activity")
    .select("*")
    .order("created_at", { ascending: false })
    .limit(limit);
}
'@

# ------------------------------------------------------------
# CAD GLOBAL CSS
# ------------------------------------------------------------

Write-ProjectFile "src/app/cad/cad.css" @'
.cad-root {
  min-height: calc(100vh - 80px);
  background: #070b12;
  color: #e8edf5;
  display: flex;
  flex-direction: column;
}

.cad-shell {
  display: flex;
  min-height: calc(100vh - 80px);
}

.cad-sidebar {
  width: 250px;
  flex-shrink: 0;
  background: #0b111b;
  border-right: 1px solid #1c2635;
  padding: 18px 14px;
}

.cad-brand {
  padding: 8px 10px 20px;
}

.cad-brand-title {
  font-size: 18px;
  font-weight: 800;
  letter-spacing: .08em;
}

.cad-brand-subtitle {
  color: #7f8da3;
  font-size: 11px;
  margin-top: 4px;
  text-transform: uppercase;
  letter-spacing: .12em;
}

.cad-nav {
  display: flex;
  flex-direction: column;
  gap: 5px;
}

.cad-nav-link {
  display: flex;
  align-items: center;
  gap: 11px;
  padding: 11px 12px;
  border-radius: 8px;
  color: #9ba9bc;
  text-decoration: none;
  font-size: 14px;
  font-weight: 600;
  transition: .15s ease;
}

.cad-nav-link:hover {
  background: #121b28;
  color: #fff;
}

.cad-nav-link.active {
  background: #162337;
  color: #fff;
  box-shadow: inset 3px 0 0 #5b8cff;
}

.cad-content {
  flex: 1;
  min-width: 0;
  padding: 24px;
}

.cad-topbar {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 15px;
  margin-bottom: 22px;
}

.cad-title {
  font-size: 25px;
  font-weight: 800;
}

.cad-subtitle {
  color: #7f8da3;
  font-size: 13px;
  margin-top: 4px;
}

.cad-actions {
  display: flex;
  gap: 8px;
  flex-wrap: wrap;
}

.cad-button {
  border: 1px solid #29364a;
  background: #111a27;
  color: #dbe5f5;
  border-radius: 7px;
  padding: 9px 13px;
  font-size: 13px;
  font-weight: 700;
  cursor: pointer;
}

.cad-button:hover {
  background: #172335;
}

.cad-button-primary {
  background: #315fc9;
  border-color: #4774dd;
  color: white;
}

.cad-button-primary:hover {
  background: #3a6de2;
}

.cad-grid {
  display: grid;
  grid-template-columns: repeat(4, minmax(0, 1fr));
  gap: 14px;
}

.cad-card {
  background: #0c131e;
  border: 1px solid #1c293a;
  border-radius: 10px;
  padding: 17px;
}

.cad-card-title {
  font-size: 13px;
  font-weight: 800;
  color: #aebbd0;
  text-transform: uppercase;
  letter-spacing: .07em;
}

.cad-stat {
  font-size: 29px;
  font-weight: 850;
  margin-top: 9px;
}

.cad-muted {
  color: #728197;
}

.cad-section-grid {
  display: grid;
  grid-template-columns: minmax(0, 1.5fr) minmax(300px, .8fr);
  gap: 16px;
  margin-top: 16px;
}

.cad-list {
  display: flex;
  flex-direction: column;
  gap: 9px;
  margin-top: 13px;
}

.cad-list-item {
  border: 1px solid #1b2737;
  background: #0a111a;
  border-radius: 8px;
  padding: 13px;
}

.cad-list-item-row {
  display: flex;
  justify-content: space-between;
  gap: 15px;
}

.cad-call-number {
  font-weight: 800;
  color: #86a9ff;
}

.cad-call-title {
  font-weight: 700;
  margin-top: 4px;
}

.cad-call-location {
  color: #8795aa;
  font-size: 12px;
  margin-top: 5px;
}

.cad-badge {
  display: inline-flex;
  align-items: center;
  border-radius: 999px;
  padding: 4px 8px;
  font-size: 10px;
  font-weight: 900;
  letter-spacing: .05em;
}

.cad-p1 {
  background: #512026;
  color: #ff9aa7;
}

.cad-p2 {
  background: #4d3b1b;
  color: #ffd37d;
}

.cad-p3 {
  background: #243c56;
  color: #94c7ff;
}

.cad-p4 {
  background: #26342d;
  color: #a6d6b5;
}

.cad-status-available {
  color: #75e19a;
}

.cad-status-busy {
  color: #ffca72;
}

.cad-status-scene {
  color: #7eb8ff;
}

.cad-status-panic {
  color: #ff7787;
  font-weight: 900;
}

.cad-table-wrapper {
  overflow-x: auto;
}

.cad-table {
  width: 100%;
  border-collapse: collapse;
  margin-top: 12px;
}

.cad-table th {
  color: #728197;
  font-size: 11px;
  text-align: left;
  text-transform: uppercase;
  padding: 10px;
  border-bottom: 1px solid #202c3d;
}

.cad-table td {
  padding: 12px 10px;
  border-bottom: 1px solid #172231;
  font-size: 13px;
}

.cad-search {
  width: 100%;
  background: #080e17;
  border: 1px solid #263448;
  border-radius: 7px;
  color: white;
  padding: 11px 12px;
  outline: none;
}

.cad-search:focus {
  border-color: #4c75d5;
}

.cad-empty {
  padding: 35px;
  text-align: center;
  color: #718096;
}

.cad-mobile-menu {
  display: none;
}

@media (max-width: 1000px) {
  .cad-sidebar {
    width: 210px;
  }

  .cad-grid {
    grid-template-columns: repeat(2, minmax(0, 1fr));
  }

  .cad-section-grid {
    grid-template-columns: 1fr;
  }
}

@media (max-width: 720px) {
  .cad-shell {
    flex-direction: column;
  }

  .cad-sidebar {
    width: 100%;
    border-right: 0;
    border-bottom: 1px solid #1c2635;
  }

  .cad-nav {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
  }

  .cad-content {
    padding: 15px;
  }

  .cad-grid {
    grid-template-columns: 1fr;
  }

  .cad-topbar {
    align-items: flex-start;
    flex-direction: column;
  }
}
'@

# ------------------------------------------------------------
# CAD LAYOUT
# ------------------------------------------------------------

Write-ProjectFile "src/app/cad/layout.tsx" @'
"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import "./cad.css";

const navigation = [
  ["Dashboard", "/cad", "▦"],
  ["Calls", "/cad/calls", "☎"],
  ["Units", "/cad/units", "●"],
  ["Persons", "/cad/persons", "♙"],
  ["Vehicles", "/cad/vehicles", "▣"],
  ["BOLOs", "/cad/bolos", "⚠"],
  ["Warrants", "/cad/warrants", "⌕"],
  ["Reports", "/cad/reports", "▤"],
  ["Settings", "/cad/settings", "⚙"],
];

export default function CadLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  const pathname = usePathname();

  return (
    <div className="cad-root">
      <div className="cad-shell">
        <aside className="cad-sidebar">
          <div className="cad-brand">
            <div className="cad-brand-title">KOD4BR CAD</div>
            <div className="cad-brand-subtitle">
              Computer Aided Dispatch
            </div>
          </div>

          <nav className="cad-nav">
            {navigation.map(([name, href, icon]) => {
              const active =
                href === "/cad"
                  ? pathname === "/cad"
                  : pathname.startsWith(href);

              return (
                <Link
                  key={href}
                  href={href}
                  className={`cad-nav-link ${
                    active ? "active" : ""
                  }`}
                >
                  <span>{icon}</span>
                  <span>{name}</span>
                </Link>
              );
            })}
          </nav>
        </aside>

        <main className="cad-content">
          {children}
        </main>
      </div>
    </div>
  );
}
'@

# ------------------------------------------------------------
# CAD DASHBOARD
# ------------------------------------------------------------

Write-ProjectFile "src/app/cad/page.tsx" @'
"use client";

import { useEffect, useState } from "react";
import Link from "next/link";
import { cadSupabase } from "@/lib/cad/supabase";
import type { CadCall, CadUnit } from "@/lib/cad/types";

export default function CadDashboard() {
  const [calls, setCalls] = useState<CadCall[]>([]);
  const [units, setUnits] = useState<CadUnit[]>([]);
  const [loading, setLoading] = useState(true);

  async function loadCad() {
    const [callsResult, unitsResult] = await Promise.all([
      cadSupabase
        .from("cad_calls")
        .select("*")
        .in("status", ["PENDING", "DISPATCHED", "ACTIVE", "ON_SCENE"])
        .order("created_at", { ascending: false })
        .limit(25),

      cadSupabase
        .from("cad_units")
        .select("*")
        .order("unit_number", { ascending: true })
        .limit(100),
    ]);

    setCalls((callsResult.data ?? []) as CadCall[]);
    setUnits((unitsResult.data ?? []) as CadUnit[]);
    setLoading(false);
  }

  useEffect(() => {
    loadCad();

    const callsChannel = cadSupabase
      .channel("cad-dashboard-calls")
      .on(
        "postgres_changes",
        {
          event: "*",
          schema: "public",
          table: "cad_calls",
        },
        () => loadCad()
      )
      .subscribe();

    const unitsChannel = cadSupabase
      .channel("cad-dashboard-units")
      .on(
        "postgres_changes",
        {
          event: "*",
          schema: "public",
          table: "cad_units",
        },
        () => loadCad()
      )
      .subscribe();

    return () => {
      cadSupabase.removeChannel(callsChannel);
      cadSupabase.removeChannel(unitsChannel);
    };
  }, []);

  const available = units.filter(
    (unit) => unit.status === "AVAILABLE"
  ).length;

  const active = units.filter(
    (unit) => unit.status !== "AVAILABLE" &&
      unit.status !== "OUT_OF_SERVICE"
  ).length;

  const panic = units.filter(
    (unit) => unit.status === "PANIC"
  ).length;

  return (
    <>
      <div className="cad-topbar">
        <div>
          <div className="cad-title">
            Dispatch Center
          </div>

          <div className="cad-subtitle">
            KOD4BR United Roleplay • Live CAD Operations
          </div>
        </div>

        <div className="cad-actions">
          <Link
            href="/cad/calls"
            className="cad-button cad-button-primary"
          >
            + New Call
          </Link>

          <Link
            href="/cad/units"
            className="cad-button"
          >
            Manage Units
          </Link>
        </div>
      </div>

      <div className="cad-grid">
        <div className="cad-card">
          <div className="cad-card-title">
            Active Calls
          </div>

          <div className="cad-stat">
            {loading ? "—" : calls.length}
          </div>
        </div>

        <div className="cad-card">
          <div className="cad-card-title">
            Available Units
          </div>

          <div className="cad-stat cad-status-available">
            {loading ? "—" : available}
          </div>
        </div>

        <div className="cad-card">
          <div className="cad-card-title">
            Busy Units
          </div>

          <div className="cad-stat cad-status-busy">
            {loading ? "—" : active}
          </div>
        </div>

        <div className="cad-card">
          <div className="cad-card-title">
            Panic
          </div>

          <div className="cad-stat cad-status-panic">
            {loading ? "—" : panic}
          </div>
        </div>
      </div>

      <div className="cad-section-grid">
        <section className="cad-card">
          <div className="cad-card-title">
            Active Calls
          </div>

          <div className="cad-list">
            {calls.length === 0 ? (
              <div className="cad-empty">
                No active calls.
              </div>
            ) : (
              calls.map((call) => (
                <Link
                  href={`/cad/calls?id=${call.id}`}
                  key={call.id}
                  className="cad-list-item"
                  style={{
                    color: "inherit",
                    textDecoration: "none",
                    display: "block",
                  }}
                >
                  <div className="cad-list-item-row">
                    <div>
                      <div className="cad-call-number">
                        #{call.call_number}
                      </div>

                      <div className="cad-call-title">
                        {call.title}
                      </div>

                      <div className="cad-call-location">
                        {call.location || "Location unavailable"}
                      </div>
                    </div>

                    <span
                      className={`cad-badge cad-${call.priority.toLowerCase()}`}
                    >
                      {call.priority}
                    </span>
                  </div>
                </Link>
              ))
            )}
          </div>
        </section>

        <section className="cad-card">
          <div className="cad-card-title">
            Unit Status
          </div>

          <div className="cad-list">
            {units.length === 0 ? (
              <div className="cad-empty">
                No units currently registered.
              </div>
            ) : (
              units.slice(0, 12).map((unit) => (
                <div
                  className="cad-list-item"
                  key={unit.id}
                >
                  <div className="cad-list-item-row">
                    <strong>
                      {unit.unit_number}
                    </strong>

                    <span
                      className={
                        unit.status === "AVAILABLE"
                          ? "cad-status-available"
                          : unit.status === "PANIC"
                          ? "cad-status-panic"
                          : unit.status === "ON_SCENE"
                          ? "cad-status-scene"
                          : "cad-status-busy"
                      }
                    >
                      {unit.status.replaceAll("_", " ")}
                    </span>
                  </div>

                  <div className="cad-call-location">
                    {unit.officer_name || "Unassigned"}
                    {" • "}
                    {unit.department_abbreviation ||
                      unit.department_name ||
                      "No department"}
                  </div>
                </div>
              ))
            )}
          </div>
        </section>
      </div>
    </>
  );
}
'@

# ------------------------------------------------------------
# CALLS
# ------------------------------------------------------------

Write-ProjectFile "src/app/cad/calls/page.tsx" @'
"use client";

import { FormEvent, useEffect, useState } from "react";
import { cadSupabase } from "@/lib/cad/supabase";
import type { CadCall } from "@/lib/cad/types";

export default function CallsPage() {
  const [calls, setCalls] = useState<CadCall[]>([]);
  const [title, setTitle] = useState("");
  const [location, setLocation] = useState("");
  const [priority, setPriority] = useState("P3");
  const [description, setDescription] = useState("");
  const [saving, setSaving] = useState(false);

  async function loadCalls() {
    const { data } = await cadSupabase
      .from("cad_calls")
      .select("*")
      .order("created_at", { ascending: false })
      .limit(100);

    setCalls((data ?? []) as CadCall[]);
  }

  useEffect(() => {
    loadCalls();

    const channel = cadSupabase
      .channel("cad-calls-page")
      .on(
        "postgres_changes",
        {
          event: "*",
          schema: "public",
          table: "cad_calls",
        },
        () => loadCalls()
      )
      .subscribe();

    return () => {
      cadSupabase.removeChannel(channel);
    };
  }, []);

  async function createCall(event: FormEvent) {
    event.preventDefault();

    if (!title.trim()) return;

    setSaving(true);

    const { error } = await cadSupabase
      .from("cad_calls")
      .insert({
        title,
        location,
        description,
        priority,
        status: "PENDING",
      });

    if (!error) {
      setTitle("");
      setLocation("");
      setDescription("");
      setPriority("P3");
      await loadCalls();
    }

    setSaving(false);
  }

  async function closeCall(id: string) {
    await cadSupabase
      .from("cad_calls")
      .update({
        status: "CLOSED",
        updated_at: new Date().toISOString(),
      })
      .eq("id", id);

    loadCalls();
  }

  return (
    <>
      <div className="cad-topbar">
        <div>
          <div className="cad-title">Calls</div>
          <div className="cad-subtitle">
            Dispatch and incident management
          </div>
        </div>
      </div>

      <section className="cad-card">
        <div className="cad-card-title">
          Create Dispatch Call
        </div>

        <form
          onSubmit={createCall}
          style={{
            display: "grid",
            gridTemplateColumns:
              "repeat(2, minmax(0, 1fr))",
            gap: 10,
            marginTop: 14,
          }}
        >
          <input
            className="cad-search"
            placeholder="Call title"
            value={title}
            onChange={(e) =>
              setTitle(e.target.value)
            }
          />

          <input
            className="cad-search"
            placeholder="Location"
            value={location}
            onChange={(e) =>
              setLocation(e.target.value)
            }
          />

          <select
            className="cad-search"
            value={priority}
            onChange={(e) =>
              setPriority(e.target.value)
            }
          >
            <option value="P1">P1 — Emergency</option>
            <option value="P2">P2 — High Priority</option>
            <option value="P3">P3 — Routine</option>
            <option value="P4">P4 — Low Priority</option>
          </select>

          <input
            className="cad-search"
            placeholder="Description"
            value={description}
            onChange={(e) =>
              setDescription(e.target.value)
            }
          />

          <button
            className="cad-button cad-button-primary"
            type="submit"
            disabled={saving}
          >
            {saving ? "Creating..." : "Create Call"}
          </button>
        </form>
      </section>

      <section
        className="cad-card"
        style={{ marginTop: 16 }}
      >
        <div className="cad-card-title">
          Call Queue
        </div>

        <div className="cad-table-wrapper">
          <table className="cad-table">
            <thead>
              <tr>
                <th>Call</th>
                <th>Priority</th>
                <th>Status</th>
                <th>Location</th>
                <th />
              </tr>
            </thead>

            <tbody>
              {calls.map((call) => (
                <tr key={call.id}>
                  <td>
                    <strong>
                      #{call.call_number}
                    </strong>
                    <br />
                    {call.title}
                  </td>

                  <td>
                    <span
                      className={`cad-badge cad-${call.priority.toLowerCase()}`}
                    >
                      {call.priority}
                    </span>
                  </td>

                  <td>
                    {call.status.replaceAll("_", " ")}
                  </td>

                  <td>
                    {call.location || "—"}
                  </td>

                  <td>
                    {call.status !== "CLOSED" &&
                      call.status !== "CANCELLED" && (
                        <button
                          className="cad-button"
                          onClick={() =>
                            closeCall(call.id)
                          }
                        >
                          Close
                        </button>
                      )}
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </section>
    </>
  );
}
'@

# ------------------------------------------------------------
# GENERIC RECORD PAGES
# ------------------------------------------------------------

Write-ProjectFile "src/app/cad/persons/page.tsx" @'
"use client";

import { useEffect, useState } from "react";
import { cadSupabase } from "@/lib/cad/supabase";

export default function PersonsPage() {
  const [search, setSearch] = useState("");
  const [persons, setPersons] = useState<any[]>([]);

  async function searchPersons(value = search) {
    if (!value.trim()) {
      setPersons([]);
      return;
    }

    const { data } = await cadSupabase
      .from("cad_persons")
      .select("*")
      .or(
        `first_name.ilike.%${value}%,last_name.ilike.%${value}%,driver_license.ilike.%${value}%`
      )
      .limit(50);

    setPersons(data ?? []);
  }

  useEffect(() => {
    const timer = setTimeout(() => {
      searchPersons();
    }, 250);

    return () => clearTimeout(timer);
  }, [search]);

  return (
    <>
      <div className="cad-topbar">
        <div>
          <div className="cad-title">Persons</div>
          <div className="cad-subtitle">
            Search citizen and subject records
          </div>
        </div>
      </div>

      <section className="cad-card">
        <input
          className="cad-search"
          placeholder="Search name or driver's license..."
          value={search}
          onChange={(e) =>
            setSearch(e.target.value)
          }
        />

        <div className="cad-table-wrapper">
          <table className="cad-table">
            <thead>
              <tr>
                <th>Name</th>
                <th>DOB</th>
                <th>Driver License</th>
                <th>Wanted</th>
              </tr>
            </thead>

            <tbody>
              {persons.map((person) => (
                <tr key={person.id}>
                  <td>
                    {person.first_name} {person.last_name}
                  </td>
                  <td>{person.date_of_birth || "—"}</td>
                  <td>{person.driver_license || "—"}</td>
                  <td>
                    {person.wanted ? "YES" : "NO"}
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>

        {!persons.length && (
          <div className="cad-empty">
            Enter a search above.
          </div>
        )}
      </section>
    </>
  );
}
'@

Write-ProjectFile "src/app/cad/vehicles/page.tsx" @'
"use client";

import { useEffect, useState } from "react";
import { cadSupabase } from "@/lib/cad/supabase";

export default function VehiclesPage() {
  const [search, setSearch] = useState("");
  const [vehicles, setVehicles] = useState<any[]>([]);

  async function searchVehicles(value = search) {
    if (!value.trim()) {
      setVehicles([]);
      return;
    }

    const { data } = await cadSupabase
      .from("cad_vehicles")
      .select("*")
      .or(
        `plate.ilike.%${value}%,vin.ilike.%${value}%,owner_name.ilike.%${value}%`
      )
      .limit(50);

    setVehicles(data ?? []);
  }

  useEffect(() => {
    const timer = setTimeout(() => {
      searchVehicles();
    }, 250);

    return () => clearTimeout(timer);
  }, [search]);

  return (
    <>
      <div className="cad-topbar">
        <div>
          <div className="cad-title">Vehicles</div>
          <div className="cad-subtitle">
            Plate and vehicle records
          </div>
        </div>
      </div>

      <section className="cad-card">
        <input
          className="cad-search"
          placeholder="Search plate, VIN, or owner..."
          value={search}
          onChange={(e) =>
            setSearch(e.target.value)
          }
        />

        <div className="cad-table-wrapper">
          <table className="cad-table">
            <thead>
              <tr>
                <th>Plate</th>
                <th>Vehicle</th>
                <th>Owner</th>
                <th>Status</th>
              </tr>
            </thead>

            <tbody>
              {vehicles.map((vehicle) => (
                <tr key={vehicle.id}>
                  <td>{vehicle.plate}</td>

                  <td>
                    {vehicle.year || ""}{" "}
                    {vehicle.make || ""}{" "}
                    {vehicle.model || ""}
                  </td>

                  <td>
                    {vehicle.owner_name || "—"}
                  </td>

                  <td>
                    {vehicle.stolen
                      ? "STOLEN"
                      : vehicle.registration_status ||
                        "VALID"}
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>

        {!vehicles.length && (
          <div className="cad-empty">
            Enter a search above.
          </div>
        )}
      </section>
    </>
  );
}
'@

Write-ProjectFile "src/app/cad/units/page.tsx" @'
"use client";

import { useEffect, useState } from "react";
import { cadSupabase } from "@/lib/cad/supabase";

export default function UnitsPage() {
  const [units, setUnits] = useState<any[]>([]);

  async function loadUnits() {
    const { data } = await cadSupabase
      .from("cad_units")
      .select("*")
      .order("unit_number");

    setUnits(data ?? []);
  }

  useEffect(() => {
    loadUnits();

    const channel = cadSupabase
      .channel("cad-units")
      .on(
        "postgres_changes",
        {
          event: "*",
          schema: "public",
          table: "cad_units",
        },
        loadUnits
      )
      .subscribe();

    return () => {
      cadSupabase.removeChannel(channel);
    };
  }, []);

  async function changeStatus(
    id: string,
    status: string
  ) {
    await cadSupabase
      .from("cad_units")
      .update({
        status,
        updated_at: new Date().toISOString(),
      })
      .eq("id", id);

    loadUnits();
  }

  return (
    <>
      <div className="cad-topbar">
        <div>
          <div className="cad-title">Units</div>
          <div className="cad-subtitle">
            Live field unit management
          </div>
        </div>
      </div>

      <section className="cad-card">
        <div className="cad-table-wrapper">
          <table className="cad-table">
            <thead>
              <tr>
                <th>Unit</th>
                <th>Officer</th>
                <th>Department</th>
                <th>Status</th>
                <th>Change</th>
              </tr>
            </thead>

            <tbody>
              {units.map((unit) => (
                <tr key={unit.id}>
                  <td>
                    <strong>{unit.unit_number}</strong>
                  </td>

                  <td>
                    {unit.officer_name || "Unassigned"}
                  </td>

                  <td>
                    {unit.department_abbreviation ||
                      unit.department_name ||
                      "—"}
                  </td>

                  <td>{unit.status.replaceAll("_", " ")}</td>

                  <td>
                    <select
                      className="cad-search"
                      value={unit.status}
                      onChange={(e) =>
                        changeStatus(
                          unit.id,
                          e.target.value
                        )
                      }
                    >
                      <option>AVAILABLE</option>
                      <option>EN_ROUTE</option>
                      <option>ON_SCENE</option>
                      <option>BUSY</option>
                      <option>TRAFFIC_STOP</option>
                      <option>TRANSPORTING</option>
                      <option>PANIC</option>
                      <option>OUT_OF_SERVICE</option>
                    </select>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </section>
    </>
  );
}
'@

# ------------------------------------------------------------
# BOLOS
# ------------------------------------------------------------

Write-ProjectFile "src/app/cad/bolos/page.tsx" @'
"use client";

import { useEffect, useState } from "react";
import { cadSupabase } from "@/lib/cad/supabase";

export default function BolosPage() {
  const [bolos, setBolos] = useState<any[]>([]);

  async function load() {
    const { data } = await cadSupabase
      .from("cad_bolos")
      .select("*")
      .eq("active", true)
      .order("created_at", { ascending: false });

    setBolos(data ?? []);
  }

  useEffect(() => {
    load();
  }, []);

  return (
    <>
      <div className="cad-topbar">
        <div>
          <div className="cad-title">BOLOs</div>
          <div className="cad-subtitle">
            Be On the Lookout records
          </div>
        </div>
      </div>

      <section className="cad-card">
        {bolos.length === 0 ? (
          <div className="cad-empty">
            No active BOLOs.
          </div>
        ) : (
          <div className="cad-list">
            {bolos.map((bolo) => (
              <div
                className="cad-list-item"
                key={bolo.id}
              >
                <div className="cad-list-item-row">
                  <strong>{bolo.title}</strong>

                  <span className="cad-badge cad-p1">
                    ACTIVE
                  </span>
                </div>

                <div className="cad-call-location">
                  {bolo.description}
                </div>
              </div>
            ))}
          </div>
        )}
      </section>
    </>
  );
}
'@

# ------------------------------------------------------------
# WARRANTS
# ------------------------------------------------------------

Write-ProjectFile "src/app/cad/warrants/page.tsx" @'
"use client";

import { useEffect, useState } from "react";
import { cadSupabase } from "@/lib/cad/supabase";

export default function WarrantsPage() {
  const [warrants, setWarrants] = useState<any[]>([]);

  async function load() {
    const { data } = await cadSupabase
      .from("cad_warrants")
      .select("*")
      .eq("active", true)
      .order("created_at", { ascending: false });

    setWarrants(data ?? []);
  }

  useEffect(() => {
    load();
  }, []);

  return (
    <>
      <div className="cad-topbar">
        <div>
          <div className="cad-title">Warrants</div>
          <div className="cad-subtitle">
            Active warrant records
          </div>
        </div>
      </div>

      <section className="cad-card">
        <div className="cad-table-wrapper">
          <table className="cad-table">
            <thead>
              <tr>
                <th>Subject</th>
                <th>Type</th>
                <th>Charge</th>
                <th>Issued</th>
              </tr>
            </thead>

            <tbody>
              {warrants.map((warrant) => (
                <tr key={warrant.id}>
                  <td>{warrant.subject_name}</td>
                  <td>{warrant.type}</td>
                  <td>{warrant.charge}</td>
                  <td>{warrant.issued_at || "—"}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>

        {!warrants.length && (
          <div className="cad-empty">
            No active warrants.
          </div>
        )}
      </section>
    </>
  );
}
'@

# ------------------------------------------------------------
# REPORTS
# ------------------------------------------------------------

Write-ProjectFile "src/app/cad/reports/page.tsx" @'
"use client";

import { useEffect, useState } from "react";
import { cadSupabase } from "@/lib/cad/supabase";

export default function ReportsPage() {
  const [reports, setReports] = useState<any[]>([]);

  useEffect(() => {
    cadSupabase
      .from("cad_reports")
      .select("*")
      .order("created_at", { ascending: false })
      .limit(100)
      .then(({ data }) => setReports(data ?? []));
  }, []);

  return (
    <>
      <div className="cad-topbar">
        <div>
          <div className="cad-title">Reports</div>
          <div className="cad-subtitle">
            Incident and field reports
          </div>
        </div>
      </div>

      <section className="cad-card">
        {reports.length === 0 ? (
          <div className="cad-empty">
            No reports have been filed.
          </div>
        ) : (
          <div className="cad-table-wrapper">
            <table className="cad-table">
              <thead>
                <tr>
                  <th>Report</th>
                  <th>Type</th>
                  <th>Author</th>
                  <th>Date</th>
                </tr>
              </thead>

              <tbody>
                {reports.map((report) => (
                  <tr key={report.id}>
                    <td>{report.report_number}</td>
                    <td>{report.type}</td>
                    <td>{report.author_name || "—"}</td>
                    <td>
                      {new Date(
                        report.created_at
                      ).toLocaleString()}
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )}
      </section>
    </>
  );
}
'@

# ------------------------------------------------------------
# SETTINGS
# ------------------------------------------------------------

Write-ProjectFile "src/app/cad/settings/page.tsx" @'
export default function CadSettingsPage() {
  return (
    <>
      <div className="cad-topbar">
        <div>
          <div className="cad-title">
            CAD Settings
          </div>

          <div className="cad-subtitle">
            System configuration and permissions
          </div>
        </div>
      </div>

      <section className="cad-grid">
        <div className="cad-card">
          <div className="cad-card-title">
            System
          </div>

          <p className="cad-muted" style={{ marginTop: 10 }}>
            KOD4BR United CAD
          </p>

          <p className="cad-muted">
            Realtime dispatch enabled.
          </p>
        </div>

        <div className="cad-card">
          <div className="cad-card-title">
            Permissions
          </div>

          <p className="cad-muted" style={{ marginTop: 10 }}>
            Permissions are controlled by CAD roles.
          </p>
        </div>

        <div className="cad-card">
          <div className="cad-card-title">
            Realtime
          </div>

          <p
            className="cad-status-available"
            style={{ marginTop: 10 }}
          >
            Supabase Realtime Ready
          </p>
        </div>

        <div className="cad-card">
          <div className="cad-card-title">
            AI
          </div>

          <p className="cad-muted" style={{ marginTop: 10 }}>
            AI services disabled.
          </p>
        </div>
      </section>
    </>
  );
}
'@

# ------------------------------------------------------------
# DATABASE SCHEMA
# ------------------------------------------------------------

Write-ProjectFile "supabase/cad-schema.sql" @'
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
'@

# ------------------------------------------------------------
# NAVBAR
# ------------------------------------------------------------

$navbarPath = Join-Path $root "src\componants\Layout\Navbar.tsx"

if (Test-Path $navbarPath) {

    $navbar = Get-Content $navbarPath -Raw

    if ($navbar -notmatch 'href="/cad"') {

        $marker = @'
          {/* REST OF NAVIGATION */}
'@

        $cadLink = @'
          {/* CAD */}

          <Link
            href="/cad"
            className={
              isActive("/cad")
                ? "active"
                : ""
            }
            onClick={closeMenus}
          >
            CAD
          </Link>


          {/* REST OF NAVIGATION */}
'@

        if ($navbar.Contains($marker)) {
            $navbar = $navbar.Replace(
                $marker,
                $cadLink
            )

            Set-Content `
                -Path $navbarPath `
                -Value $navbar `
                -Encoding UTF8

            Write-Host "Added CAD to Navbar.tsx" -ForegroundColor Green
        }
        else {
            Write-Host "Navbar marker not found. Navbar was not modified." -ForegroundColor Yellow
        }
    }
    else {
        Write-Host "CAD already exists in Navbar.tsx" -ForegroundColor Yellow
    }
}

# ------------------------------------------------------------
# CAD README
# ------------------------------------------------------------

Write-ProjectFile "CAD-SETUP.md" @'
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
'@

# ------------------------------------------------------------
# FINISH
# ------------------------------------------------------------

Write-Host ""
Write-Host "=============================================" -ForegroundColor Green
Write-Host " CAD UPGRADE COMPLETE" -ForegroundColor Green
Write-Host "=============================================" -ForegroundColor Green
Write-Host ""

Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host ""
Write-Host "1. Run the database schema in Supabase:" -ForegroundColor White
Write-Host "   supabase/cad-schema.sql" -ForegroundColor Yellow
Write-Host ""
Write-Host "2. Start the website:" -ForegroundColor White
Write-Host "   npm run dev" -ForegroundColor Yellow
Write-Host ""
Write-Host "3. Open:" -ForegroundColor White
Write-Host "   http://localhost:3000/cad" -ForegroundColor Yellow
Write-Host ""
Write-Host "4. CAD is now available from the main website header." -ForegroundColor White
Write-Host ""
Write-Host "Existing CAD backups are stored in .cad-backups" -ForegroundColor DarkGray
Write-Host ""