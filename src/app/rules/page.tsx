const rules = [
  {
    number: "01",
    title: "Respect Everyone",
    description:
      "Treat all members, staff, and guests with respect. Harassment, bullying, discrimination, and unnecessary drama are not tolerated.",
  },
  {
    number: "02",
    title: "Remain Professional",
    description:
      "Members are expected to maintain a professional attitude while participating in official roleplay sessions.",
  },
  {
    number: "03",
    title: "Follow Roleplay Standards",
    description:
      "Remain in character and participate in realistic, reasonable scenarios.",
  },
  {
    number: "04",
    title: "No Fail Roleplay",
    description:
      "Do not intentionally perform unrealistic actions that negatively impact another player's roleplay experience.",
  },
  {
    number: "05",
    title: "Follow Staff Instructions",
    description:
      "Staff instructions during official sessions must be followed unless there is a legitimate reason to challenge the decision through the proper process.",
  },
  {
    number: "06",
    title: "No Exploiting",
    description:
      "Exploiting, abusing glitches, or intentionally manipulating the game to gain an unfair advantage is prohibited.",
  },
];

export default function RulesPage() {
  return (
    <main className="inner-page">
      <section className="page-hero">
        <div className="container">
          <p className="section-label">COMMUNITY STANDARDS</p>

          <h1>
            COMMUNITY
            <span>RULES.</span>
          </h1>

          <p>
            These standards help us maintain a professional, respectful,
            and enjoyable roleplay environment.
          </p>
        </div>
      </section>

      <section className="section">
        <div className="container rules-list">
          {rules.map((rule) => (
            <article className="rule-card" key={rule.number}>
              <span>{rule.number}</span>

              <div>
                <h3>{rule.title}</h3>
                <p>{rule.description}</p>
              </div>
            </article>
          ))}
        </div>
      </section>
    </main>
  );
}