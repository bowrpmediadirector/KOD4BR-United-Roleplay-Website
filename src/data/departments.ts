export const departments = [
  {
    slug: "bear-capital-city-police-department",
    name: "Bear Capital City Police Department",
    abbreviation: "BCCPD",
    category: "LAW ENFORCEMENT",
    icon: "🚔",

    fullDescription:
      "The Bear Capital City Police Department is responsible for protecting the residents and visitors of Bear Capital City while providing professional, realistic, and community-focused law enforcement roleplay.",

    responsibilities: [
      "Patrol Operations",
      "Traffic Enforcement",
      "Criminal Investigations",
      "Emergency Response",
      "Community Policing",
    ],

    ranks: [
      "Chief of Police",
      "Deputy Chief",
      "Captain",
      "Lieutenant",
      "Sergeant",
      "Corporal",
      "Officer",
      "Cadet",
    ],

    requirements: [
      "Must be an active member of BOWRP.",
      "Must follow all BOWRP community rules.",
      "Must maintain professional behavior.",
      "Must complete required department training.",
      "Must remain active within the department.",
    ],
  },

  {
    slug: "bear-county-sheriffs-office",
    name: "Bear County Sheriff's Office",
    abbreviation: "BCSO",
    category: "LAW ENFORCEMENT",
    icon: "⭐",

    fullDescription:
      "The Bear County Sheriff's Office provides professional law enforcement services throughout Bear County while supporting local agencies and protecting the communities they serve.",

    responsibilities: [
      "County Patrol",
      "Court Security",
      "Warrant Enforcement",
      "Criminal Investigations",
      "Emergency Response",
      "Search and Rescue",
    ],

    ranks: [
      "Sheriff",
      "Undersheriff",
      "Chief Deputy",
      "Captain",
      "Lieutenant",
      "Sergeant",
      "Corporal",
      "Deputy",
      "Cadet",
    ],

    requirements: [
      "Must be an active member of BOWRP.",
      "Must follow all BOWRP community rules.",
      "Must maintain professional behavior.",
      "Must complete required department training.",
      "Must remain active within the department.",
    ],
  },

  {
    slug: "bear-state-patrol",
    name: "Bear State Patrol",
    abbreviation: "BSP",
    category: "LAW ENFORCEMENT",
    icon: "🚓",

    fullDescription:
      "The Bear State Patrol provides statewide law enforcement services with a primary focus on highway safety, traffic enforcement, emergency response, and supporting law enforcement agencies throughout the State of Bear.",

    responsibilities: [
      "Highway Patrol",
      "Traffic Enforcement",
      "Crash Response",
      "Commercial Vehicle Enforcement",
      "Statewide Emergency Response",
      "Interagency Assistance",
    ],

    ranks: [
      "Superintendent",
      "Deputy Superintendent",
      "Major",
      "Captain",
      "Lieutenant",
      "Sergeant",
      "Trooper",
      "Cadet",
    ],

    requirements: [
      "Must be an active member of BOWRP.",
      "Must follow all BOWRP community rules.",
      "Must maintain professional behavior.",
      "Must complete required department training.",
      "Must successfully complete patrol training.",
    ],
  },

  {
    slug: "state-of-bear-corrections",
    name: "State of Bear Corrections",
    abbreviation: "SBC",
    category: "CORRECTIONS",
    icon: "🔒",

    fullDescription:
      "The State of Bear Corrections is responsible for maintaining the safety, security, and orderly operation of correctional facilities throughout the State of Bear while providing realistic corrections roleplay.",

    responsibilities: [
      "Correctional Facility Operations",
      "Inmate Supervision",
      "Facility Security",
      "Inmate Transportation",
      "Emergency Response",
      "Corrections Investigations",
    ],

    ranks: [
      "Director",
      "Deputy Director",
      "Warden",
      "Deputy Warden",
      "Captain",
      "Lieutenant",
      "Sergeant",
      "Corrections Officer",
      "Cadet",
    ],

    requirements: [
      "Must be an active member of BOWRP.",
      "Must follow all BOWRP community rules.",
      "Must maintain professional behavior.",
      "Must complete required corrections training.",
      "Must remain active within the department.",
    ],
  },

  {
    slug: "bear-metro-fire-district",
    name: "Bear Metro Fire District",
    abbreviation: "BMFD",
    category: "FIRE & EMS",
    icon: "🚒",

    fullDescription:
      "The Bear Metro Fire District provides fire suppression, emergency medical services, rescue operations, and emergency response throughout the Bear Metro area.",

    responsibilities: [
      "Fire Suppression",
      "Emergency Medical Services",
      "Vehicle Extrication",
      "Rescue Operations",
      "Hazardous Materials Response",
      "Fire Prevention",
    ],

    ranks: [
      "Fire Chief",
      "Deputy Chief",
      "Battalion Chief",
      "Captain",
      "Lieutenant",
      "Engineer",
      "Firefighter",
      "Probationary Firefighter",
    ],

    requirements: [
      "Must be an active member of BOWRP.",
      "Must follow all BOWRP community rules.",
      "Must maintain professional behavior.",
      "Must complete required fire/EMS training.",
      "Must remain active within the department.",
    ],
  },
];

export function getDepartment(slug: string) {
  return departments.find(
    (department) => department.slug === slug
  );
}