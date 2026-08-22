import Link from "next/link";

export default function Page() {
  return (
    <main className="min-h-screen bg-background p-8">
      <div className="mx-auto max-w-5xl">
        <Link href="/cad" className="text-sm text-primary">
          ← CAD Dashboard
        </Link>

        <h1 className="mt-3 text-3xl font-bold">
          Warrants
        </h1>

        <div className="mt-6 rounded-xl border bg-card p-8">
          <h2 className="text-xl font-semibold">
            Warrant Management Ready
          </h2>

          <p className="mt-2 text-sm text-muted-foreground">
            Warrant records, subjects, charges, issuing agencies,
            status, and service information are supported.
          </p>
        </div>
      </div>
    </main>
  );
}
