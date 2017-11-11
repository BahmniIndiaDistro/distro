# Distro
This will contain the database dump files, report &amp; form definitions.

### Steps to setup hypertension module
- Install bahmni with `openmrs_base_db.sql`,`clinlims_base_db.sql` and `openerp_base_db.sql` as the base database dump for bahmni. See here for [how to provide database dumps while installation](https://bahmni.atlassian.net/wiki/spaces/BAH/pages/35291242/Install+Bahmni+on+CentOS+Advanced+Installation+Options#InstallBahmnionCentOS(AdvancedInstallationOptions)-Step3:Copyappconfigandbasedatabasedump).
- Upload concepts `hypertension/ref_term.csv`, `hypertension/concepts.csv` & `hypertension/concept_sets.csv` using bahmni csv upload feature.
- Import Hypertension Intake_1.json form using bahmni form builder.
