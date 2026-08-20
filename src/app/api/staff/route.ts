import { NextResponse } from "next/server";
import { createClient } from "@supabase/supabase-js";

const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL!,
  process.env.SUPABASE_SERVICE_ROLE_KEY!
);

export async function GET() {
  const { data, error } = await supabase
    .from("staff")
    .select("*")
    .order("priority", { ascending: true });

  if (error) {
    console.error("Staff API error:", error);

    return NextResponse.json(
      {
        error: "Failed to load staff",
        details: error.message,
      },
      { status: 500 }
    );
  }

  return NextResponse.json(
    {
      staff: data ?? [],
      updatedAt: new Date().toISOString(),
    },
    {
      headers: {
        "Cache-Control": "no-store",
      },
    }
  );
}