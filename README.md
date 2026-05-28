# DMS: Deployment Management System
## A Full Stack Enterprise Resource and Project Management Platform — Built in 2005

**Dev Kewalramani** | dev.kewalramani@gmail.com | [devkewalramani.com](https://devkewalramani.com)

---

## The Short Version

In 2005, before ServiceNow PPM existed, before cloud storage existed, and before "full stack developer" was a job title, I designed, built, deployed, and operated a web-based enterprise resource management platform from scratch to run the field operations of a national technology services firm managing 40 to 50 Dell engineers across the United States.

ServiceNow did not launch its Project Portfolio Management product until approximately 2014. DMS was live and in production nine years earlier.

After the original company was acquired by Brocade, DMS did not get retired. It continued in production and was later extended to Hitachi Data Systems field operations, running across multiple organizations for several years after its original deployment.

This repository contains the original source code.

---

## The Origin Story

The company was Strategic Business Systems (SBS), a Dell partner managing enterprise field deployment and professional services engagements across the country. I joined SBS as a field engineer, deploying Dell SAN and storage solutions at customer sites across the country. I lived the operational reality firsthand — the scheduling friction, the manual travel coordination, the task list paperwork, the disconnected reporting — before I ever had the authority to fix any of it.

When I moved into the leadership team as Resource and Engagement Manager, I saw the same problems I had experienced as an engineer, now from the other side of the process. We were running 40 projects per week, tracking 40 to 50 storage engineers flying to customer sites, coordinating travel requests, managing task list submissions, generating finance reports, and trying to do all of it through a combination of spreadsheets, email chains, and manual processes.

It was not working. The back office was consuming enormous amounts of human time on work that should have been automated. Finance reporting alone was taking a full day of labor every week. Engineer utilization tracking was manual and inaccurate. Travel coordination was fragmented.

I had a BS in Computer Science from Clemson and had been writing code long before I became a project manager. I identified the gap, made the internal case, and built the solution myself.

The name DMS started as an acronym for the three founders of the leadership team: Dev, Mark, and Shaun. It was later rebranded as the Data Management System. An earlier proposed name was retired for reasons that should be obvious.

What happened next is worth noting. After I left SBS, the company was acquired by Brocade. DMS was not decommissioned. It continued in production under the new ownership and was later extended to support Hitachi Data Systems field operations as well. The platform ran across multiple organizations for several years after its original deployment — surviving an acquisition, onboarding a new enterprise client, and continuing to manage engineer scheduling, travel coordination, task tracking, and finance reporting without the person who built it in the room.

That is the difference between a tool and a product.

---

## What I Built

DMS is a multi-module, role-based web application built on ColdFusion MX, Microsoft SQL Server, and IIS, hosted on an internal server with a static IP that the team accessed via browser. Files associated with projects were stored on a Windows file share that DMS linked to through a document tracking layer, providing metadata and audit capability over pre-cloud storage.

### Module Architecture

The application was organized into five distinct role-based modules, each with its own interface, navigation, and database access scope:

**Engineer Module**
The interface for field engineers. Engineers could view their assigned projects, check task list requirements, and access their engagement history. The system tracked which engineers had outstanding task list submissions after project completion and automatically flagged them.

**Manager / Client Services Module**
The primary operational interface for deployment managers. Capabilities included scheduling new projects, searching and viewing the schedule, submitting and tracking travel requests, managing task list pipelines, viewing utilization and business unit reports, metric reporting, and engineer administration. This was the operational center of the platform.

**Finance Module**
A dedicated interface for the finance team providing business unit revenue tracking, date range reporting, and engineer-level revenue views. The finance module pulled from the same underlying schedule and travel data but surfaced it in a format optimized for revenue recognition and weekly reporting.

**HR Module**
Engineer profile management including adding new engineers, editing existing profiles, and managing the engineer roster that fed into the scheduling and assignment workflows.

**Sales Module**
A supporting module for the sales function providing level of effort estimation tools and schedule visibility relevant to pre-sales activities.

### Core Data Model

The MSSQL database (datasource: SBSEFD) included the following primary tables:

- **dbo.Schedule** — the master project and engagement record, linking engineers to dispatches, project types, dates, locations, status, and document tracking
- **dbo.SE** — the engineer roster with employee IDs, names, email addresses, type classifications, and status flags
- **dbo.DM** — the deployment manager roster
- **dbo.Travel** — travel requests with status workflow (Submitted, Approved, etc.), linked back to Schedule records
- **dbo.Proj\_Type** — project type lookup table covering the full range of Dell EFD and DPS engagement types
- **dbo.Regions** — geographic state lookup for regional assignment and reporting
- **dbo.ProjectTask** — task list definitions associated with project types
- **dbo.document\_tracking** — metadata layer linking schedule records to files on the Windows file share, with completion date tracking

### Automated Workflow Engine

The auto\_tasks directory contains scheduled ColdFusion jobs that ran every morning without human intervention:

**Finance Travel Report (tr\_finance.cfm)**
Queried all travel requests submitted the previous day with a status of Submitted and automatically emailed the projects team an HTML formatted report listing project type, SBS project code, project name, engineer, and start date. This ensured that every travel request was captured in Tenrox (the time and expense system) before the business day began.

**Engineer Task List Reminder (tl\_eng.cfm)**
Queried every active engineer's completed projects and identified any where the task list had not been submitted. For each engineer with outstanding task lists, the system automatically sent a personalized HTML email listing the overdue items with dispatch ID, project name, completion date, due date, and days overdue. This ran every morning across the full engineer roster without a human touching it.

**Additional Automated Reports**
The auto\_tasks directory includes additional scheduled jobs for CAF (Customer Acceptance Form) tracking and end-of-engagement reporting, covering the full project lifecycle from scheduling through close-out documentation.

### Front End and UI

The application used Dreamweaver MX templates and library items for reusable, role-specific layouts. Each module had its own Dreamweaver template (dms\_management.dwt, dms\_eng.dwt, dms\_finance.dwt, dms\_hr.dwt) ensuring visual consistency across the application while keeping the navigation and layout separate per role.

A CascadeMenu JavaScript and CSS system provided the dropdown navigation on the main index. The UI was designed in Photoshop (PSD source files are included in the repository) with custom logo, header, navigation buttons, and iconography — all original assets created for DMS.

A built-in date picker component (ct\_date\_input.cfm) was integrated across all scheduling and reporting interfaces, handling the calendar UI that browsers did not natively provide at the time.

A help document (helpdoc.pdf) was also built into the application and linked from the main navigation for onboarding new users.

---

## Technical Stack

| Layer | Technology |
|---|---|
| Application Server | ColdFusion MX |
| Database | Microsoft SQL Server (MSSQL) |
| Web Server | IIS (Internet Information Services) |
| Front End | HTML, CSS, JavaScript |
| UI Framework | Dreamweaver MX templates and library items |
| Automation | ColdFusion scheduled tasks |
| Email | ColdFusion cfmail with HTML multipart |
| File Storage | Windows file share with DMS metadata layer |
| Design | Adobe Photoshop (custom assets) |
| Deployment | Internal server, static IP, browser-based access |

**Languages used:** ColdFusion, SQL, HTML, CSS, JavaScript

---

## What It Delivered

From the 2007 resume, documented at the time of deployment:

- **75% reduction in labor hours per week** from streamlined reporting and back end data storage
- **$75,000 in annual savings** from streamlined finance weekly reporting
- **60% faster delivery** of revenue and utilization reporting to the CEO
- **100% resource utilization** maintained on average across 40 to 50 engineers
- **40 projects per week** managed through the system at peak volume

---

## Why This Matters in 2026

DMS was not a side project or a prototype. It was a production system that ran real business operations at scale, built by a single developer who also managed the team and the client relationships the system was designed to serve. It survived a corporate acquisition, was extended to a second enterprise client in Hitachi Data Systems, and ran in production across multiple organizations for several years after its original deployment.

The problem DMS solved in 2005 is the same problem enterprise software companies are still solving today: how do you give a distributed workforce a single pane of action that surfaces the right information, triggers the right workflows, and removes the manual labor that gets in the way of actual work?

ServiceNow PPM, Salesforce Field Service, and a dozen other enterprise platforms now address variations of this problem with hundreds of engineers and hundreds of millions in R&D. DMS addressed it with one developer, a ColdFusion license, and a clear understanding of what the business actually needed.

The architecture is different. The underlying technology is dated. The product thinking is not.

---

## Repository Contents

```
sbs/
├── index.cfm                  # Main application entry point with role-based navigation
├── CascadeMenu.css/.js        # Dropdown navigation system
├── helpdoc.pdf                # User documentation
├── engineer/                  # Engineer-facing module
├── manager/                   # Operations and client services module
│   ├── schedule.cfm           # Project scheduling interface
│   ├── metric/                # Metric reporting submodule
│   └── schedule/              # Schedule view submodule
├── finance/                   # Finance reporting module
├── hr/                        # Human resources module
├── sales/                     # Sales support module
├── auto_tasks/                # Scheduled automation jobs
│   ├── tr_finance.cfm         # Daily travel request finance report
│   ├── tl_eng.cfm             # Daily engineer task list reminders
│   └── caf_osr.cfm            # Customer acceptance form tracking
├── Templates/                 # Dreamweaver role-specific templates
├── Library/                   # Reusable navigation library items
├── PSD/                       # Original Photoshop design assets
├── test/                      # Development and testing directory
└── _mmServerScripts/          # ColdFusion server configuration
```

---

## About This Project

DMS was designed and built entirely by Dev Kewalramani. He joined Strategic Business Systems (SBS) in Virginia as a field engineer deploying Dell SAN and storage solutions, experienced the operational gaps firsthand, and when he moved into the leadership team as Resource and Engagement Manager, applied his CS background to build the solution himself.

The platform was deployed on internal infrastructure from 2005 to 2007 and adopted across the operations, finance, HR, and engineering functions of the company.

Following Dev's departure, SBS was acquired by Brocade. DMS continued in production under the new ownership and was subsequently extended to support Hitachi Data Systems field operations, running across multiple organizations for several years.

It predates ServiceNow PPM by approximately nine years.

For questions or to discuss further: [dev.kewalramani@gmail.com](mailto:dev.kewalramani@gmail.com)
