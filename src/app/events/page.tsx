export default function EventsPage() {
  return (
    <main className="inner-page">
      <section className="page-hero">
        <div className="container">
          <p className="section-label">COMMUNITY ACTIVITIES</p>

          <h1>
            UPCOMING
            <span>EVENTS.</span>
          </h1>

          <p>
            See what's happening throughout the Bear Open World Roleplay
            community.
          </p>
        </div>
      </section>

      <section className="section">
        <div className="container">
          <div className="empty-state">
            <span>📅</span>
            <h2>No Upcoming Events</h2>
            <p>
              Check back soon for upcoming BOWRP events and sessions.
            </p>
          </div>
        </div>
      </section>
    </main>
  );
}