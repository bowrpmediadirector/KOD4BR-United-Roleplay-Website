import Link from "next/link";

export default function NotFound() {
  return (
    <main className="not-found-page">
      <div className="not-found-container">
        <div className="not-found-code">404</div>

        <p className="section-label">PAGE NOT FOUND</p>

        <h1>
          Looks Like You&apos;re
          <span>Lost.</span>
        </h1>

        <p className="not-found-description">
          The page you are looking for doesn&apos;t exist, may have been
          moved, or is no longer available. Let&apos;s get you back to
          Bear Open World Roleplay.
        </p>

        <div className="not-found-actions">
          <Link href="/" className="button button-primary">
            Return Home
          </Link>

          <Link href="/departments" className="button button-secondary">
            View Departments
          </Link>
        </div>
      </div>
    </main>
  );
}