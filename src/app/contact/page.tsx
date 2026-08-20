export default function ContactPage() {
  return (
    <main className="inner-page">
      <section className="page-hero">
        <div className="container">
          <p className="section-label">GET IN TOUCH</p>

          <h1>
            CONTACT
            <span>BOWRP.</span>
          </h1>

          <p>
            Need assistance or have a question? We're here to help.
          </p>
        </div>
      </section>

      <section className="section">
        <div className="container contact-grid">
          <div className="contact-info">
            <p className="section-label">CONTACT OPTIONS</p>

            <h2>
              We're Here
              <span>To Help.</span>
            </h2>

            <p>
              For the fastest response, contact the KOD4BR United Roleplay team through
              our official community Discord.
            </p>

            <a
              href="https://discord.gg/KEUekpCVqD"
              target="_blank"
              rel="noopener noreferrer"
              >
              Join Our Discord
            </a>
          </div>

          <div className="contact-card">
            <h3>Community Support</h3>

            <p>
              General questions, membership assistance, roleplay concerns,
              and community support.
            </p>

            <hr />

            <h3>Applications</h3>

            <p>
              Questions regarding department applications or staff
              opportunities.
            </p>

            <hr />

            <h3>Staff Assistance</h3>

            <p>
              Need to speak with a member of the KOD4BR United Roleplay leadership team?
              Open a support request through our community.
            </p>
          </div>
        </div>
      </section>
    </main>
  );
}