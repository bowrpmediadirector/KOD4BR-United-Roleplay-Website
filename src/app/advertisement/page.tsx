import Link from "next/link";

const departments = [
  {
    icon: "🚓",
    name: "Bear Capital City Police Department",
    abbreviation: "BCCPD",
    description:
      "Professional city law enforcement focused on patrol, traffic enforcement, investigations, and emergency response.",
  },
  {
    icon: "⭐",
    name: "Bear County Sheriff's Office",
    abbreviation: "BCSO",
    description:
      "County-wide law enforcement providing patrol, court security, warrant enforcement, and emergency services.",
  },
  {
    icon: "🛣️",
    name: "Bear State Patrol",
    abbreviation: "BSP",
    description:
      "State-level law enforcement focused on highways, traffic enforcement, and statewide public safety.",
  },
  {
    icon: "🔒",
    name: "State of Bear Corrections",
    abbreviation: "SBC",
    description:
      "Responsible for corrections operations, inmate security, transportation, and correctional roleplay.",
  },
  {
    icon: "🚒",
    name: "Bear Metro Fire District",
    abbreviation: "BMFD",
    description:
      "Fire and emergency services providing fire suppression, rescue operations, and emergency response.",
  },
];

const locations = [
  "New York",
  "Arkansas",
  "Missouri",
  "Wisconsin",
  "Illinois",
  "Kansas",
  "Oklahoma",
  "Alaska",
  "California",
  "Nevada",
  "Washington",
  "Florida",
  "Georgia",
];

const features = [
  {
    number: "01",
    title: "Realistic Roleplay",
    description:
      "Participate in immersive scenarios designed to create realistic and enjoyable roleplay experiences.",
  },
  {
    number: "02",
    title: "Professional Departments",
    description:
      "Join structured departments with ranks, training, leadership opportunities, and career progression.",
  },
  {
    number: "03",
    title: "Training & Development",
    description:
      "Develop your roleplay skills through department training, sessions, and development opportunities.",
  },
  {
    number: "04",
    title: "Community First",
    description:
      "Be part of a community where members, staff, and department personnel work together.",
  },
  {
    number: "05",
    title: "Whitelisted Experience",
    description:
      "Our whitelisted environment helps maintain a professional and organized roleplay experience.",
  },
  {
    number: "06",
    title: "Leadership Opportunities",
    description:
      "Build your career, earn promotions, and eventually help lead departments and the community.",
  },
];

