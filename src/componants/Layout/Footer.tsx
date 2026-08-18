import Link from "next/link";

const footerLinks = [
  { name: "About Us", href: "/about" },
  { name: "Departments", href: "/departments" },
  { name: "Staff Team", href: "/staff" },
  { name: "Applications", href: "/applications" },
  { name: "Community Rules", href: "/rules" },
  { name: "FAQ", href: "/faq" },
  { name: "Contact Us", href: "/contact" },
];

export default function Footer() {
  return (
    <footer className="footer">
      <div className="container footer-main">
        <div className="footer-brand">
          <Link href="/" className="footer-logo">
            <div className="footer-logo-mark">B</div>

            <div>
              <strong>BEAR OPEN WORLD</strong>
              <span>ROLEPLAY</span>
            </div>
          </Link>

          <p>
            A community-driven roleplay experience built around realism,
            professionalism, teamwork, and unforgettable stories.
          </p>

          <div className="footer-socials">
            <a href="#" target="_blank" rel="noopener noreferrer">
              Discord
            </a>

            <a href="#" target="_blank" rel="noopener noreferrer">
              YouTube
            </a>

            <a href="#" target="_blank" rel="noopener noreferrer">
              TikTok
            </a>
          </div>
        </div>

        <div className="footer-links">
          <h3>Explore</h3>

          {footerLinks.map((link) => (
            <Link key={link.name} href={link.href}>
              {link.name}
            </Link>
          ))}
        </div>

        <div className="footer-community">
          <h3>Join Our Community</h3>

          <p>
            Ready to become part of Bear Open World Roleplay?
          </p>

          <Link href="/contact" className="button button-primary">
            Join BOWRP
          </Link>
        </div>
      </div>

      <div className="footer-bottom">
        <div className="container footer-bottom-content">
          <p>
            © {new Date().getFullYear()} Bear Open World Roleplay. All rights
            reserved.
          </p>

          <div>
            <Link href="/rules">Rules</Link>
            <Link href="/contact">Contact</Link>
            <Link href="/docket">Docket Discord Bot</Link>
          </div>
        </div>
      </div>
    </footer>
  );
}