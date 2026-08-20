const questions = [
  {
    question: "What is kod4br united roleplay?",
    answer:
      "KOD4BR United Roleplay is a community-driven roleplay organization focused on realistic, immersive, and enjoyable experiences.",
  },
  {
    question: "How do I join KOD4BR United Roleplay?",
    answer:
      "Join our community through Discord and follow the application process for the department or position you are interested in.",
  },
  {
    question: "Do I need experience to join?",
    answer:
      "Experience requirements may vary depending on the department or position. Training is available for members who qualify.",
  },
  {
    question: "Is KOD4BR United Roleplay free to join?",
    answer:
      "Community membership and participation are generally free unless a specific activity or service states otherwise.",
  },
  {
    question: "How do I contact staff?",
    answer:
      "You can contact the KOD4BR United Roleplay team through our community Discord or the Contact Us page.",
  },
];

export default function FAQPage() {
  return (
    <main className="inner-page">
      <section className="page-hero">
        <div className="container">
          <p className="section-label">NEED HELP?</p>

          <h1>
            FREQUENTLY ASKED
            <span>QUESTIONS.</span>
          </h1>

          <p>
            Find answers to some of the most common questions about KOD4BR United Roleplay.
          </p>
        </div>
      </section>

      <section className="section">
        <div className="container faq-list">
          {questions.map((item) => (
            <details className="faq-item" key={item.question}>
              <summary>{item.question}</summary>
              <p>{item.answer}</p>
            </details>
          ))}
        </div>
      </section>
    </main>
  );
}