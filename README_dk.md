# Azure-Landing-Zones-Danmark

[![GitHub Super-Linter](https://github.com/Azure-Landing-Zones-Danmark/Azure-Landing-Zones-Danmark/actions/workflows/linter.yml/badge.svg)](https://github.com/marketplace/actions/super-linter)

## Repository til et Dansk Azure Landing Zone setup.

```powershell
 _____                                   _               _      ______
|  __ \                                 | |        /\   | |    |___  /
| |  | | __ _ _ __  _ __ ___   __ _ _ __| | __    /  \  | |       / /
| |  | |/ _` | '_ \| '_ ` _ \ / _` | '__| |/ /   / /\ \ | |      / /
| |__| | (_| | | | | | | | | | (_| | |  |   <   / ____ \| |____ / /__
|_____/ \__,_|_| |_|_| |_| |_|\__,_|_|  |_|\_\ /_/    \_\______/_____|

```
Dette er start siden til projektet DanmarkALZ. Projektet er stadig under udarbejdelse

&nbsp;
&nbsp;

Projektet vil indeholde følgende
- et repository med Azure Policies som danner fundamentet for at oprette en Azure Landing Zone som tilgodeser de krav der være opfyldte i dansk sammenhæng i forhold til sikkerhed og kontroller.Pricipperne for dette projekt kan findes her [Policy-Driven-Governance](https://learn.microsoft.com/en-gb/azure/cloud-adoption-framework/ready/landing-zone/design-principles#policy-driven-governance)
- En [Sikkerheds Kontrol Process](docs/SecurityControlMapping.md) som sammensætter de poliikker som Azure Policy tilbyder med de krav enten lovgivningen eller ens organisation stiller. Desuden sikres det at en hver sammenkædning også her en ejer.

&nbsp;
&nbsp;


---

## Benyttede principper

1. Kortlægning af interessenter: En kortlægning af sikkerheds kontroller er en kontinuerlig process. Denne proces kræver en forankring i ens organisation samt et klarlagt ejerskab i forhold til hvem der håndtere vedligeholdelsen af ens sikkerheds opsætning, de poltikker der skal følges og implementering af disse, afrapportering samt håndtering af hændelser/afvigelser.

2. Alle politikker skal være kortlagt i forhold til det krav de opfylder, den opsætning de tilhører samt de kontroller disse er underlagt.

3. De potikker der dannes i Azure Policy skal være under source code kontrol. Politikkerne vedligeholdes efter DevOps principper og sættes i værk ved hjælp af en CI/CD proces

4. Dette projekt bygger på samt følger [Azure Landing Zones](https://github.com/Azure/Enterprise-Scale).

5. Det umiddelbare formål med dette projekt er give adgang til en hurtigere implementering for kunder i Danmark som er i en kontrolleret industri. Men projektet kan selvfølgelig benytte af alle kunder der ønsker en sådan opsætning.

 ---

## Implementerings metode

Det nuværende repository gør brug af Microsoft Bicep i forhold til IaC (Infrastructure as Code)

- Understøttelse for Terraform tilføjes senere

- Det nuværende repository vedligeholdes ved brug af GitHub actions. Undersøttelse for Azure DevOPs pipelines tilføjes senere
