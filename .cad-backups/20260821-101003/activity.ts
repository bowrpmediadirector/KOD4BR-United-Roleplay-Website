import { cadSupabase } from "./supabase";

export async function logCadActivity(
  action: string,
  category: string,
  description: string,
  extra: Record<string, unknown> = {}
) {
  const {
    data: { user },
  } = await cadSupabase.auth.getUser();

  if (!user) return;

  await cadSupabase.from("cad_activity").insert({
    user_id: user.id,
    action,
    category,
    description,
    metadata: extra,
  });
}
