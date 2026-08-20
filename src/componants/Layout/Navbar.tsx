"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import { useState } from "react";

const departments = [
  {
    name: "Bear Capital City Police Department",
    abbreviation: "BCCPD",
    slug: "bear-capital-city-police-department",
    documents: "https://drive.google.com/",
    forms: "https://forms.google.com/",
  },
  {
    name: "Bear County Sheriff's Office",
    abbreviation: "BCSO",
    slug: "bear-county-sheriffs-office",
    documents: "https://drive.google.com/",
    forms: "https://forms.google.com/",
  },
  {
    name: "Bear State Patrol",
    abbreviation: "BSP",
    slug: "bear-state-patrol",
    documents: "https://drive.google.com/",
    forms: "https://forms.google.com/",
  },
  {
    name: "State of Bear Corrections",
    abbreviation: "SBC",
    slug: "state-of-bear-corrections",
    documents: "https://drive.google.com/",
    forms: "https://forms.google.com/",
  },
  {
    name: "Bear Metro Fire District",
    abbreviation: "BMFD",
    slug: "bear-metro-fire-district",
    documents: "https://drive.google.com/",
    forms: "https://forms.google.com/",
  },
];

const navigation = [
  { name: "Home", href: "/" },
  { name: "About", href: "/about" },
  { name: "Staff", href: "/staff" },
  { name: "Applications", href: "/applications" },
  { name: "Rules", href: "/rules" },
  { name: "Docket", href: "/docket" },
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

  const departmentsActive =
    pathname.startsWith("/departments");

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
          <div className="navbar-logo">
            B
          </div>

          <div className="navbar-brand-text">
            <strong>BEAR OPEN WORLD</strong>
            <span>ROLEPLAY</span>
          </div>
        </Link>


        {/* DESKTOP / MOBILE NAVIGATION */}

        <nav
          className={`navbar-links ${
            menuOpen ? "mobile-open" : ""
          }`}
        >

          {/* NORMAL NAVIGATION */}

          {navigation.slice(0, 2).map((item) => (
            <Link
              key={item.name}
              href={item.href}
              className={
                isActive(item.href)
                  ? "active"
                  : ""
              }
              onClick={closeMenus}
            >
              {item.name}
            </Link>
          ))}


          {/* DEPARTMENTS DROPDOWN */}

          <div
            className={`navbar-dropdown ${
              departmentsActive
                ? "active"
                : ""
            }`}
          >

            <button
              type="button"
              className={`navbar-dropdown-button ${
                departmentsActive
                  ? "active"
                  : ""
              }`}
              onClick={() =>
                setDepartmentsOpen(
                  !departmentsOpen
                )
              }
              aria-expanded={departmentsOpen}
            >
              Departments

              <span
                className={`dropdown-arrow ${
                  departmentsOpen
                    ? "open"
                    : ""
                }`}
              >
                ▾
              </span>
            </button>


            {/* DROPDOWN MENU */}

            <div
              className={`departments-dropdown ${
                departmentsOpen
                  ? "show"
                  : ""
              }`}
            >

              {/* VIEW ALL */}

              <Link
                href="/departments"
                className="department-view-all"
                onClick={closeMenus}
              >
                <div>
                  <strong>
                    View All Departments
                  </strong>

                  <span>
                    Explore every KOD4BR department
                  </span>
                </div>

                <span className="dropdown-icon">
                  →
                </span>
              </Link>


              <div className="dropdown-divider" />


              {/* DEPARTMENTS */}

              <div className="department-dropdown-list">

                {departments.map(
                  (department) => (
                    <div
                      className="department-dropdown-item"
                      key={department.slug}
                    >

                      {/* DEPARTMENT NAME */}

                      <Link
                        href={`/departments/${department.slug}`}
                        className="department-main-link"
                        onClick={closeMenus}
                      >
                        <div className="department-name">
                          <strong>
                            {department.name}
                          </strong>

                          <span>
                            {department.abbreviation}
                          </span>
                        </div>

                        <span className="department-arrow">
                          →
                        </span>
                      </Link>


                      {/* SUB LINKS */}

                      <div className="department-sub-links">

                        <Link
                          href={`/departments/${department.slug}`}
                          onClick={closeMenus}
                        >
                          Department Page
                        </Link>

                        <a
                          href={department.documents}
                          target="_blank"
                          rel="noopener noreferrer"
                        >
                          Documents
                        </a>

                        <a
                          href={department.forms}
                          target="_blank"
                          rel="noopener noreferrer"
                        >
                          Forms
                        </a>

                      </div>

                    </div>
                  )
                )}

              </div>

            </div>

          </div>


          {/* REST OF NAVIGATION */}

          {navigation.slice(2).map((item) => (
            <Link
              key={item.name}
              href={item.href}
              className={
                isActive(item.href)
                  ? "active"
                  : ""
              }
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
            menuOpen
              ? "open"
              : ""
          }`}
          aria-label="Toggle navigation menu"
          aria-expanded={menuOpen}
          onClick={() =>
            setMenuOpen(!menuOpen)
          }
        >
          <span />
          <span />
          <span />
        </button>

      </div>
    </header>
  );
}