import Link from "next/link";
import { notFound } from "next/navigation";
import { departments, getDepartment } from "@/data/departments";

interface DepartmentPageProps {
  params: Promise<{
    department: string;
  }>;
}

export function generateStaticParams() {
  return departments.map((department) => ({
    department: department.slug,
  }));
}

export default async function DepartmentPage({
  params,
}: DepartmentPageProps) {
  const { department: slug } = await params;

  const department = getDepartment(slug);

  if (!department) {
    notFound();
  }

  return (
    <main className="inner-page">
      {/* HERO */}
      <section className="department-detail-hero">
        <div className="container">
          <Link href="/departments" className="back-link">
            ← Back to Departments
          </Link>

          <div className="department-detail-icon">
            {department.icon}
          </div>

          <p className="section-label">{department.category}</p>

          <h1>
            {department.name}
            <span>{department.abbreviation}</span>
          </h1>

          <p className="department-detail-description">
            {department.fullDescription}
          </p>

          <div className="department-detail-actions">
            <Link
              href="/applications"
              className="button button-primary"
            >
              Apply to Join
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

      {/* RESPONSIBILITIES */}
      <section className="section">
        <div className="container">
          <div className="section-heading">
            <div>
              <p className="section-label">WHAT WE DO</p>

              <h2>
                Department <span>Responsibilities.</span>
              </h2>
            </div>
          </div>

          <div className="responsibility-grid">
            {department.responsibilities.map(
              (responsibility, index) => (
                <article
                  className="responsibility-card"
                  key={`${responsibility}-${index}`}
                >
                  <span>
                    {String(index + 1).padStart(2, "0")}
                  </span>

                  <h3>{responsibility}</h3>
                </article>
              )
            )}
          </div>
        </div>
      </section>

      {/* RANK STRUCTURE */}
      <section className="section section-dark">
        <div className="container">
          <p className="section-label">ORGANIZATION</p>

          <h2>
            Rank <span>Structure.</span>
          </h2>

          <div className="rank-list">
            {department.ranks.map((rank, index) => (
              <div
                className="rank-item"
                key={`${rank}-${index}`}
              >
                <span>
                  {String(index + 1).padStart(2, "0")}
                </span>

                <strong>{rank}</strong>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* REQUIREMENTS */}
      <section className="section">
        <div className="container two-column">
          <div>
            <p className="section-label">BEFORE APPLYING</p>

            <h2>
              Membership <span>Requirements.</span>
            </h2>
          </div>

          <div className="requirements-list">
            {department.requirements.map(
              (requirement, index) => (
                <div
                  className="requirement-item"
                  key={`${requirement}-${index}`}
                >
                  <span>✓</span>

                  <p>{requirement}</p>
                </div>
              )
            )}
          </div>
        </div>
      </section>

      {/* CTA */}
      <section className="cta-section">
        <div className="container cta-content">
          <p className="section-label">READY TO JOIN?</p>

          <h2>
            Start Your <span>Career.</span>
          </h2>

          <p>
            Become part of {department.name} and help create
            the next K4BRURP story.
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