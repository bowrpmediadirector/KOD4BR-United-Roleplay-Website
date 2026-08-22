"use client";

import Link from "next/link";

export default function AdminSectionPage() {
  return (
    <div className="cad-admin-section-page">

      <div className="cad-admin-breadcrumb">
        <Link href="/cad/admin">
          CAD Administration
        </Link>

        <span> / </span>

        <span>In-Game Integration</span>
      </div>

      <header className="cad-admin-header">

        <div>

          <span className="cad-admin-kicker">
            ADMINISTRATION
          </span>

          <h1>
            🎮 In-Game Integration
          </h1>

          <p>
            Manage Roblox and ER:LC integration settings.
          </p>

        </div>

      </header>

      <div className="cad-admin-workspace">

        <div className="cad-admin-empty-icon">
          🎮
        </div>

        <h2>
          In-Game Integration
        </h2>

        <p>
          This administrative module is ready for
          Supabase-backed data and permissions.
        </p>

        <div className="cad-admin-module-status">
          <span />
          MODULE READY
        </div>

      </div>

    </div>
  );
}
