CloudSports — Progress and Plan
What this is
CloudSports is a hands-on Azure architecture project built around a hypothetical Northeast professional sports organization. It uses MLB, NBA, NFL, and NHL teams across Boston, Philadelphia, and the NYC metro area. The WNBA is planned as a later addition.

The point is to practice real cloud design decisions using a theme that makes the project more fun: identity, access, subscriptions, shared services, hub/spoke networking, AVD, regions, availability, scale, cost ownership, and Infrastructure as Code.

This project is fictional and is not affiliated with Microsoft, any sports league, or any team.

Scope
Cities
Boston

Philadelphia

NYC metro area

Initial leagues
MLB

NBA

NFL

NHL

Future league
WNBA

Initial teams
League	Boston	Philadelphia	NYC metro
MLB	Red Sox	Phillies	Yankees, Mets
NBA	Celtics	76ers	Knicks, Nets
NFL	Patriots	Eagles	Giants, Jets
NHL	Bruins	Flyers	Rangers, Islanders, Devils
WNBA later	—	—	Liberty
Design decisions so far
The project will use the existing Microsoft Entra tenant rather than creating a separate paid tenant.

A cloudsports Azure management group was created.

The existing Azure subscription was moved under the CloudSports management group.

The current subscription is acting as the first manual-build league subscription. The working example is MLB.

The larger design calls for separate subscriptions by league so each league can own and track its Azure costs.

Each league will have shared services and a hub/spoke network model.

Each team will have its own resource group and workload VNet.

League-level AVD is planned.

Teams will eventually have their own user identities, websites, and fictional application/database workloads.

Fans and Media are expected to be application users, not normal Azure administrators.

Entra groups created
These security groups were created in the existing tenant:

CloudSports-Commissioner

CloudSports-Managers

CloudSports-TechSupport

CloudSports-Players

CloudSports-Fans

CloudSports-Media

Azure roles have not been assigned yet. The next phase will decide which groups need Azure RBAC access and at what scope.

Manual MLB build progress
Completed
Created the GitHub repository: wesmccallister/CloudSports

Updated the root README

Created the cloudsports management group

Moved the existing Azure subscription under CloudSports

Created the MLB shared resource group:

rg-cloudsports-mlb-shared

Region: East US 2

Tag: League = MLB

Created the MLB hub VNet:

vnet-cloudsports-mlb-hub-eus2

Resource group: rg-cloudsports-mlb-shared

Region: East US 2

Address space: 10.10.0.0/16

Shared-services subnet: snet-shared-services / 10.10.1.0/24

Tag: League = MLB

Created the Boston Red Sox workload resource group:

rg-cloudsports-mlb-redsox

Region: East US 2

Tags: League = MLB, Team = RedSox, City = Boston

Next immediate step
Create the Red Sox spoke VNet:

Name: vnet-cloudsports-mlb-redsox-eus2

Resource group: rg-cloudsports-mlb-redsox

Region: East US 2

Address space: 10.11.0.0/16

Workload subnet: snet-workload / 10.11.1.0/24

The Red Sox VNet is intentionally separate from the MLB hub VNet so it can later be peered to the hub without address overlap.

Planned build order
Create the Red Sox spoke VNet.

Peer the Red Sox spoke VNet to the MLB hub VNet.

Decide the first basic workload for the Red Sox resource group.

Create a simple team website and fictional app/database concept.

Define and assign RBAC roles to the Entra groups at the right scope.

Plan the league-level Azure Virtual Desktop deployment.

Add more MLB teams in alphabetical order: Phillies, Mets, Yankees.

Document the repeatable manual pattern.

Use Terraform to reproduce the pattern for the next league.

Add region, time-zone, resilience, and event-scale design decisions for playoffs and draft days.

Network plan
text
MLB shared services / hub
  vnet-cloudsports-mlb-hub-eus2
  10.10.0.0/16
  └── snet-shared-services: 10.10.1.0/24

Boston Red Sox spoke
  vnet-cloudsports-mlb-redsox-eus2
  10.11.0.0/16
  └── snet-workload: 10.11.1.0/24
Future team VNets will use their own non-overlapping address spaces.

Notes
The Azure portal can export a generated ARM JSON template after resources are created. That export is useful as a reference for what Azure created, but it is not the final Infrastructure as Code approach for this project.

The plan is to manually build the first league pattern for learning, document decisions, then use Terraform for repeatability.

Keep the initial environment lean. Do not enable Azure Firewall, Bastion, NAT Gateway, DDoS Protection Standard, or other paid services until there is a reason to use them.