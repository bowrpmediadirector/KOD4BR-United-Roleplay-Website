# ============================================================
# KOD4BR UNITED ROLEPLAY
# STAFF CAD ADMINISTRATION - COMPLETE REPAIR
# ============================================================

$ErrorActionPreference = "Stop"

$root = Get-Location

Write-Host ""
Write-Host "=============================================" -ForegroundColor Red
Write-Host " KOD4BR UNITED - STAFF CAD ADMIN REPAIR" -ForegroundColor White
Write-Host "=============================================" -ForegroundColor Red
Write-Host ""

# ------------------------------------------------------------
# VERIFY NEXT.JS PROJECT
# ------------------------------------------------------------

if (!(Test-Path "$root\package.json")) {
    Write-Host "ERROR: package.json was not found." -ForegroundColor Red
    Write-Host "Run this script from your Next.js website root." -ForegroundColor Yellow
    exit 1
}

# ------------------------------------------------------------
# CREATE DIRECTORIES
# ------------------------------------------------------------

$adminPath = "$root\src\app\cad\staff\administration"
$adminModulePath = "$adminPath\page.module.css"

New-Item -ItemType Directory -Force -Path $adminPath | Out-Null

# ------------------------------------------------------------
# ADMINISTRATION PAGE
# ------------------------------------------------------------

$page = @'
"use client";

import Link from "next/link";
import styles from "./page.module.css";

const adminSections = [
  {
    category: "ACCOUNTS",
    items: [
      {
        icon: "👤",
        title: "Accounts",
        description: "Manage CAD accounts, staff accounts, and user access.",
        href: "/cad/staff/administration/accounts",
      },
      {
        icon: "🪪",
        title: "Identifiers",
        description: "Manage usernames, identifiers, badges, and account identifiers.",
        href: "/cad/staff/administration/identifiers",
      },
      {
        icon: "🔑",
        title: "Permission Keys",
        description: "Create and manage permission keys and administrative access.",
        href: "/cad/staff/administration/permission-keys",
      },
    ],
  },
  {
    category: "CUSTOMIZATION",
    items: [
      {
        icon: "🖌️",
        title: "Customization",
        description: "Customize CAD appearance, branding, and system preferences.",
        href: "/cad/staff/administration/customization",
      },
      {
        icon: "📋",
        title: "Custom Records",
        description: "Create and manage custom record types and fields.",
        href: "/cad/staff/administration/custom-records",
      },
      {
        icon: "🛡️",
        title: "Departments",
        description: "Manage Police, Sheriff, Fire, EMS, Dispatch, DOC, and Staff departments.",
        href: "/cad/staff/administration/departments",
      },
      {
        icon: "🔢",
        title: "10-Codes",
        description: "Manage department 10-codes and radio terminology.",
        href: "/cad/staff/administration/10-codes",
      },
      {
        icon: "⚖️",
        title: "Penal Codes",
        description: "Manage laws, charges, citations, and penal codes.",
        href: "/cad/staff/administration/penal-codes",
      },
    ],
  },
  {
    category: "ADVANCED",
    items: [
      {
        icon: "↩️",
        title: "Logs",
        description: "Review administrative activity and system audit logs.",
        href: "/cad/staff/administration/logs",
      },
      {
        icon: "📈",
        title: "AI Usage",
        description: "View CAD AI usage and system statistics.",
        href: "/cad/staff/administration/ai-usage",
      },
      {
        icon: "🎮",
        title: "In-Game Integration",
        description: "Configure Roblox and in-game CAD integrations.",
        href: "/cad/staff/administration/in-game-integration",
      },
      {
        icon: "🤖",
        title: "Discord Integration",
        description: "Configure Discord roles, synchronization, and bot integration.",
        href: "/cad/staff/administration/discord-integration",
      },
      {
        icon: "⌛",
        title: "Limits",
        description: "Configure CAD account, record, and system limits.",
        href: "/cad/staff/administration/limits",
      },
      {
        icon: "🗄️",
        title: "Wipe Records",
        description: "Manage record deletion and database cleanup tools.",
        href: "/cad/staff/administration/wipe-records",
        danger: true,
      },
      {
        icon: "🔑",
        title: "Change Community ID",
        description: "Change the community identifier associated with this CAD.",
        href: "/cad/staff/administration/change-community-id",
        danger: true,
      },
      {
        icon: "🔒",
        title: "Authenticate",
        description: "Manage administrator authentication and security.",
        href: "/cad/staff/administration/authenticate",
      },
      {
        icon: "🗑️",
        title: "Transfer or Delete CAD",
        description: "Transfer ownership or permanently delete this CAD installation.",
        href: "/cad/staff/administration/transfer-delete",
        danger: true,
      },
    ],
  },
];

