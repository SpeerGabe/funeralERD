# Funeral Home ERD & SQL Schema
 
Relational database schema for a funeral home management system, designed in CSCI 410 (Database Management). Includes a full ERD diagram and SQL implementation.
 
## Schema Overview
 
| Table | Description |
|---|---|
| `Family` | Primary contact info and requests for the deceased's family |
| `Deceased` | Records for each deceased individual, linked to their family |
| `Service` | Funeral service details — location, date, time |
| `Payment` | Payment records linked to families and services |
| `Permit` | Legal documents (death certificates, burial permits) with approval status |
| `Clergy` | Clergy members available for services |
| `Florist` | Florist vendors with contact and pricing info |
| `Item` | Items associated with a service (caskets, flowers, etc.) |
| `counselorSession` | Grief counseling session records linked to families |
| `Outsource` | Links services to external vendors (clergy, florists, suppliers) |
 
## Design Highlights
 
- Cascading deletes ensure referential integrity — removing a family removes all linked records
- `CHECK` constraints enforce data validity (e.g. DOB before DOD, positive costs, valid permit status)
- Outsource table decouples vendor relationships from core service logic
## Files
 
- `funeral.sql` — full schema with table definitions and constraints
- `CSCI 410 Funeral Home ERD-1.pdf` — entity relationship diagram
 
