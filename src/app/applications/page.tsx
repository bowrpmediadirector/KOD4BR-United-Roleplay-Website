import Link from "next/link";

const applications = [
  {
    title: "Law Enforcement",
    description:
      "Apply to join one of our law enforcement departments.",
    icon: "🚔",
  },
  {
    title: "Fire & Rescue",
    description:
      "Join our fire and rescue operations.",
    icon: "🚒",
  },
  {
    title: "Emergency Medical Services",
    description:
      "Apply for an EMS position and provide medical roleplay.",
    icon: "🚑",
  },
  {
    title: "Communications",
    description:
      "Join communications and help coordinate emergency operations.",
    icon: "📡",
  },
  {
    title: "Staff Team",
    description:
      "Interested in helping operate and support the community?",
    icon: "⭐",
  },
];

export default function ApplicationsPage() {
  return (
    <main className="inner-page">
      <section className="page-hero">
        <div className="container">
          <p className="section-label">JOIN THE TEAM</p>

          <h1>
            K4BRURP
            <span>APPLICATIONS.</span>
          </h1>

          <p>
            Find an opportunity that fits you and become part of
            the K4BRURP community.
          </p>
        </div>
      </section>

      <section className="section">
        <div className="container">
          <div className="application-grid">
            {applications.map((application) => (
              <article
                className="application-card"
                key={application.title}
              >
                <div className="application-icon">
                  {application.icon}
                </div>

                <h3>{application.title}</h3>

                <p>{application.description}</p>

                <Link
                  href="/contact"
                  className="button button-primary"
                >
                  Apply Now
                </Link>
              </article>
            ))}
          </div>
        </div>
      </section>
    </main>
  );
}