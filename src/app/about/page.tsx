import Link from "next/link";

export default function AboutPage() {
  return (
    <main className="inner-page">
      <section className="page-hero">
        <div className="container">
          <p className="section-label">ABOUT BOWRP</p>

          <h1>
            OUR COMMUNITY.
            <span>OUR STORY.</span>
          </h1>

          <p>
            Learn more about Bear Open World Roleplay, our history,
            our mission, and the community that makes BOWRP possible.
          </p>
        </div>
      </section>

      <section className="section">
        <div className="container two-column">
          <div>
            <p className="section-label">WHO WE ARE</p>

            <h2>
              Built Around
              <span> Community.</span>
            </h2>
          </div>

          <div className="section-text">
            <p>
              Bear Open World Roleplay is a community-driven roleplay
              organization established in 2019 with the goal of creating
              immersive and enjoyable emergency-services and civilian
              roleplay.
            </p>

            <p>
              Our community brings together players who enjoy creating
              realistic scenarios, working as a team, and building stories
              that everyone can participate in.
            </p>
          </div>
        </div>
      </section>

      <section className="section section-dark">
        <div className="container">
          <div className="section-heading">
            <div>
              <p className="section-label">OUR VALUES</p>

              <h2>
                What We
                <span> Stand For.</span>
              </h2>
            </div>
          </div>

          <div className="value-grid">
            <article className="value-card">
              <span>01</span>
              <h3>Professionalism</h3>
              <p>
                We encourage members and staff to conduct themselves
                professionally while participating in the community.
              </p>
            </article>

            <article className="value-card">
              <span>02</span>
              <h3>Realism</h3>
              <p>
                Our goal is to create believable scenarios while still
                keeping roleplay enjoyable for everyone.
              </p>
            </article>

            <article className="value-card">
              <span>03</span>
              <h3>Teamwork</h3>
              <p>
                Great roleplay depends on communication, cooperation,
                and members working together.
              </p>
            </article>

            <article className="value-card">
              <span>04</span>
              <h3>Community</h3>
              <p>
                Every member contributes to the environment and experiences
                that make BOWRP what it is.
              </p>
            </article>
          </div>
        </div>
      </section>

      <section className="cta-section">
        <div className="container cta-content">
          <p className="section-label">BECOME PART OF THE COMMUNITY</p>

          <h2>
            Your Story Starts
            <span> Here.</span>
          </h2>

          <p>
            Ready to experience Bear Open World Roleplay?
          </p>

          <Link href="/applications" className="button button-primary">
            View Applications
          </Link>
        </div>
      </section>
    </main>
  );
}