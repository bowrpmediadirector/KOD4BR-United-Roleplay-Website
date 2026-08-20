import { NextResponse } from "next/server";

const staff = [
  {
    id: "demo-founder",
    name: "KOD4BR Founder",
    role: "Founder",
    department: "Executive Leadership",
    status: "Active",
  },
];

export async function GET() {
  return NextResponse.json(
    {
      staff,
      updatedAt: new Date().toISOString(),
    },
    {
      headers: {
        "Cache-Control": "no-store",
      },
    }
  );
}
