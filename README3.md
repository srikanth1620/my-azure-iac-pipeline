What is the difference between B2B direct connect and B2B collaboration? 

B2B direct connect - Mutual trust between Entra tenants for seamless access to "shared Teams channels" without guest accounts.

    Limited to Teams shared channels; no access to full teams, Azure portal, or other apps.
    Users stay in their home org; no org switch needed; managed via channel owner.

B2B collaboration - Invite external users as guests to your tenant for collaboration across resources.

    Broad: Teams, SharePoint, apps, SaaS, custom apps, and Azure portal.
    Users switch orgs in apps; guest account created in your tenant.


Automatic expiry . 

Microsoft Entra ID does not natively support automatic expiry for cross-tenant access settings (B2B Direct Connect or Collaboration) as of October 2025. Unlike B2B Collaboration guest accounts (which support access reviews and expiry via Microsoft Entra ID Governance), B2B Direct Connect relies on mutual trust settings that remain active until manually removed. However, you can implement a process to simulate expiry using manual reviews, automation, or governance tools.