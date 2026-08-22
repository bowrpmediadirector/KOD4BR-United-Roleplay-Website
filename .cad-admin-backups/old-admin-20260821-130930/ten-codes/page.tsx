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

        <span>10-Codes</span>
      </div>

      <header className="cad-admin-header">

        <div>

          <span className="cad-admin-kicker">
            ADMINISTRATION
          </span>

          <h1>
            🔢 10-Codes
          </h1>

          <p>
            Manage radio 10-codes used by your community.
          </p>

        </div>

      </header>

      <div className="cad-admin-workspace">

        <div className="cad-admin-empty-icon">
          🔢
        </div>

        <h2>
          10-Codes
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