export default function StaffAdministrationPage() {
  return (
    <div className={styles.page}>
      <div className={styles.backgroundGlow} />

      <header className={styles.header}>
        <div className={styles.headerLeft}>
          <Link href="/cad/staff" className={styles.backButton}>
            ← Staff CAD
          </Link>

          <div className={styles.titleArea}>
            <div className={styles.eyebrow}>
              KOD4BR UNITED ROLEPLAY
            </div>

            <h1>Staff Administration</h1>

            <p>
              Manage your KOD4BR United CAD system, departments,
              accounts, permissions, integrations, and system settings.
            </p>
          </div>
        </div>

        <div className={styles.status}>
          <span className={styles.statusDot} />
          CAD ONLINE
        </div>
      </header>

      <main className={styles.content}>
        <div className={styles.breadcrumb}>
          <Link href="/cad">CAD</Link>
          <span>/</span>
          <Link href="/cad/staff">Staff</Link>
          <span>/</span>
          <strong>Administration</strong>
        </div>

        {adminSections.map((section) => (
          <section
            className={styles.section}
            key={section.category}
          >
            <div className={styles.sectionHeader}>
              <div>
                <span>{section.category}</span>
                <h2>
                  {section.category === "ACCOUNTS"
                    ? "Account Management"
                    : section.category === "CUSTOMIZATION"
                    ? "CAD Customization"
                    : "Advanced Administration"}
                </h2>
              </div>

              <div className={styles.sectionLine} />
            </div>

            <div className={styles.grid}>
              {section.items.map((item) => (
                <Link
                  href={item.href}
                  key={item.title}
                  className={`${styles.card} ${
                    item.danger ? styles.danger : ""
                  }`}
                >
                  <div className={styles.cardIcon}>
                    {item.icon}
                  </div>

                  <div className={styles.cardContent}>
                    <h3>{item.title}</h3>
                    <p>{item.description}</p>
                  </div>

                  <div className={styles.arrow}>
                    →
                  </div>
                </Link>
              ))}
            </div>
          </section>
        ))}

        <section className={styles.infoBox}>
          <div className={styles.infoIcon}>🛡️</div>

          <div>
            <h3>Administrator Access</h3>

            <p>
              These tools are intended for authorized KOD4BR United
              Roleplay staff administrators. Changes made here may
              affect the entire CAD system and connected departments.
            </p>
          </div>
        </section>
      </main>
    </div>
  );
}
'@

