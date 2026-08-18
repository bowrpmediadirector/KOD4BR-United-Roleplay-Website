import Link from "next/link";

export default function DocketPage() {
  return (
    <main className="inner-page">

      {/* HERO */}
      <section className="page-hero docket-hero">
        <div className="container">

          <p className="section-label">
            DISCORD • FIVE M • ER:LC • ROBLOX
          </p>

          <h1>
            Meet
            <span>Docket.</span>
          </h1>

          <p>
            Stop running five different bots that don't talk to each
            other. Docket brings your entire roleplay community
            together through one powerful dashboard.
          </p>

          <div className="docket-actions">

            <a
              href="https://docket.software/"
              target="_blank"
              rel="noopener noreferrer"
              className="button button-primary"
            >
              Start with Docket
            </a>

            <a
              href="https://discord.gg/docket"
              target="_blank"
              rel="noopener noreferrer"
              className="button button-secondary"
            >
              Join the Docket Discord
            </a>

          </div>

        </div>
      </section>


      {/* THE PROBLEM */}
      <section className="section docket-problem">

        <div className="container">

          <div className="docket-problem-content">

            <p className="section-label">
              THE PROBLEM
            </p>

            <h2>
              Tired of running
              <span>5 different bots?</span>
            </h2>

            <p className="section-text">
              One for applications. One for tickets. One for logs.
              One for giveaways. Another for something else.
            </p>

            <p className="section-text">
              And none of them know what the others did.
            </p>

            <p className="docket-highlight">
              That's the job Docket replaces.
            </p>

          </div>

        </div>

      </section>


      {/* ONE DASHBOARD */}
      <section className="section section-dark">

        <div className="container">

          <div className="section-heading">

            <div>

              <p className="section-label">
                ONE PLATFORM
              </p>

              <h2>
                Your Entire RP Community
                <span>From One Dashboard.</span>
              </h2>

            </div>

          </div>


          <div className="docket-dashboard-grid">

            <article className="docket-dashboard-card">
              <span>01</span>

              <h3>AI-Powered Applications</h3>

              <p>
                Whitelist, police, fire, and staff applications can
                be automatically read and scored by AI before staff
                even open them.
              </p>
            </article>


            <article className="docket-dashboard-card">
              <span>02</span>

              <h3>Smart Tickets</h3>

              <p>
                AI-powered support provides instant answers trained
                around your community's rules instead of generic
                responses.
              </p>
            </article>


            <article className="docket-dashboard-card">
              <span>03</span>

              <h3>Server Builder</h3>

              <p>
                Build your Discord server with channels, roles,
                rules, panels, and other community infrastructure
                through one centralized system.
              </p>
            </article>


            <article className="docket-dashboard-card">
              <span>04</span>

              <h3>Game Synchronization</h3>

              <p>
                Connect your roleplay community with supported
                FiveM and Roblox systems for automated whitelist and
                rank synchronization.
              </p>
            </article>


            <article className="docket-dashboard-card">
              <span>05</span>

              <h3>Sessions & Staff</h3>

              <p>
                Manage session RSVPs, staff shift clocks, giveaways,
                community perks, and other operational systems.
              </p>
            </article>


            <article className="docket-dashboard-card">
              <span>06</span>

              <h3>Complete Audit Trail</h3>

              <p>
                Keep your community operations organized with a
                centralized record of important activity and staff
                actions.
              </p>
            </article>

          </div>

        </div>

      </section>


      {/* APPLICATIONS */}
      <section className="section">

        <div className="container">

          <div className="section-heading">

            <div>

              <p className="section-label">
                APPLICATIONS
              </p>

              <h2>
                AI-Powered
                <span>Applications.</span>
              </h2>

            </div>

          </div>


          <div className="docket-feature-wide">

            <div className="docket-feature-number">
              01
            </div>

            <div>

              <h3>
                Applications
              </h3>

              <p>
                Automatically score whitelist, police, fire, and
                staff applications from 0–100. Docket also provides
                plagiarism detection, roleplay knowledge grading,
                and one-click approval or denial tools.
              </p>

            </div>

          </div>

        </div>

      </section>


      {/* TICKETING */}
      <section className="section section-dark">

        <div className="container">

          <div className="docket-feature-list">

            <article className="docket-feature-row">

              <div className="docket-feature-number">
                02
              </div>

              <div>

                <p className="section-label">
                  TICKETING
                </p>

                <h3>
                  Smart Tickets
                </h3>

                <p>
                  AI-powered support with instant answers trained
                  around your rules. Staff can automatically assign
                  tickets, track response times, and generate full
                  transcripts.
                </p>

              </div>

            </article>


            {/* STAFF */}

            <article className="docket-feature-row">

              <div className="docket-feature-number">
                03
              </div>

              <div>

                <p className="section-label">
                  STAFF
                </p>

                <h3>
                  Staff Management
                </h3>

                <p>
                  Leaderboards, performance tracking, promotion
                  logs, and department management help leadership
                  understand how their team is performing.
                </p>

              </div>

            </article>


            {/* ANALYTICS */}

            <article className="docket-feature-row">

              <div className="docket-feature-number">
                04
              </div>

              <div>

                <p className="section-label">
                  ANALYTICS
                </p>

                <h3>
                  Server Analytics
                </h3>

                <p>
                  Monitor member growth, ticket volume,
                  application approval rates, and staff performance
                  through one real-time dashboard.
                </p>

              </div>

            </article>

          </div>

        </div>

      </section>


      {/* FIVEM */}
      <section className="section">

        <div className="container">

          <div className="section-heading">

            <div>

              <p className="section-label">
                FIVEM
              </p>

              <h2>
                Deep FiveM
                <span>Integration.</span>
              </h2>

            </div>

          </div>


          <div className="docket-integration-grid">

            <article className="docket-integration-card">

              <span>05</span>

              <h3>
                Deep FiveM Integration
              </h3>

              <p>
                One resource install provides whitelist
                synchronization, live server status without open
                ports, in-game ban enforcement, remote dashboard
                commands, and playtime tracking.
              </p>

            </article>


            <article className="docket-integration-card">

              <span>06</span>

              <h3>
                Player ↔ Discord Linking
              </h3>

              <p>
                Players can be matched with their Discord
                automatically when joining the server, with roles
                and punishments synchronized through supported
                systems.
              </p>

            </article>

          </div>

        </div>

      </section>


      {/* ERLC */}
      <section className="section section-dark">

        <div className="container">

          <div className="section-heading">

            <div>

              <p className="section-label">
                ER:LC
              </p>

              <h2>
                ER:LC Live
                <span>Integration.</span>
              </h2>

            </div>

          </div>


          <div className="docket-erlc-card">

            <div className="docket-feature-number">
              07
            </div>

            <div>

              <h3>
                ER:LC Live Integration (Coming soon)
              </h3>

              <p>
                Connect your private server API key and monitor
                your city live. View players by team, queue
                information, join and kill logs, moderator calls,
                and available in-game commands from the dashboard.
              </p>

            </div>

          </div>

        </div>

      </section>


      {/* AI COMMUNITY ASSISTANT */}
      <section className="section">

        <div className="container two-column">

          <div>

            <p className="section-label">
              AI
            </p>

            <h2>
              Your Community's
              <span>AI Assistant.</span>
            </h2>

          </div>


          <div>

            <p className="section-text">
              Train Docket AI on your community's rules, SOPs,
              penal codes, guides, and other important information.
            </p>

            <p className="section-text">
              Members can receive instant answers to common
              questions while staff can focus their attention on
              situations that actually require human involvement.
            </p>

          </div>

        </div>

      </section>


      {/* COMMUNITY WEBSITES */}
      <section className="section section-dark">

        <div className="container">

          <div className="section-heading">

            <div>

              <p className="section-label">
                PAGES
              </p>

              <h2>
                Community
                <span>Websites.</span>
              </h2>

            </div>

          </div>


          <div className="docket-community-page">

            <div className="docket-feature-number">
              08
            </div>

            <div>

              <h3>
                Your Community. Your Brand.
              </h3>

              <p>
                Every server can have a public community page
                through Docket featuring its branding, departments,
                and live server status.
              </p>

              <div className="docket-url">
                docket.software/community/yourserver
              </div>

            </div>

          </div>

        </div>

      </section>


      {/* WHO IT IS FOR */}
      <section className="section">

        <div className="container">

          <div className="section-heading">

            <div>

              <p className="section-label">
                BUILT FOR ROLEPLAY
              </p>

              <h2>
                FiveM.
                <span>ER:LC. Roblox.</span>
              </h2>

            </div>

          </div>


          <div className="docket-platform-grid">

            <div className="docket-platform-card">
              <strong>FiveM</strong>
              <span>Roleplay Communities</span>
            </div>

            <div className="docket-platform-card">
              <strong>ER:LC</strong>
              <span>Emergency Response Communities</span>
            </div>

            <div className="docket-platform-card">
              <strong>Roblox</strong>
              <span>Roleplay Communities</span>
            </div>

          </div>

        </div>

      </section>


      {/* PRICING */}
      <section className="section section-dark">

        <div className="container docket-free">

          <p className="section-label">
            GET STARTED
          </p>

          <h2>
            Start
            <span>Free.</span>
          </h2>

          <p>
            Docket offers a free plan with no credit card required
            and no trial timer.
          </p>

          <a
            href="https://docket.software/"
            target="_blank"
            rel="noopener noreferrer"
            className="button button-primary"
          >
            Start with Docket
          </a>

        </div>

      </section>


      {/* FINAL CTA */}
      <section className="cta-section docket-mission">

        <div className="container cta-content">

          <p className="section-label">
            DOCKET SOFTWARE
          </p>

          <h2>
            Stop Managing
            <span>Five Bots.</span>
          </h2>

          <p>
            Bring your roleplay community's applications, tickets,
            staff management, analytics, integrations, and other
            systems together through Docket.
          </p>

          <div className="docket-actions">

            <a
              href="https://docket.software/"
              target="_blank"
              rel="noopener noreferrer"
              className="button button-primary"
            >
              Start Here
            </a>

            <a
              href="https://discord.gg/docket"
              target="_blank"
              rel="noopener noreferrer"
              className="button button-secondary"
            >
              Join Docket
            </a>

          </div>

        </div>

      </section>

    </main>
  );
}