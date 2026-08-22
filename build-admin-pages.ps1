$ErrorActionPreference = "Stop"

Write-Host ""
Write-Host "=============================================" -ForegroundColor Red
Write-Host " KOD4BR UNITED - ADMINISTRATION PAGE BUILDER" -ForegroundColor White
Write-Host "=============================================" -ForegroundColor Red
Write-Host ""

$root = Get-Location

if (!(Test-Path "$root\package.json")) {
    Write-Host "ERROR: package.json not found." -ForegroundColor Red
    Write-Host "Run this script from your Next.js website root." -ForegroundColor Yellow
    exit 1
}

$adminRoot = Join-Path $root "src\app\cad\staff\administration"

New-Item `
    -ItemType Directory `
    -Force `
    -Path $adminRoot | Out-Null

# ============================================================
# ADMINISTRATION PAGES
# ============================================================

$pages = @(
    @{
        Route = "accounts"
        Title = "Accounts"
        Icon = "👤"
        Description = "Create, manage, suspend, and review CAD user accounts."
        Status = "ACCOUNT MANAGEMENT"
    },
    @{
        Route = "identifiers"
        Title = "Identifiers"
        Icon = "🪪"
        Description = "Manage usernames, badges, identifiers, and CAD account identifiers."
        Status = "IDENTIFIER MANAGEMENT"
    },
    @{
        Route = "permission-keys"
        Title = "Permission Keys"
        Icon = "🔑"
        Description = "Manage administrative permission keys and access levels."
        Status = "PERMISSIONS"
    },
    @{
        Route = "customization"
        Title = "Customization"
        Icon = "🖌️"
        Description = "Customize the appearance and configuration of the KOD4BR United CAD."
        Status = "CAD CUSTOMIZATION"
    },
    @{
        Route = "custom-records"
        Title = "Custom Records"
        Icon = "📋"
        Description = "Create and manage custom CAD record types and fields."
        Status = "CUSTOM RECORDS"
    },
    @{
        Route = "departments"
        Title = "Departments"
        Icon = "🛡️"
        Description = "Manage Police, Sheriff, Fire, EMS, Dispatch, DOC, and Staff CAD departments."
        Status = "DEPARTMENT MANAGEMENT"
    },
    @{
        Route = "10-codes"
        Title = "10-Codes"
        Icon = "🔢"
        Description = "Manage department radio 10-codes and communications terminology."
        Status = "RADIO CODES"
    },
    @{
        Route = "penal-codes"
        Title = "Penal Codes"
        Icon = "⚖️"
        Description = "Manage laws, charges, citations, and penal code information."
        Status = "PENAL CODE MANAGEMENT"
    },
    @{
        Route = "logs"
        Title = "Logs"
        Icon = "↩️"
        Description = "Review administrative actions and CAD system audit logs."
        Status = "SYSTEM LOGS"
    },
    @{
        Route = "ai-usage"
        Title = "AI Usage"
        Icon = "📈"
        Description = "Review CAD AI usage, requests, and system statistics."
        Status = "AI SYSTEM"
    },
    @{
        Route = "in-game-integration"
        Title = "In-Game Integration"
        Icon = "🎮"
        Description = "Configure integration between the CAD and the KOD4BR roleplay game environment."
        Status = "GAME INTEGRATION"
    },
    @{
        Route = "discord-integration"
        Title = "Discord Integration"
        Icon = "🤖"
        Description = "Configure Discord roles, synchronization, notifications, and bot integration."
        Status = "DISCORD INTEGRATION"
    },
    @{
        Route = "limits"
        Title = "Limits"
        Icon = "⌛"
        Description = "Configure CAD account, record, API, and system limits."
        Status = "SYSTEM LIMITS"
    },
    @{
        Route = "wipe-records"
        Title = "Wipe Records"
        Icon = "🗄️"
        Description = "Manage record deletion and controlled CAD database cleanup."
        Status = "RECORD MANAGEMENT"
    },
    @{
        Route = "change-community-id"
        Title = "Change Community ID"
        Icon = "🔑"
        Description = "Change the community identifier associated with this CAD installation."
        Status = "COMMUNITY SETTINGS"
    },
    @{
        Route = "authenticate"
        Title = "Authenticate"
        Icon = "🔒"
        Description = "Manage administrator authentication and security settings."
        Status = "SECURITY"
    },
    @{
        Route = "transfer-delete"
        Title = "Transfer or Delete CAD"
        Icon = "🗑️"
        Description = "Transfer CAD ownership or permanently remove the CAD installation."
        Status = "DANGEROUS ACTIONS"
    }
)

# ============================================================
# CREATE EACH PAGE
# ============================================================

foreach ($page in $pages) {

    $routePath = Join-Path `
        $adminRoot `
        $page.Route

    New-Item `
        -ItemType Directory `
        -Force `
        -Path $routePath | Out-Null

    $title = $page.Title
    $icon = $page.Icon
    $description = $page.Description
    $status = $page.Status

    $content = @"
