"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import { useState } from "react";

const navigation = [
  { name: "Home", href: "/" },
  { name: "About", href: "/about" },
  { name: "Departments", href: "/departments" },
  { name: "Staff", href: "/staff" },
  { name: "Applications", href: "/applications" },
  { name: "Rules", href: "/rules" },
  { name: "Advertisement", href: "/advertisement" },
  { name: "Docket Discord Bot", href: "/docket" },
];

const departmentSections = [
  {
    title: "LAW ENFORCEMENT",
    departments: [
      {
        name: "Bear Capital City Police Department",
        href: "/departments/bear-capital-city-police-department",
      },
      {
        name: "Bear County Sheriff's Office",
        href: "/departments/bear-county-sheriffs-office",
      },
      {
        name: "Bear State Patrol",
        href: "/departments/bear-state-patrol",
      },
    ],
  },
  {
    title: "CORRECTIONS",
    departments: [
      {
        name: "State of Bear Corrections",
        href: "/departments/state-of-bear-corrections",
      },
    ],
  },
  {
    title: "FIRE & EMS",
    departments: [
      {
        name: "Bear Metro Fire District",
        href: "/departments/bear-metro-fire-district",
      },
    ],
  },
];

const documentLinks = [
  {
    name: "Department Handbooks",
    href: "YOUR_GOOGLE_DOC_URL",
  },
  {
    name: "Policies & Procedures",
    href: "YOUR_GOOGLE_DOC_URL",
  },
  {
    name: "Training Guides",
    href: "YOUR_GOOGLE_DOC_URL",
  },
  {
    name: "Department Forms",
    href: "YOUR_GOOGLE_FORM_URL",
  },
];

export default function Navbar() {
  const pathname = usePathname();

  const [menuOpen, setMenuOpen] = useState(false);
  const [departmentsOpen, setDepartmentsOpen] = useState(false);

  const isActive = (href: string) => {
    if (href === "/") {
      return pathname === "/";
    }

    return pathname.startsWith(href);
  };

  const closeMenus = () => {
    setMenuOpen(false);
    setDepartmentsOpen(false);
  };

  return (
    <header className="navbar">
      <div className="navbar-container">
        {/* BRAND */}
        <Link
          href="/"
          className="navbar-brand"
          onClick={closeMenus}
        >
          <div className="navbar-logo">B</div>

          <div className="navbar-brand-text">
            <strong>BEAR OPEN WORLD</strong>
            <span>ROLEPLAY</span>
          </div>
        </Link>

        {/* NAVIGATION */}
        <nav
          className={`navbar-links ${
            menuOpen ? "mobile-open" : ""
          }`}
        >
          {navigation.slice(0, 2).map((item) => (
            <Link
              key={item.name}
              href={item.href}
              className={isActive(item.href) ? "active" : ""}
              onClick={closeMenus}
            >
              {item.name}
            </Link>
          ))}

          {/* DEPARTMENTS DROPDOWN */}
          <div
            className={`navbar-dropdown ${
              departmentsOpen ? "dropdown-open" : ""
            }`}
          >
            <button
              type="button"
              className={`navbar-dropdown-trigger ${
                pathname.startsWith("/departments")
                  ? "active"
                  : ""
              }`}
              aria-expanded={departmentsOpen}
              onClick={() =>
                setDepartmentsOpen(!departmentsOpen)
              }
            >
              Departments
              <span className="dropdown-arrow">
                {departmentsOpen ? "▲" : "▼"}
              </span>
            </button>

            <div className="navbar-dropdown-menu">
              {/* VIEW ALL */}
              <Link
                href="/departments"
                className="dropdown-view-all"
                onClick={closeMenus}
              >
                <span className="dropdown-item-icon">▦</span>

                <span>
                  <strong>View All Departments</strong>
                  <small>
                    Explore all BOWRP departments
                  </small>
                </span>
              </Link>

              {/* DEPARTMENT SECTIONS */}
              <div className="dropdown-sections">
                {departmentSections.map((section) => (
                  <div
                    className="dropdown-section"
                    key={section.title}
                  >
                    <p>{section.title}</p>

                    {section.departments.map(
                      (department) => (
                        <Link
                          key={department.href}
                          href={department.href}
                          onClick={closeMenus}
                        >
                          {department.name}
                        </Link>
                      )
                    )}
                  </div>
                ))}
              </div>

              {/* DOCUMENTS */}
              <div className="dropdown-documents">
                <p>DEPARTMENT DOCUMENTS</p>

                <div className="dropdown-document-grid">
                  {documentLinks.map((document) => (
                    <Link
                      key={document.href}
                      href={document.href}
                      onClick={closeMenus}
                    >
                      <span>↗</span>
                      {document.name}
                    </Link>
                  ))}
                </div>
              </div>
            </div>
          </div>

          {/* REMAINING NAVIGATION */}
          {navigation.slice(2).map((item) => (
            <Link
              key={item.name}
              href={item.href}
              className={isActive(item.href) ? "active" : ""}
              onClick={closeMenus}
            >
              {item.name}
            </Link>
          ))}

          {/* JOIN */}
          <Link
            href="/contact"
            className="navbar-join"
            onClick={closeMenus}
          >
            Join Us
          </Link>
        </nav>

        {/* MOBILE MENU BUTTON */}
        <button
          type="button"
          className={`navbar-menu-button ${
            menuOpen ? "open" : ""
          }`}
          aria-label="Toggle navigation menu"
          aria-expanded={menuOpen}
          onClick={() => {
            setMenuOpen(!menuOpen);
            setDepartmentsOpen(false);
          }}
        >
          <span />
          <span />
          <span />
        </button>
      </div>
    </header>
  );
}