CloudSports
CloudSports is my hands-on Azure and Terraform project. I’m using a fictional sports organization as the setting so I can build something larger than a one-off lab: shared platform services, league networks, team workloads, identity, monitoring, security, and Infrastructure as Code.

The first phase covers teams in Boston, Philadelphia, and the New York City metro area across MLB, NBA, NFL, and NHL. I’ll add the WNBA later.

I’m building this gradually—first by creating a few resources manually to understand Azure, then by bringing the design under Terraform and making it repeatable.

What I’m building
The long-term idea is a shared CloudSports platform with league and team workloads.

Each league will have shared services and a hub-and-spoke network design.

Each team will have its own resource group, workload network, applications, and eventually its own Terraform state.

League-level services may include shared networking, monitoring, Azure Virtual Desktop, cost controls, and security standards.

Teams will eventually host fictional websites, applications, and databases.

Fans and media are application users, not Azure administrators.

Scope
Cities
Boston

Philadelphia

New York City metro area

Leagues
MLB

NBA

NFL

NHL

WNBA is planned for a later phase

Initial teams
League	Boston	Philadelphia	NYC metro
MLB	Red Sox	Phillies	Yankees, Mets
NBA	Celtics	76ers	Knicks, Nets
NFL	Patriots	Eagles	Giants, Jets
NHL	Bruins	Flyers	Rangers, Islanders, Devils
WNBA later	—	—	Liberty
Design direction
The project uses the existing Microsoft Entra tenant and an Azure management group named cloudsports.

The eventual structure is:

text
CloudSports platform
├── Platform services
│   ├── Terraform state backend
│   ├── Identity and RBAC
│   ├── Monitoring
│   └── Security and governance
├── League shared services
│   └── Hub networks, shared services, and league controls
└── Team workloads
    └── Team resource groups, spoke VNets, applications, and team-owned state
The goal is to separate ownership over time:

Platform administrators manage shared governance and the Terraform backend.

League platform administrators manage league hubs and shared services.

Teams manage their own workload infrastructure within defined RBAC and networking boundaries.

Terraform and state
Terraform is the Infrastructure as Code tool for this project.

I started with a manual reference build, exported the Red Sox configuration as Terraform reference code, and used that pattern to build the Phillies network with Terraform.

Terraform state is stored remotely in Azure Blob Storage:

text
Resource group:  rg-cloudsports-platform-bootstrap-eus2
Storage account: stcloudsportstfstate
Container:       tfstate
The backend uses Microsoft Entra ID authentication instead of Storage account keys. Blob versioning, blob soft delete, container soft delete, and Azure Blob state locking are enabled.

The first remote state key is:

text
teams/phillies/network.tfstate
The repository will move toward reusable modules and separate root configurations for platform, league, and team workloads:

text
terraform/
├── modules/
│   ├── team-spoke/
│   ├── hub-network/
│   ├── monitoring/
│   ├── rbac/
│   └── team-workload/
├── live/
│   ├── platform/
│   ├── leagues/
│   └── teams/
└── reference-exports/
Current progress
Completed
Created the cloudsports management group.

Created Microsoft Entra groups for commissioners, managers, technical support, players, fans, and media.

Created the MLB shared resource group and hub VNet manually.

Created the Red Sox resource group, VNet, and workload subnet manually.

Exported the Red Sox infrastructure as Terraform reference code.

Built and deployed the Phillies network with Terraform:

rg-cloudsports-mlb-phillies

vnet-cloudsports-mlb-phillies-eus2

snet-workload

Created the Azure Storage account used for remote Terraform state.

Assigned Storage Blob Data Contributor to the administrator identity.

Confirmed Terraform can lock, read, and update Phillies remote state.

Enabled blob versioning and 30-day blob/container soft delete for state recovery.

Confirmed the Phillies configuration has no drift from Azure.

Network address plan
Team or service	VNet address space	Workload subnet
MLB shared hub	10.10.0.0/16	Shared services subnet
Red Sox	10.11.0.0/16	10.11.0.0/24
Phillies	10.12.0.0/16	10.12.0.0/24
Mets	10.13.0.0/16	10.13.0.0/24
Yankees	10.14.0.0/16	10.14.0.0/24
Next steps
Commit the current Terraform configuration and documentation.

Build reusable Terraform modules for team spokes and shared services.

Import the manually created Red Sox network into a dedicated Red Sox Terraform state.

Export and import the MLB shared hub resources into a league-owned state.

Add hub-to-spoke VNet peering.

Add monitoring, budgets, RBAC, and security controls.

Add team workloads such as a website and database.

Add GitHub Actions with OpenID Connect for controlled Terraform plans and applies.

Expand the pattern to the rest of MLB, then NBA, NFL, NHL, and WNBA.

Working locally
Terraform runs locally through VS Code using Azure CLI authentication:

powershell
az login
terraform init
terraform plan
terraform apply
Always run Terraform from the root folder for the component you are managing. Each root will have its own backend.tf and remote state key.

Do not commit Terraform state files, Azure credentials, access keys, or secrets.