import CADAdminSidebar from "@/components/cad/admin/CADAdminSidebar";

export default function CADAdminLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <div className="cad-admin-shell">

      <CADAdminSidebar />

      <main className="cad-admin-main">
        {children}
      </main>

    </div>
  );
}
