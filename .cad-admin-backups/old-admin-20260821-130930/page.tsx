"use client";

import Link from "next/link";
import { ADMIN_NAVIGATION } from "@/lib/cad/admin/navigation";

const cards = [
  {
    title: "Accounts",
    description: "Manage CAD users and account access.",
    href: "/cad/admin/accounts",
    icon: "👤",
  },
  {
    title: "Departments",
    description: "Manage Police, Sheriff, Fire, EMS, DOC and other departments.",
    href: "/cad/admin/departments",
    icon: "🛡️",
  },
  {
    title: "Permissions",
    description: "Control administrator and department permissions.",
    href: "/cad/admin/permission-keys",
    icon: "🔑",
  },
  {
    title: "Integrations",
    description: "Manage Discord and in-game integrations.",
    href: "/cad/admin/discord",
    icon: "🤖",
  },
  {
    title: "Logs",
    description: "Review administrative activity.",
    href: "/cad/admin/logs",
    icon: "📋",
  },
  {
    title: "System Settings",
    description: "Configure authentication, limits and customization.",
    href: "/cad/admin/customization",
    icon: "⚙️",
  },
];

export default function CADAdminPage() {
  return (
    <div>

      <header className="cad-admin-header">

        <div>
          <span className="cad-admin-kicker">
            KOD4BR UNITED ROLEPLAY
          </span>

          <h1>
            CAD Administration
          </h1>

          <p>
            Manage your CAD community, users, departments,
            permissions, integrations and system settings.
          </p>
        </div>

        <div className="cad-admin-status">
          <span />
          ADMIN SYSTEM ONLINE
        </div>

      </header>

      <section className="cad-admin-warning">
        <div>
          <strong>Administrative Access</strong>

          <p>
            This area contains sensitive CAD configuration and
            management tools. All administrative activity should
            be considered logged and auditable.
          </p>
        </div>
      </section>

      <section>

        <div className="cad-admin-section-heading">
          <span>OVERVIEW</span>
          <h2>Administration Center</h2>
        </div>

        <div className="cad-admin-card-grid">

          {cards.map((card) => (
            <Link
              href={card.href}
              key={card.href}
              className="cad-admin-card"
            >
              <div className="cad-admin-card-icon">
                {card.icon}
              </div>

              <div>
                <h3>{card.title}</h3>
                <p>{card.description}</p>
              </div>

              <span className="cad-admin-card-arrow">
                →
              </span>
            </Link>
          ))}

        </div>

      </section>

      <section className="cad-admin-quick-section">

        <div className="cad-admin-section-heading">
          <span>CONFIGURATION</span>
          <h2>System Controls</h2>
        </div>

        <div className="cad-admin-quick-grid">

          {ADMIN_NAVIGATION.flatMap(
            (section) => section.items
          ).slice(0, 9).map((item) => (
            <Link
              href={item.href}
              key={item.href}
              className={
                item.danger
                  ? "cad-admin-quick danger"
                  : "cad-admin-quick"
              }
            >
              <span>{item.icon}</span>
              {item.name}
            </Link>
          ))}

        </div>

      </section>

    </div>
  );
}
