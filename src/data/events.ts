export type CalendarEventType =
  | "session"
  | "development"
  | "event"
  | "meeting";

export interface CalendarEvent {
  id: string;
  date: string;
  type: CalendarEventType;
  title: string;
  time?: string;
  description?: string;
  location?: string;
}

export const calendarEvents: CalendarEvent[] = [
  {
    id: "session-001",
    date: "2026-08-22",
    type: "session",
    title: "Community Roleplay Session",
    time: "8:00 PM",
    description:
      "A scheduled BOWRP community roleplay session.",
    location: "BOWRP Roblox Server",
  },

  {
    id: "development-001",
    date: "2026-08-23",
    type: "development",
    title: "Development Day",
    time: "6:00 PM",
    description:
      "Server development, testing, website updates, and infrastructure work.",
    location: "Development Team",
  },

  {
    id: "session-002",
    date: "2026-08-29",
    type: "session",
    title: "Community Roleplay Session",
    time: "8:00 PM",
    description:
      "A scheduled BOWRP community roleplay session.",
    location: "BOWRP Roblox Server",
  },

  {
    id: "development-002",
    date: "2026-08-30",
    type: "development",
    title: "Development Day",
    time: "6:00 PM",
    description:
      "Development and testing of upcoming BOWRP features.",
    location: "Development Team",
  },
];

export function getEventsForDate(date: string) {
  return calendarEvents.filter(
    (event) => event.date === date
  );
}