Set-Content `
    -Path "$adminPath\page.tsx" `
    -Value $page `
    -Encoding UTF8

# ------------------------------------------------------------
# ADMINISTRATION CSS MODULE
# ------------------------------------------------------------

$css = @'
.page {
  min-height: 100vh;
  position: relative;
  overflow-x: hidden;
  background:
    radial-gradient(
      circle at 85% 10%,
      rgba(220, 25, 35, 0.10),
      transparent 30%
    ),
    #0b0d10;
  color: #ffffff;
}

.backgroundGlow {
  position: fixed;
  inset: 0;
  pointer-events: none;
  background:
    linear-gradient(
      135deg,
      rgba(255,255,255,0.015),
      transparent 40%
    );
}

.header {
  position: relative;
  z-index: 2;
  display: flex;
  align-items: flex-start;
  justify-content: space-between;
  gap: 30px;
  padding: 42px 50px;
  border-bottom: 1px solid rgba(255,255,255,0.08);
  background: rgba(10,12,15,0.96);
}

.headerLeft {
  min-width: 0;
}

.backButton {
  display: inline-flex;
  align-items: center;
  margin-bottom: 25px;
  color: #a7adb7;
  text-decoration: none;
  font-size: 13px;
  font-weight: 700;
  transition: 0.2s ease;
}

.backButton:hover {
  color: #ffffff;
}

.titleArea {
  max-width: 850px;
}

.eyebrow {
  margin-bottom: 8px;
  color: #e31b23;
  font-size: 11px;
  font-weight: 900;
  letter-spacing: 0.18em;
}

.titleArea h1 {
  margin: 0;
  font-size: clamp(32px, 5vw, 54px);
  line-height: 1.05;
  letter-spacing: -0.04em;
}

.titleArea p {
  max-width: 750px;
  margin: 16px 0 0;
  color: #949ba6;
  font-size: 15px;
  line-height: 1.7;
}

.status {
  display: flex;
  align-items: center;
  gap: 9px;
  flex-shrink: 0;
  margin-top: 5px;
  padding: 9px 14px;
  border: 1px solid rgba(255,255,255,0.10);
  border-radius: 999px;
  background: rgba(255,255,255,0.025);
  color: #ffffff;
  font-size: 10px;
  font-weight: 900;
  letter-spacing: 0.1em;
}

.statusDot {
  width: 7px;
  height: 7px;
  border-radius: 50%;
  background: #22c55e;
  box-shadow: 0 0 12px rgba(34,197,94,0.7);
}

.content {
  position: relative;
  z-index: 1;
  max-width: 1450px;
  margin: 0 auto;
  padding: 28px 50px 70px;
}

.breadcrumb {
  display: flex;
  align-items: center;
  gap: 8px;
  margin-bottom: 45px;
  color: #6f7783;
  font-size: 12px;
}

.breadcrumb a {
  color: #9299a5;
  text-decoration: none;
}

.breadcrumb a:hover {
  color: #ffffff;
}

.breadcrumb strong {
  color: #ffffff;
}

.section {
  margin-bottom: 48px;
}

.sectionHeader {
  display: flex;
  align-items: center;
  gap: 20px;
  margin-bottom: 18px;
}

.sectionHeader span {
  display: block;
  margin-bottom: 5px;
  color: #e31b23;
  font-size: 10px;
  font-weight: 900;
  letter-spacing: 0.17em;
}

.sectionHeader h2 {
  margin: 0;
  color: #ffffff;
  font-size: 21px;
  letter-spacing: -0.02em;
}

.sectionLine {
  flex: 1;
  height: 1px;
  background: rgba(255,255,255,0.07);
}

.grid {
  display: grid;
  grid-template-columns: repeat(3, minmax(0, 1fr));
  gap: 16px;
}

.card {
  position: relative;
  display: flex;
  align-items: flex-start;
  gap: 16px;
  min-height: 145px;
  padding: 23px;
  overflow: hidden;
  border: 1px solid rgba(255,255,255,0.08);
  border-radius: 10px;
  background: rgba(20,23,28,0.94);
  color: inherit;
  text-decoration: none;
  transition:
    transform 0.2s ease,
    border-color 0.2s ease,
    background 0.2s ease;
}

.card::before {
  content: "";
  position: absolute;
  left: 0;
  top: 0;
  bottom: 0;
  width: 3px;
  background: transparent;
  transition: 0.2s ease;
}

.card:hover {
  transform: translateY(-3px);
  border-color: rgba(227,27,35,0.45);
  background: rgba(27,30,36,1);
}

.card:hover::before {
  background: #e31b23;
}

.cardIcon {
  display: grid;
  place-items: center;
  width: 48px;
  height: 48px;
  min-width: 48px;
  border: 1px solid rgba(227,27,35,0.18);
  border-radius: 9px;
  background: rgba(227,27,35,0.09);
  font-size: 21px;
}

.cardContent {
  min-width: 0;
  padding-right: 20px;
}

.cardContent h3 {
  margin: 2px 0 0;
  color: #ffffff;
  font-size: 15px;
  font-weight: 800;
}

.cardContent p {
  margin: 9px 0 0;
  color: #858d99;
  font-size: 12px;
  line-height: 1.65;
}

.arrow {
  position: absolute;
  right: 20px;
  bottom: 17px;
  color: #e31b23;
  font-size: 17px;
  font-weight: 800;
  transition: 0.2s ease;
}

.card:hover .arrow {
  transform: translateX(4px);
}

.danger {
  border-color: rgba(220, 38, 38, 0.12);
}

.danger:hover {
  border-color: rgba(220, 38, 38, 0.5);
}

.danger .cardIcon {
  border-color: rgba(220,38,38,0.22);
  background: rgba(220,38,38,0.10);
}

.infoBox {
  display: flex;
  align-items: flex-start;
  gap: 16px;
  margin-top: 15px;
  padding: 22px;
  border: 1px solid rgba(255,255,255,0.07);
  border-radius: 10px;
  background: rgba(255,255,255,0.025);
}

.infoIcon {
  font-size: 23px;
}

.infoBox h3 {
  margin: 0;
  color: #ffffff;
  font-size: 14px;
}

.infoBox p {
  max-width: 900px;
  margin: 7px 0 0;
  color: #858d99;
  font-size: 12px;
  line-height: 1.7;
}

@media (max-width: 1100px) {
  .grid {
    grid-template-columns: repeat(2, minmax(0, 1fr));
  }

  .header {
    padding: 35px;
  }

  .content {
    padding-left: 35px;
    padding-right: 35px;
  }
}

@media (max-width: 700px) {
  .header {
    display: block;
    padding: 28px 20px;
  }

  .status {
    display: inline-flex;
    margin-top: 25px;
  }

  .content {
    padding: 24px 20px 50px;
  }

  .grid {
    grid-template-columns: 1fr;
  }

  .sectionHeader {
    display: block;
  }

  .sectionLine {
    margin-top: 14px;
  }

  .titleArea h1 {
    font-size: 34px;
  }
}
'@

Set-Content `
    -Path $adminModulePath `
    -Value $css `
    -Encoding UTF8