export default function AdvertisementPage() {
  return (
    <main className="inner-page advertisement-page">

      {/* HERO */}
      <section className="advertisement-hero">
        <div className="container advertisement-hero-content">

          <p className="section-label">KOD4BR UNITED ROLEPLAY</p>

          <h1>
            ONE COMMUNITY.
            <span>ONE EXPERIENCE.</span>
          </h1>

          <p className="advertisement-lead">
            Welcome to KOD4BR United Roleplay — a professional,
            realistic, and community-driven Roblox roleplay experience
            built for players who want more from their roleplay.
          </p>

          <div className="advertisement-actions">
            <Link
              href="/applications"
              className="button button-primary"
            >
              Join KOD4BR
            </Link>

            <Link
              href="/departments"
              className="button button-secondary"
            >
              Explore Departments
            </Link>
          </div>

        </div>
      </section>

      {/* ABOUT */}
      <section className="section">
        <div className="container advertisement-intro">

          <div>
            <p className="section-label">WELCOME TO KOD4BR</p>

            <h2>
              ROLEPLAY
              <span>WITHOUT LIMITS.</span>
            </h2>
          </div>

          <div>
            <p className="section-text">
              KOD4BR United Roleplay is a growing Roblox roleplay
              community focused on professionalism, realism,
              organization, and community.
            </p>

            <p className="section-text">
              Whether you want to serve your community, respond to
              emergencies, work corrections, or simply enjoy civilian
              roleplay, KOD4BR gives you the opportunity to create
              your own roleplay story.
            </p>
          </div>

        </div>
      </section>

      {/* LOCATIONS */}
      <section className="section section-dark">
        <div className="container">

          <div className="section-heading">
            <div>
              <p className="section-label">OUR COMMUNITY</p>

              <h2>
                MULTIPLE
                <span>LOCATIONS.</span>
              </h2>
            </div>

            <p className="section-text">
              Our community supports roleplay across a growing
              selection of states and locations.
            </p>
          </div>

          <div className="location-grid">
            {locations.map((location, index) => (
              <div className="location-card" key={location}>
                <span>
                  {String(index + 1).padStart(2, "0")}
                </span>

                <strong>{location}</strong>
              </div>
            ))}
          </div>

        </div>
      </section>

      {/* DEPARTMENTS */}
      <section className="section">
        <div className="container">

          <div className="section-heading">
            <div>
              <p className="section-label">FIND YOUR CAREER</p>

              <h2>
                OUR
                <span>DEPARTMENTS.</span>
              </h2>
            </div>
          </div>

          <div className="advertisement-department-grid">
            {departments.map((department) => (
              <article
                className="advertisement-department-card"
                key={department.abbreviation}
              >
                <div className="advertisement-department-icon">
                  {department.icon}
                </div>

                <p className="department-code">
                  {department.abbreviation}
                </p>

                <h3>{department.name}</h3>

                <p>{department.description}</p>

                <Link
                  href={`/departments/${department.abbreviation
                    .toLowerCase()
                    .replace("bccpd", "bear-capital-city-police-department")
                    .replace("bcso", "bear-county-sheriffs-office")
                    .replace("bsp", "bear-state-patrol")
                    .replace("sbc", "state-of-bear-corrections")
                    .replace("bmfd", "bear-metro-fire-district")}`}
                  className="card-link"
                >
                  Explore Department →
                </Link>
              </article>
            ))}
          </div>

        </div>
      </section>

      {/* WHY JOIN */}
      <section className="section section-dark">
        <div className="container">

          <div className="section-heading">
            <div>
              <p className="section-label">WHY KOD4BR?</p>

              <h2>
                BUILT FOR
                <span>ROLEPLAYERS.</span>
              </h2>
            </div>
          </div>

          <div className="advertisement-feature-grid">
            {features.map((feature) => (
              <article
                className="advertisement-feature-card"
                key={feature.number}
              >
                <span>{feature.number}</span>

                <h3>{feature.title}</h3>

                <p>{feature.description}</p>
              </article>
            ))}
          </div>

        </div>
      </section>

      {/* ADVERTISEMENT */}
      <section className="section">
        <div className="container">

          <div className="advertisement-copy-card">

            <p className="section-label">
              SHARE KOD4BR
            </p>

            <h2>
              HELP US
              <span>GROW.</span>
            </h2>

            <p className="section-text">
              Want to advertise KOD4BR United Roleplay?
              Copy the advertisement below and share it with
              your friends, Discord communities, or YouTube audience.
            </p>

            <div className="advertisement-copy-box">

              <h3>
                🚨 KOD4BR UNITED ROLEPLAY
              </h3>

              <h4>
                One Community. One Experience. Everyone Welcome.
              </h4>

              <p>
                Looking for a professional, realistic, and
                community-driven Roblox roleplay experience?
                Welcome to KOD4BR United Roleplay — a growing
                roleplay community built around immersive scenarios,
                dedicated departments, and a community where
                everyone has a place.
              </p>

              <p>
                🌎 Multiple Locations
                <br />
                🚔 Professional Departments
                <br />
                🎮 Realistic Roleplay
                <br />
                📚 Training & Development
                <br />
                🤝 Community First
                <br />
                🏆 Leadership Opportunities
              </p>

              <p>
                Whether you want to patrol the streets, protect
                the county, respond to emergencies, work corrections,
                or enjoy civilian roleplay, there's a place for you
                in KOD4BR.
              </p>

              <strong>
                Your Roleplay. Your Career. Your Community.
              </strong>

            </div>

          </div>

        </div>
      </section>

      {/* FINAL CTA */}
      <section className="cta-section advertisement-final-cta">
        <div className="container cta-content">

          <p className="section-label">
            READY TO JOIN?
          </p>

          <h2>
            YOUR STORY
            <span>STARTS HERE.</span>
          </h2>

          <p>
            Become part of KOD4BR United Roleplay and create
            your own roleplay experience.
          </p>

          <div className="advertisement-actions">

            <Link
              href="/applications"
              className="button button-primary"
            >
              Join KOD4BR
            </Link>

            <Link
              href="/contact"
              className="button button-secondary"
            >
              Contact Us
            </Link>

          </div>

        </div>
      </section>

    </main>
  );
}