$ErrorActionPreference = "Stop"

Write-Host ""
Write-Host "============================================" -ForegroundColor Red
Write-Host " KOD4BR UNITED CAD LAYOUT REPAIR" -ForegroundColor White
Write-Host "============================================" -ForegroundColor Red
Write-Host ""

$root = Get-Location

$layoutDir = Join-Path $root "src\components\cad"
$layoutFile = Join-Path $layoutDir "CADPanelLayout.tsx"

if (!(Test-Path "$root\package.json")) {
    Write-Host "ERROR: package.json was not found." -ForegroundColor Red
    Write-Host ""
    Write-Host "Run this from:" -ForegroundColor Yellow
    Write-Host "C:\Users\austi\Desktop\k4brunitedroleplay\k4brunitedroleplay-official-website"
    exit 1
}

New-Item -ItemType Directory -Force -Path $layoutDir | Out-Null

# ============================================================
# REPLACE CORRUPTED CAD PANEL LAYOUT
# ============================================================

$layout = @'
"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import type { CADPanelDefinition } from "@/lib/cad/config";

interface CADPanelLayoutProps {
  panel: CADPanelDefinition;
  children: React.ReactNode;
}

const links = [
  {
    name: "Dashboard",
    suffix: "",
  },
  {
    name: "Calls",
    suffix: "/calls",
  },
  {
    name: "Units",
    suffix: "/units",
  },
  {
    name: "Persons",
    suffix: "/persons",
  },
  {
    name: "Vehicles",
    suffix: "/vehicles",
  },
  {
    name: "Reports",
    suffix: "/reports",
  },
  {
    name: "BOLOs",
    suffix: "/bolos",
  },
  {
    name: "Warrants",
    suffix: "/warrants",
  },
];

export default function CADPanelLayout({
  panel,
  children,
}: CADPanelLayoutProps) {
  const pathname = usePathname();

  return (
    <div className="cad-shell">
      <aside className="cad-sidebar">

        <Link
          href="/cad"
          className="cad-sidebar-brand"
        >
          <span className="cad-brand-icon">
            B
          </span>

          <span>
            <strong>KOD4BR</strong>
            <small>UNITED CAD</small>
          </span>
        </Link>

        <div className="cad-panel-heading">
          <span className="cad-panel-icon">
            {panel.icon}
          </span>

          <div>
            <strong>{panel.name}</strong>

            <small>
              {panel.shortName}
            </small>
          </div>
        </div>

        <nav className="cad-sidebar-nav">
          {links.map((link) => {
            const href =
              `/cad/${panel.id}${link.suffix}`;

            const active =
              link.suffix === ""
                ? pathname === href
                : pathname.startsWith(href);

            return (
              <Link
                key={link.name}
                href={href}
                className={active ? "active" : ""}
              >
                {link.name}
              </Link>
            );
          })}
        </nav>

        {panel.id === "staff" && (
          <Link
            href="/cad/staff/administration"
            className={
              pathname.startsWith(
                "/cad/staff/administration"
              )
                ? "active"
                : ""
            }
          >
            Administration
          </Link>
        )}

        <Link
          href="/cad"
          className="cad-back"
        >
          ← All CAD Panels
        </Link>

      </aside>

      <main className="cad-main">

        <div className="cad-mobile-header">

          <Link href="/cad">
            ← CAD
          </Link>

          <span>
            {panel.icon} {panel.name}
          </span>

        </div>

        {children}

      </main>
    </div>
  );
}
'@

Set-Content `
    -Path $layoutFile `
    -Value $layout `
    -Encoding UTF8

Write-Host "Fixed:" -ForegroundColor Green
Write-Host $layoutFile

# ============================================================
# CREATE A CLEAN STAFF ADMINISTRATION PAGE
# ============================================================

$adminDir = Join-Path `
    $root `
    "src\app\cad\staff\administration"

New-Item `
    -ItemType Directory `
    -Force `
    -Path $adminDir | Out-Null

$adminPage = @'
"use client";

import Link from "next/link";
import CADPanelLayout from "@/components/cad/CADPanelLayout";
import { CAD_PANELS } from "@/lib/cad/config";

const panel = CAD_PANELS.find(
  (item) => item.id === "staff"
)!;

