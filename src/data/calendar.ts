export type CalendarEventType =
  | "session"
  | "development"
  | "meeting"
  | "event";

export interface CalendarEvent {
  id: string;
  title: string;
  date: string;
  type: CalendarEventType;
  description: string;
  time?: string;
  location?: string;
}

export const calendarEvents: CalendarEvent[] = [
  {
    id: "session-1",
    title: "Community Roleplay Session",
    date: "2026-08-18",
    type: "session",
    time: "7:00 PM CST",
    location: "K4BRURP Roblox Server",
    description:
      "Scheduled community roleplay session for K4BRURP members.",
  },

  {
    id: "development-1",
    title: "Development Day",
    date: "2026-08-21",
    type: "development",
    time: "All Day",
    location: "K4BRURP Development",
    description:
      "Development and improvement work for the K4BRURP community.",
  },

  {
    id: "session-2",
    title: "Community Roleplay Session",
    date: "2026-08-29",
    type: "session",
    time: "7:00 PM CST",
    location: "K4BRURP Roblox Server",
    description:
      "Scheduled community roleplay session for K4BRURP members.",
  },

  {
    id: "development-2",
    title: "Development Day",
    date: "2026-08-30",
    type: "development",
    time: "3:00 PM",
    location: "K4BRURP Development",
    description:
      "Development and improvement work for the K4BRURP community.",
  },
];