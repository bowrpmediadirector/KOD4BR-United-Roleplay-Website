import Link from "next/link";

const departments = [
  {
    name: "Law Enforcement",
    description:
      "Protect the community, respond to calls, conduct traffic enforcement, and participate in realistic patrol operations.",
    icon: "🚔",
  },
  {
    name: "Fire & Rescue",
    description:
      "Respond to fires, crashes, rescues, hazardous incidents, and other emergency situations.",
    icon: "🚒",
  },
  {
    name: "Emergency Medical Services",
    description:
      "Provide realistic emergency medical response, patient care, transportation, and hospital operations.",
    icon: "🚑",
  },
  {
    name: "Communications",
    description:
      "Coordinate emergency services, manage radio traffic, and keep responders connected during incidents.",
    icon: "📡",
  },
];

export default function Home() {
  return (
    <main>
      {/* Hero */}
      <section className="hero">
        <div className="hero-overlay">
          <div className="container hero-content">
            <p className="eyebrow">EST. 2019 • COMMUNITY-DRIVEN ROLEPLAY</p>

            <h1>
              KOD4BR UNITED
              <span>ROLEPLAY</span>
            </h1>

            <p className="hero-description">
              A professional, community-driven roleplay experience built
              around realism, teamwork, professionalism, and unforgettable
              stories.
            </p>

            <div className="hero-buttons">
              <Link href="#" className="button button-primary">
                Join Our Discord
              </Link>

              <Link href="/about" className="button button-secondary">
                Learn More
              </Link>
            </div>
          </div>
        </div>
      </section>

      {/* About */}
      <section className="section">
        <div className="container two-column">
          <div>
            <p className="section-label">WHO WE ARE</p>

            <h2>
              More Than Just
              <span> Roleplay.</span>
            </h2>
          </div>

          <div>
            <p className="section-text">
              KOD4BR United Roleplay is a community focused on creating
              realistic, immersive, and enjoyable roleplay experiences. From
              emergency services to civilian operations, every member has an
              opportunity to contribute to the story.
            </p>

            <Link href="/about" className="text-link">
              Discover Our Story →
            </Link>
          </div>
        </div>
      </section>

      {/* Departments */}
      <section className="section section-dark">
        <div className="container">
          <div className="section-heading">
            <div>
              <p className="section-label">OUR COMMUNITY</p>
              <h2>
                Find Your <span>Department</span>
              </h2>
            </div>

            <Link href="/departments" className="text-link">
              View All Departments →
            </Link>
          </div>

          <div className="department-grid">
            {departments.map((department) => (
              <article className="department-card" key={department.name}>
                <div className="department-icon">{department.icon}</div>

                <h3>{department.name}</h3>

                <p>{department.description}</p>

                <Link href="/departments" className="card-link">
                  Explore Department →
                </Link>
              </article>
            ))}
          </div>
        </div>
      </section>

      {/* Statistics */}
      <section className="stats-section">
        <div className="container stats-grid">
          <div className="stat">
            <strong>2019</strong>
            <span>Founded</span>
          </div>

          <div className="stat">
            <strong>8+</strong>
            <span>Departments</span>
          </div>

          <div className="stat">
            <strong>24/7</strong>
            <span>Community</span>
          </div>

          <div className="stat">
            <strong>∞</strong>
            <span>Possibilities</span>
          </div>
        </div>
      </section>

      {/* CTA */}
      <section className="cta-section">
        <div className="container cta-content">
          <p className="section-label">READY TO JOIN?</p>

          <h2>
            Your Story Starts
            <span> Here.</span>
          </h2>

          <p>
            Join kod4br united roleplay today and become part of a community
            dedicated to creating memorable roleplay experiences.
          </p>

          <Link href="#" className="button button-primary">
            Join KOD4BR United Roleplay
          </Link>
        </div>
      </section>
    </main>
  );
}