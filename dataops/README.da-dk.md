<!-- spell-checker:locale en,da-DK -->
# Azure-Landing-Zones-Danmark

[![en](https://img.shields.io/badge/lang-en-red.svg)](README.md)
[![dk](https://img.shields.io/badge/lang-da--dk-green.svg)](README.da-dk.md)

[![License](https://img.shields.io/badge/License-MIT-green)](https://github.com/Azure-Landing-Zones-Danmark/Azure-Landing-Zones-Danmark/blob/main/LICENSE)
[![CodeOfConduct](https://img.shields.io/badge/Code--of--conduct-MS--Open--Source-red)](https://github.com/Azure-Landing-Zones-Danmark/Azure-Landing-Zones-Danmark/blob/main/CODE-OF-CONDUCT.md)

## Repository til en dansk Azure Landing Zone opsætning - **Dataops sektion**

![Heading](docs/images/azure-danmark-alz.jpg)

Dette er startsiden til **DataOps**. Projektet er stadig under udarbejdelse.

Denne sektion vil indeholde følgende:

- et repository med *Azure Policies* som danner fundamentet til at oprette en *Azure Landing Zone* som tilgodeser de krav, der bør være opfyldt i dansk sammenhæng. Dette med fokus på håndtering af data.
- Guidelines i forhold til brugen af data i forskellige miljøer.
- som eksempel på et data er der brugt en *Personlig record* som indeholder CPR number, fornavn, efternavn og adresse oplysninger

## Overordnede principper

1. **GDPR** regler/principper skal tilgodeses

1. Data kan kun bruges til det formål som de indsamlet til

1. Udvikling **kan ikk** foregå på produktions data



## Opsætnings krav

### Miljø beskrivelse

For at kunne kontrollere de enkelte poltikker og deres implementering, har vi behov for at kunne vide hvilket miljø vi er.
I dette dokument arbejder vi med følgende 4 miljøer (vi har her benyttet engelske navne):

- Sandbox – miljø som bruges til at undersøge hvor vidt funktionaliteten af en given services opfylder et givent behov.
  Disse miljøer indeholer *IKKE* forretningsdata af nogen art.
- Non-Production – indeholder miljøer til udvikling, qa og test scenarier. Disse miljøer bygger på et koncept vi kalder *projekt rum* (se nedenfor)
- Production – mijløer til brug for pre-prod og prod scenarier
- Confidential – disse miljøer benyttes til processering af data der kræver et yderligere højt sikkerheds niveau.

### Data klassification opslags “database”

En “database” hvor vi kan finde information om hvilke data elementer som kræver en speciel håndtering.
Yderligere oplysninger kan findes i kapitlet *Data Etablering*.

## Miljøer og politikker

I de forskellige miljøer er der poltikker omkring kryptering, som bør/skal etableres.

|Miljø/Politik|Sandbox|Non-Production|Production|Confidential|
|---|---|---|---|---|
|Encryption at Rest|Audit|Audit|Required|Required|
|Encryption in Transit|Audit|Audit|Required|Required|
|Encryption in Processing|N/A|N/A|N/A|Required|

- Audit – der skal være en politik der kan dokumentere hvorvidt kryptering er tilstede, selvom dette ikke er påkrævet. Dette kan benyttes til en risiko vurdering.
- Required – den politik vil **forhindre** oprettelsen af et storage lag uden krypterting.
- N/A – Ikke anvendeligt

## Miljøer og Tags ##

I den forskellige miljøer opsættes tags for lettere at kunne indetificere typen af miljøet.

|Miljø/Tag|Sandbox|Non-Production|Production|Confidential|Values|
|---|---|---|---|---|---|
|Data-owner|Audit|Required|Required|Required|*navn på data-ejer*|
|Environment|Required|Required|Required|Required|Sandbox, Non-Prod, Prod, Conf|
|Environment-type|Audit|Required|Required|Required|Sandbox/ NonProd: Dev,Test,QA / Prod: PreProd,Prod/ Confidential|

- Audit – tagget bør være der.
- Required – tagget skal være der. Hvis ikke **forhindres** oprettelsem
- N/A – Ikke anvendeligt

## Data Etablering ##

Et **Projekt rum** er et isoleret miljø - typisk en resourcegruppe - hvor ejerskabet alene er en eller to AD-grupper.

Det er muligt at bringe data ind i et projekt rum som er i read-only - det kræver et særskilt ejerskab og dermed AD-gruppe *"nr-2"*.

Processen til at etablere data i et projekt rum vil bestå af en eller flere af følgende metoder:

- Kopi af produktions data
- Data generering af *fake data*
- Anonymisering
- Pseudonomisering
- Kryptering + *Dictionary*
- *“Ingen sammenhæng”* datasæt

Den eller de processer der skal benyttes afhænger af klassifikationen af de enkelte data elementer.

## Data etablering - detaljeret information ##

### Kopi af produktions data ###
### Data generering af *fake data* ###
### Anonymisering ###
### Pseudonomisering ###
### Kryptering + *Dictionary* ###
### *“Ingen sammenhæng”* datasæt ###
