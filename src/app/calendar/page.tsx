import Link from "next/link";
import { calendarEvents } from "@/data/calendar";

export default function CalendarPage() {
  const sessions = calendarEvents.filter(
    (event) => event.type === "session"
  );

  const developmentDays = calendarEvents.filter(
    (event) => event.type === "development"
  );

  const otherEvents = calendarEvents.filter(
    (event) =>
      event.type !== "session" &&
      event.type !== "development"
  );

  return (
    <main className="inner-page">
      {/* HERO */}
      <section className="page-hero calendar-hero">
        <div className="container">
          <p className="section-label">BOWRP SCHEDULE</p>

          <h1>
            Community
            <span>Calendar.</span>
          </h1>

          <p>
            Stay up to date with Bear Open World Roleplay sessions,
            development days, meetings, and community events.
          </p>
        </div>
      </section>

      {/* CALENDAR INFORMATION */}
      <section className="section">
        <div className="container">
          <div className="section-heading">
            <div>
              <p className="section-label">
                UPCOMING DATES
              </p>

              <h2>
                BOWRP
                <span>Schedule.</span>
              </h2>
            </div>
          </div>

          {/* SESSION EVENTS */}
          <div className="calendar-category">
            <div className="calendar-category-header">
              <div>
                <p className="calendar-category-label">
                  ROLEPLAY
                </p>

                <h3>Sessions</h3>
              </div>

              <span className="calendar-count">
                {sessions.length}
              </span>
            </div>

            <div className="calendar-event-list">
              {sessions.length > 0 ? (
                sessions.map((event) => (
                  <article
                    className="calendar-event"
                    key={event.id}
                  >
                    <div className="calendar-event-date">
                      <strong>
                        {new Date(
                          `${event.date}T12:00:00`
                        ).toLocaleDateString("en-US", {
                          month: "short",
                        })}
                      </strong>

                      <span>
                        {new Date(
                          `${event.date}T12:00:00`
                        ).getDate()}
                      </span>
                    </div>

                    <div className="calendar-event-content">
                      <span className="calendar-event-type session">
                        ROLEPLAY SESSION
                      </span>

                      <h3>{event.title}</h3>

                      <p>{event.description}</p>

                      <div className="calendar-event-meta">
                        {event.time && (
                          <span>🕐 {event.time}</span>
                        )}

                        {event.location && (
                          <span>📍 {event.location}</span>
                        )}
                      </div>
                    </div>
                  </article>
                ))
              ) : (
                <div className="calendar-empty">
                  No upcoming sessions scheduled.
                </div>
              )}
            </div>
          </div>

          {/* DEVELOPMENT */}
          <div className="calendar-category">
            <div className="calendar-category-header">
              <div>
                <p className="calendar-category-label">
                  DEVELOPMENT
                </p>

                <h3>Development Days</h3>
              </div>

              <span className="calendar-count">
                {developmentDays.length}
              </span>
            </div>

            <div className="calendar-event-list">
              {developmentDays.length > 0 ? (
                developmentDays.map((event) => (
                  <article
                    className="calendar-event"
                    key={event.id}
                  >
                    <div className="calendar-event-date">
                      <strong>
                        {new Date(
                          `${event.date}T12:00:00`
                        ).toLocaleDateString("en-US", {
                          month: "short",
                        })}
                      </strong>

                      <span>
                        {new Date(
                          `${event.date}T12:00:00`
                        ).getDate()}
                      </span>
                    </div>

                    <div className="calendar-event-content">
                      <span className="calendar-event-type development">
                        DEVELOPMENT
                      </span>

                      <h3>{event.title}</h3>

                      <p>{event.description}</p>

                      <div className="calendar-event-meta">
                        {event.time && (
                          <span>🕐 {event.time}</span>
                        )}

                        {event.location && (
                          <span>📍 {event.location}</span>
                        )}
                      </div>
                    </div>
                  </article>
                ))
              ) : (
                <div className="calendar-empty">
                  No development days scheduled.
                </div>
              )}
            </div>
          </div>

          {/* OTHER EVENTS */}
          {otherEvents.length > 0 && (
            <div className="calendar-category">
              <div className="calendar-category-header">
                <div>
                  <p className="calendar-category-label">
                    COMMUNITY
                  </p>

                  <h3>Other Events</h3>
                </div>

                <span className="calendar-count">
                  {otherEvents.length}
                </span>
              </div>

              <div className="calendar-event-list">
                {otherEvents.map((event) => (
                  <article
                    className="calendar-event"
                    key={event.id}
                  >
                    <div className="calendar-event-date">
                      <strong>
                        {new Date(
                          `${event.date}T12:00:00`
                        ).toLocaleDateString("en-US", {
                          month: "short",
                        })}
                      </strong>

                      <span>
                        {new Date(
                          `${event.date}T12:00:00`
                        ).getDate()}
                      </span>
                    </div>

                    <div className="calendar-event-content">
                      <span className="calendar-event-type">
                        COMMUNITY EVENT
                      </span>

                      <h3>{event.title}</h3>

                      <p>{event.description}</p>

                      <div className="calendar-event-meta">
                        {event.time && (
                          <span>🕐 {event.time}</span>
                        )}

                        {event.location && (
                          <span>📍 {event.location}</span>
                        )}
                      </div>
                    </div>
                  </article>
                ))}
              </div>
            </div>
          )}
        </div>
      </section>

      {/* CTA */}
      <section className="cta-section">
        <div className="container cta-content">
          <p className="section-label">
            STAY INVOLVED
          </p>

          <h2>
            Be Part of
            <span>K4BRURP.</span>
          </h2>

          <p>
            Keep an eye on the calendar so you never miss an
            upcoming session, development day, or community event.
          </p>

          <Link
            href="/departments"
            className="button button-primary"
          >
            Explore Departments
          </Link>
        </div>
      </section>
    </main>
  );
}