import Link from "next/link";
import { departments } from "@/data/departments";

export default function DepartmentsPage() {
  return (
    <main className="inner-page">
      {/* PAGE HERO */}
      <section className="page-hero">
        <div className="container">
          <p className="section-label">BOWRP ORGANIZATION</p>

          <h1>
            OUR
            <span>DEPARTMENTS.</span>
          </h1>

          <p>
            Explore the departments and opportunities available within
            Bear Open World Roleplay.
          </p>
        </div>
      </section>

      {/* DEPARTMENT DIRECTORY */}
      <section className="section">
        <div className="container">
          <div className="department-grid department-grid-large">
            {departments.map((department) => (
              <article
                className="department-card department-page-card"
                key={department.slug}
              >
                <div className="department-icon">
                  {department.icon}
                </div>

                <span className="department-code">
                  {department.abbreviation}
                </span>

                <h3>{department.name}</h3>

                <p>{department.fullDescription}</p>

                <Link
                  href={`/departments/${department.slug}`}
                  className="card-link"
                >
                  View Department →
                </Link>
              </article>
            ))}
          </div>
        </div>
      </section>

      {/* BOTTOM CTA */}
      <section className="cta-section">
        <div className="container cta-content">
          <p className="section-label">JOIN BOWRP</p>

          <h2>
            Find Your
            <span>Department.</span>
          </h2>

          <p>
            Whether you're interested in emergency services, civilian
            operations, communications, or community leadership,
            there's a place for you at BOWRP.
          </p>

          <Link
            href="/applications"
            className="button button-primary"
          >
            View Applications
          </Link>
        </div>
      </section>
    </main>
  );
}