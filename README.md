# CloudSports

I have been missing sports this summer, so I decided to build some of it in Azure.

CloudSports is a hypothetical Azure architecture project built around professional sports teams in the Northeast. The goal is to use a sports organization as a way to work through real cloud design questions: identity, RBAC, subscriptions, landing zones, networking, availability, and scaling for things like playoff games and draft days.

This is not affiliated with Microsoft, any league, or any sports team. It is a hands-on learning and portfolio project.

## Scope

The first version covers teams in the Boston, Philadelphia, and NYC areas.

Leagues in the first phase:

- MLB
- NBA
- NFL
- NHL

I plan to add the WNBA later.

Each league will have its own subscription so it can be responsible for its own Azure usage and costs. Each league will have shared services along with separate team workloads.

## What I am building

The idea is to build the first league manually so I can understand the pieces, then use Terraform to repeat the pattern for the next league.

Each league will eventually include:

- Shared league services
- A hub-and-spoke network design
- Team resource groups
- A basic team website
- A fictional app and database
- League-level Azure Virtual Desktop
- Identity and role-based access for different types of users
- Regional availability and time-zone considerations
- A plan for scaling during playoffs, draft days, and other major events

## Current design

```text
CloudSports Management Group
|
└── League Subscription
    |
    ├── Shared Services / Hub
    ├── Team Resource Group
    ├── Team Resource Group
    └── Team Resource Group
```

The plan is to use one Microsoft Entra tenant for the project. I created a CloudSports management group and moved my existing Azure subscription under it.

## Entra groups

The first identity groups created for the project are:

- CloudSports-Commissioner
- CloudSports-Managers
- CloudSports-TechSupport
- CloudSports-Players
- CloudSports-Fans
- CloudSports-Media

I will decide which Azure roles each group needs as the subscription and workloads are built. Not every group will need Azure access. For example, Fans and Media may only need access to an application or website instead of Azure resources.

## Current build status

- [x] Created the CloudSports GitHub project
- [x] Created CloudSports Entra security groups
- [x] Created the `cloudsports` management group
- [x] Moved the existing Azure subscription under CloudSports
- [ ] Create the first shared resource group for the MLB subscription
- [ ] Create team resource groups
- [ ] Build the first network and workload
- [ ] Document RBAC assignments
- [ ] Add Terraform to repeat the pattern for another league

## Repository layout

```text
docs/          Architecture notes and design decisions
manual-build/  Notes from building the first league manually
terraform/     Infrastructure-as-code work for later league deployments
```

## Notes

I am building this out in stages and documenting decisions as I go. The goal is not to pretend this is a real sports organization. The goal is to make the exercise realistic enough to practice the architecture decisions that come up in a real multi-team, multi-region organization.