"use client";

import Link from "next/link";
import CADPanelLayout from "@/components/cad/CADPanelLayout";
import { CAD_PANELS } from "@/lib/cad/config";

const panel = CAD_PANELS.find(
  (item) => item.id === "staff"
)!;

export default function AdministrationPage() {
  return (
    <CADPanelLayout panel={panel}>

      <div className="cad-page-header">

        <div>

          <div className="cad-kicker">
            KOD4BR UNITED STAFF CAD
          </div>

          <h1>
            $icon $title
          </h1>

          <p>
            $description
          </p>

        </div>

        <div className="cad-status">
          <span className="cad-status-dot" />
          CAD ONLINE
        </div>

      </div>

      <div className="cad-breadcrumb">
        <Link href="/cad">
          CAD
        </Link>

        <span>/</span>

        <Link href="/cad/staff">
          Staff
        </Link>

        <span>/</span>

        <Link href="/cad/staff/administration">
          Administration
        </Link>

        <span>/</span>

        <strong>
          $title
        </strong>
      </div>

      <section className="cad-section">

        <div className="cad-section-title">

          <span>
            $status
          </span>

          <h2>
            $title
          </h2>

        </div>

        <div className="cad-admin-tool-panel">

          <div className="cad-admin-tool-icon">
            $icon
          </div>

          <div className="cad-admin-tool-content">

            <h3>
              $title
            </h3>

            <p>
              $description
            </p>

            <div className="cad-admin-tool-status">
              Administration module ready
            </div>

          </div>

        </div>

      </section>

      <section className="cad-section">

        <div className="cad-section-title">

          <span>
            ADMINISTRATION
          </span>

          <h2>
            Quick Navigation
          </h2>

        </div>

        <div className="cad-feature-grid">

          <Link
            href="/cad/staff/administration"
            className="cad-feature-card"
          >

            <span className="cad-feature-icon">
              ⚙️
            </span>

            <div>

              <strong>
                Administration
              </strong>

              <p>
                Return to Staff Administration.
              </p>

            </div>

            <span className="cad-feature-arrow">
              →
            </span>

          </Link>

          <Link
            href="/cad/staff"
            className="cad-feature-card"
          >

            <span className="cad-feature-icon">
              🛡️
            </span>

            <div>

              <strong>
                Staff Dashboard
              </strong>

              <p>
                Return to the Staff CAD dashboard.
              </p>

            </div>

            <span className="cad-feature-arrow">
              →
            </span>

          </Link>

          <Link
            href="/cad"
            className="cad-feature-card"
          >

            <span className="cad-feature-icon">
              🏠
            </span>

            <div>

              <strong>
                All CAD Panels
              </strong>

              <p>
                Return to the main CAD panel selection.
              </p>

            </div>

            <span className="cad-feature-arrow">
              →
            </span>

          </Link>

        </div>

      </section>

    </CADPanelLayout>
  );
}
"@

    $file = Join-Path $routePath "page.tsx"

    Set-Content `
        -Path $file `
        -Value $content `
        -Encoding UTF8

    Write-Host "Created /cad/staff/administration/$($page.Route)" -ForegroundColor Green
}

# ============================================================
# MAKE SURE ADMINISTRATION DASHBOARD EXISTS
# ============================================================

$dashboard = Join-Path $adminRoot "page.tsx"

if (!(Test-Path $dashboard)) {
    Write-Host ""
    Write-Host "WARNING: Administration dashboard was missing." -ForegroundColor Yellow
    Write-Host "The individual pages were still created." -ForegroundColor Yellow
}

# ============================================================
# CLEAR NEXT CACHE
# ============================================================

$nextCache = Join-Path $root ".next"

if (Test-Path $nextCache) {

    Write-Host ""
    Write-Host "Clearing Next.js cache..." -ForegroundColor Yellow

    Remove-Item `
        -Recurse `
        -Force `
        $nextCache
}

# ============================================================
# SUMMARY
# ============================================================

Write-Host ""
Write-Host "=============================================" -ForegroundColor Green
Write-Host " ALL ADMINISTRATION ROUTES CREATED" -ForegroundColor Green
Write-Host "=============================================" -ForegroundColor Green
Write-Host ""

foreach ($page in $pages) {
    Write-Host "/cad/staff/administration/$($page.Route)"
}

Write-Host ""
Write-Host "Now run:" -ForegroundColor Yellow
Write-Host ""
Write-Host "npm run dev" -ForegroundColor White
Write-Host ""
Write-Host "Then open:" -ForegroundColor Yellow
Write-Host ""
Write-Host "http://localhost:3000/cad/staff/administration" -ForegroundColor White
Write-Host ""