const staff = [
  {
    name: "Community Founder",
    role: "Founder",
    department: "Executive Administration",
  },
  {
    name: "Community Leadership",
    role: "Community Director",
    department: "Executive Administration",
  },
  {
    name: "Staff Leadership",
    role: "Staff Director",
    department: "Staff Administration",
  },
  {
    name: "Department Leadership",
    role: "Department Director",
    department: "Department Operations",
  },
];

export default function StaffPage() {
  return (
    <main className="inner-page">
      <section className="page-hero">
        <div className="container">
          <p className="section-label">MEET THE TEAM</p>

          <h1>
            BOWRP
            <span>STAFF TEAM.</span>
          </h1>

          <p>
            Meet the people who help operate, manage, and support
            Bear Open World Roleplay.
          </p>
        </div>
      </section>

      <section className="section">
        <div className="container">
          <div className="staff-grid">
            {staff.map((member) => (
              <article className="staff-card" key={member.role}>
                <div className="staff-avatar">
                  {member.name.charAt(0)}
                </div>

                <div className="staff-info">
                  <span>{member.department}</span>

                  <h3>{member.name}</h3>

                  <p>{member.role}</p>
                </div>
              </article>
            ))}
          </div>
        </div>
      </section>
    </main>
  );
}