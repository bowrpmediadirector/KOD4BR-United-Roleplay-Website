export type CallPriority =
  | "LOW"
  | "MEDIUM"
  | "HIGH"
  | "EMERGENCY";

export type CallStatus =
  | "PENDING"
  | "ACTIVE"
  | "HOLD"
  | "CLOSED";

export type UnitStatus =
  | "AVAILABLE"
  | "EN_ROUTE"
  | "ON_SCENE"
  | "BUSY"
  | "TRAFFIC_STOP"
  | "TRANSPORTING"
  | "PANIC"
  | "OUT_OF_SERVICE";

export interface CadCall {
  id: string;
  case_number: string;
  call_type: string;
  priority: CallPriority;
  status: CallStatus;
  caller_name?: string | null;
  caller_phone?: string | null;
  location: string;
  description?: string | null;
  created_at: string;
  updated_at: string;
}

export interface CadUnit {
  id: string;
  unit_number: string;
  officer_user_id?: string | null;
  officer_name?: string | null;
  department?: string | null;
  rank?: string | null;
  status: UnitStatus;
  location?: string | null;
  current_call_id?: string | null;
  radio_identifier?: string | null;
  notes?: string | null;
}

export interface CadPermission {
  can_view: boolean;
  can_dispatch: boolean;
  can_manage_calls: boolean;
  can_manage_units: boolean;
  can_view_records: boolean;
  can_manage_records: boolean;
  can_create_reports: boolean;
  can_manage_warrants: boolean;
  can_manage_bolos: boolean;
  can_admin: boolean;
}
