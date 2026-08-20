export default function AnnouncementsPage() {
  return (
    <main className="inner-page">
      <section className="page-hero">
        <div className="container">
          <p className="section-label">STAY INFORMED</p>

          <h1>
            COMMUNITY
            <span>ANNOUNCEMENTS.</span>
          </h1>

          <p>
            Keep up with the latest K4BRURP news, updates, and important
            community information.
          </p>
        </div>
      </section>

      <section className="section">
        <div className="container">
          <div className="empty-state">
            <span>📢</span>
            <h2>No Announcements Yet</h2>
            <p>
              New community announcements will appear here.
            </p>
          </div>
        </div>
      </section>
    </main>
  );
}