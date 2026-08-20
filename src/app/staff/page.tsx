"use client";

import { useEffect, useState } from "react";

type StaffMember = {
  id: string;
  name: string;
  role: string;
  department: string;
  avatar?: string;
  status?: string;
};

export default function StaffPage() {
  const [staff, setStaff] = useState<StaffMember[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    async function loadStaff() {
      try {
        const response = await fetch("/api/staff", {
          cache: "no-store",
        });

        if (!response.ok) {
          throw new Error("Failed to load staff");
        }

        const data = await response.json();
        setStaff(data.staff ?? []);
      } catch (error) {
        console.error("Failed to load staff:", error);
        setStaff([]);
      } finally {
        setLoading(false);
      }
    }

    loadStaff();
  }, []);

  return (
    <main className="inner-page">
      <section className="page-hero">
        <div className="container">
          <p className="section-label">MEET THE TEAM</p>

          <h1>
            KOD4BR
            <span>STAFF TEAM.</span>
          </h1>

          <p>
            Meet the people who help operate, manage, and support
            KOD4BR United Roleplay.
          </p>
        </div>
      </section>

      <section className="section">
        <div className="container">
          {loading ? (
            <div className="staff-loading">
              Loading staff members...
            </div>
          ) : staff.length === 0 ? (
            <div className="staff-loading">
              No staff members are currently available.
            </div>
          ) : (
            <div className="staff-grid">
              {staff.map((member) => (
                <article className="staff-card" key={member.id}>
                  <div className="staff-avatar">
                    {member.avatar ? (
                      <img
                        src={member.avatar}
                        alt={member.name}
                      />
                    ) : (
                      member.name.charAt(0).toUpperCase()
                    )}
                  </div>

                  <div className="staff-info">
                    <span>{member.department}</span>

                    <h3>{member.name}</h3>

                    <p>{member.role}</p>

                    {member.status && (
                      <small>{member.status}</small>
                    )}
                  </div>
                </article>
              ))}
            </div>
          )}
        </div>
      </section>
    </main>
  );
}
