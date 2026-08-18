import type { Metadata } from "next";
import "./globals.css";

import Navbar from "@/componants/Layout/Navbar";
import Footer from "@/componants/Layout/Footer";

export const metadata: Metadata = {
  title: "Bear Open World Roleplay",
  description:
    "Bear Open World Roleplay — a professional, community-driven roleplay experience focused on realism, teamwork, and unforgettable stories.",
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