# ------------------------------------------------------------
# CREATE ALL ADMIN ROUTES
# ------------------------------------------------------------

$routes = @(
    "accounts",
    "identifiers",
    "permission-keys",
    "customization",
    "custom-records",
    "departments",
    "10-codes",
    "penal-codes",
    "logs",
    "ai-usage",
    "in-game-integration",
    "discord-integration",
    "limits",
    "wipe-records",
    "change-community-id",
    "authenticate",
    "transfer-delete"
)

foreach ($route in $routes) {

    $routePath = "$adminPath\$route"

    New-Item `
        -ItemType Directory `
        -Force `
        -Path $routePath | Out-Null

    $routeTitle = ($route -replace "-", " ")

    $routeTitle = (Get-Culture).TextInfo.ToTitleCase($routeTitle)

    $routePage = @"
"use client";

import Link from "next/link";
import styles from "../page.module.css";

export default function AdministrationToolPage() {
  return (
    <div className={styles.page}>
      <div className={styles.backgroundGlow} />

      <header className={styles.header}>
        <div className={styles.headerLeft}>
          <Link
            href="/cad/staff/administration"
            className={styles.backButton}
          >
            ← Staff Administration
          </Link>

          <div className={styles.titleArea}>
            <div className={styles.eyebrow}>
              KOD4BR UNITED STAFF CAD
            </div>

            <h1>$routeTitle</h1>

            <p>
              KOD4BR United Roleplay CAD administration.
              This section is ready for configuration and database integration.
            </p>
          </div>
        </div>

        <div className={styles.status}>
          <span className={styles.statusDot} />
          CAD ONLINE
        </div>
      </header>

      <main className={styles.content}>
        <div className={styles.breadcrumb}>
          <Link href="/cad">CAD</Link>
          <span>/</span>
          <Link href="/cad/staff">Staff</Link>
          <span>/</span>
          <Link href="/cad/staff/administration">
            Administration
          </Link>
          <span>/</span>
          <strong>$routeTitle</strong>
        </div>

        <section className={styles.infoBox}>
          <div className={styles.infoIcon}>🛠️</div>

          <div>
            <h3>$routeTitle</h3>

            <p>
              The page is connected to the Staff Administration
              system and is no longer a 404 route. Database-backed
              controls can be added to this section without changing
              the navigation structure.
            </p>
          </div>
        </section>
      </main>
    </div>
  );
}
"@

    Set-Content `
        -Path "$routePath\page.tsx" `
        -Value $routePage `
        -Encoding UTF8
}

# ------------------------------------------------------------
# ADMIN ALIAS ROUTE
# ------------------------------------------------------------

$adminAliasPath = "$root\src\app\cad\staff\admin"

New-Item `
    -ItemType Directory `
    -Force `
    -Path $adminAliasPath | Out-Null

$aliasPage = @'
import { redirect } from "next/navigation";

export default function AdminAliasPage() {
  redirect("/cad/staff/administration");
}
'@

Set-Content `
    -Path "$adminAliasPath\page.tsx" `
    -Value $aliasPage `
    -Encoding UTF8

# ------------------------------------------------------------
# CLEAN NEXT CACHE
# ------------------------------------------------------------

if (Test-Path "$root\.next") {
    Write-Host "Removing Next.js build cache..." -ForegroundColor Yellow

    Remove-Item `
        -Recurse `
        -Force `
        "$root\.next"
}

# ------------------------------------------------------------
# COMPLETE
# ------------------------------------------------------------

Write-Host ""
Write-Host "=============================================" -ForegroundColor Green
Write-Host " STAFF ADMINISTRATION HAS BEEN REBUILT" -ForegroundColor Green
Write-Host "=============================================" -ForegroundColor Green
Write-Host ""
Write-Host "Main page:" -ForegroundColor Cyan
Write-Host "/