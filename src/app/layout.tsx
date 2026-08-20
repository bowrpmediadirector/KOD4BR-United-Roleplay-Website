import type { Metadata } from "next";
import "./globals.css";

import Navbar from "@/componants/Layout/Navbar";
import Footer from "@/componants/Layout/Footer";

export const metadata: Metadata = {
  title: "KOD4BR United Roleplay",
  description:
    "kod4br united roleplay — a professional, community-driven roleplay experience focused on realism, teamwork, and unforgettable stories.",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en">
      <body>
        <Navbar />
        {children}
        <Footer />
      </body>
    </html>
  );
}