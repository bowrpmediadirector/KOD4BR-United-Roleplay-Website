const staff = [
  // =========================
  // EXECUTIVE LEADERSHIP
  // =========================

  {
    name: "Your Name",
    role: "Founder",
    department: "Executive Leadership",
  },

  {
    name: "Staff Member",
    role: "Chief Executive Officer",
    department: "Executive Leadership",
  },

  // =========================
  // EXECUTIVE ADMINISTRATION
  // =========================

  {
    name: "Staff Member",
    role: "Chief Administrative Officer",
    department: "Executive Administration",
  },

  {
    name: "Staff Member",
    role: "Administrator",
    department: "Executive Administration",
  },

  // =========================
  // PROFESSIONAL STANDARDS
  // =========================

  {
    name: "Staff Member",
    role: "Director of Professional Standards",
    department: "Professional Standards",
  },

  {
    name: "Staff Member",
    role: "Internal Affairs Investigator",
    department: "Professional Standards",
  },

  // =========================
  // OPERATIONS COMMAND
  // =========================

  {
    name: "Staff Member",
    role: "Chief of Operations",
    department: "Operations Command",
  },

  {
    name: "Staff Member",
    role: "Operations Supervisor",
    department: "Operations Command",
  },

  // =========================
  // TRAINING & DEVELOPMENT
  // =========================

  {
    name: "Staff Member",
    role: "Director of Training & Development",
    department: "Training & Development",
  },

  {
    name: "Staff Member",
    role: "Senior Instructor",
    department: "Training & Development",
  },

  // =========================
  // COMMUNITY RELATIONS
  // =========================

  {
    name: "Staff Member",
    role: "Director of Community Relations",
    department: "Community Relations",
  },

  {
    name: "Staff Member",
    role: "Community Relations Officer",
    department: "Community Relations",
  },

  // =========================
  // MEDIA & CREATIVE SERVICES
  // =========================

  {
    name: "Staff Member",
    role: "Director of Media",
    department: "Media & Creative Services",
  },

  {
    name: "Staff Member",
    role: "Content Creator",
    department: "Media & Creative Services",
  },

  // =========================
  // TECHNOLOGY & DEVELOPMENT
  // =========================

  {
    name: "Staff Member",
    role: "Chief Technology Officer",
    department: "Technology & Development",
  },

  {
    name: "Staff Member",
    role: "Bot Developer",
    department: "Technology & Development",
  },

  // =========================
  // MODERATION TEAM
  // =========================

  {
    name: "Staff Member",
    role: "Director of Moderation",
    department: "Moderation Team",
  },

  {
    name: "Staff Member",
    role: "Senior Moderator",
    department: "Moderation Team",
  },

  {
    name: "Staff Member",
    role: "Moderator",
    department: "Moderation Team",
  },

  {
    name: "Staff Member",
    role: "Trial Moderator",
    department: "Moderation Team",
  },
];

export default function StaffPage() {
  return (
    <main className="inner-page">
      <section className="page-hero">
        <div className="container">
          <p className="section-label">MEET THE TEAM</p>

          <h1>
            K4BURP
            <span>STAFF TEAM.</span>
          </h1>

          <p>
            Meet the people who help operate, manage, and support
            K4BURP United Roleplay.
          </p>
        </div>
      </section>

      <section className="section">
        <div className="container">
          <div className="staff-grid">
            {staff.map((member, index) => (
              <article
                className="staff-card"
                key={`${member.role}-${index}`}
              >
                <div className="staff-avatar">
                  {member.name.charAt(0).toUpperCase()}
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