const sections = [
  {
    title: "Accounts",
    items: [
      ["👤", "Accounts", "Manage CAD accounts.", "accounts"],
      ["🪪", "Identifiers", "Manage identifiers.", "identifiers"],
      ["🔑", "Permission Keys", "Manage permission keys.", "permission-keys"],
    ],
  },
  {
    title: "Customization",
    items: [
      ["🖌️", "Customization", "Customize the CAD system.", "customization"],
      ["📋", "Custom Records", "Manage custom records.", "custom-records"],
      ["🛡️", "Departments", "Manage CAD departments.", "departments"],
      ["🔢", "10-Codes", "Manage radio 10-codes.", "10-codes"],
      ["⚖️", "Penal Codes", "Manage penal codes.", "penal-codes"],
    ],
  },
  {
    title: "Advanced",
    items: [
      ["↩️", "Logs", "View administrative logs.", "logs"],
      ["📈", "AI Usage", "View AI usage.", "ai-usage"],
      ["🎮", "In-Game Integration", "Manage game integration.", "in-game-integration"],
      ["🤖", "Discord Integration", "Manage Discord integration.", "discord-integration"],
      ["⌛", "Limits", "Manage system limits.", "limits"],
      ["🗄️", "Wipe Records", "Manage record deletion.", "wipe-records"],
      ["🔑", "Change Community ID", "Change community ID.", "change-community-id"],
      ["🔒", "Authenticate", "Manage authentication.", "authenticate"],
      ["🗑️", "Transfer or Delete CAD", "Transfer or delete CAD.", "transfer-delete"],
    ],
  },
];

export default function StaffAdministrationPage() {
  return (
    <CADPanelLayout panel={panel}>

      <div className="cad-page-header">

        <div>

          <div className="cad-kicker">
            KOD4BR UNITED STAFF CAD
          </div>

          <h1>
            Administration
          </h1>

          <p>
            Manage accounts, permissions, departments,
            integrations, records, and CAD settings.
          </p>

        </div>

        <div className="cad-status">
          <span className="cad-status-dot" />
          CAD ONLINE
        </div>

      </div>

      {sections.map((section) => (

        <section
          className="cad-section"
          key={section.title}
        >

          <div className="cad-section-title">

            <span>
              STAFF ADMINISTRATION
            </span>

            <h2>
              {section.title}
            </h2>

          </div>

          <div className="cad-feature-grid">

            {section.items.map(
              ([icon, title, description, route]) => (

                <Link
                  key={title}
                  href={`/cad/staff/administration/${route}`}
                  className="cad-feature-card"
                >

                  <span className="cad-feature-icon">
                    {icon}
                  </span>

                  <div>

                    <strong>
                      {title}
                    </strong>

                    <p>
                      {description}
                    </p>

                  </div>

                  <span className="cad-feature-arrow">
                    →
                  </span>

                </Link>

              )
            )}

          </div>

        </section>

      ))}

      <div className="cad-home-footer">

        <strong>
          KOD4BR United Roleplay
        </strong>

        <span>
          Staff CAD Administration
        </span>

      </div>

    </CADPanelLayout>
  );
}
'@

$adminFile = Join-Path $adminDir "page.tsx"

Set-Content `
    -Path $adminFile `
    -Value $adminPage `
    -Encoding UTF8

Write-Host "Fixed:" -ForegroundColor Green
Write-Host $adminFile

# ============================================================
# REMOVE NEXT CACHE
# ============================================================

$nextDir = Join-Path $root ".next"

if (Test-Path $nextDir) {

    Write-Host ""
    Write-Host "Removing .next cache..." -ForegroundColor Yellow

    Remove-Item `
        -Recurse `
        -Force `
        $nextDir
}

# ============================================================
# RUN TYPESCRIPT CHECK
# ============================================================

Write-Host ""
Write-Host "Running TypeScript check..." -ForegroundColor Cyan
Write-Host ""

if (Test-Path "$root\node_modules\.bin\tsc.cmd") {

    & "$root\node_modules\.bin\tsc.cmd" `
        --noEmit

    if ($LASTEXITCODE -ne 0) {

        Write-Host ""
        Write-Host "There are still TypeScript errors." -ForegroundColor Red
        Write-Host "The CADPanelLayout corruption has been removed," -ForegroundColor Yellow
        Write-Host "but another file may still contain an error." -ForegroundColor Yellow

    } else {

        Write-Host ""
        Write-Host "TypeScript check PASSED." -ForegroundColor Green
    }

} else {

    Write-Host "TypeScript executable not found. Skipping check." -ForegroundColor Yellow
}

Write-Host ""
Write-Host "============================================" -ForegroundColor Green
Write-Host " CAD REPAIR COMPLETE" -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Green
Write-Host ""
Write-Host "Now run:" -ForegroundColor Yellow
Write-Host ""
Write-Host "npm run dev" -ForegroundColor White
Write-Host ""
Write-Host "Then open:" -ForegroundColor Yellow
Write-Host ""
Write-Host "http://localhost:3000/cad/staff/administration" -ForegroundColor White
Write-Host ""