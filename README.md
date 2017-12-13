# Distro
This repository will contain the database dump files, concept CSVs, reports definitions &amp; form definitions.

### Steps to setup hypertension module
* Install bahmni with `base_db/openmrs_base_db.sql`,`base_db/clinlims_base_db.sql` and `base_db/openerp_base_db.sql` as the base database dump for openmrs, openelis and openerp respectively. See here for [how to provide database dumps while installation](https://bahmni.atlassian.net/wiki/spaces/BAH/pages/35291242/Install+Bahmni+on+CentOS+Advanced+Installation+Options#InstallBahmnionCentOS(AdvancedInstallationOptions)-Step3:Copyappconfigandbasedatabasedump).
* Once the installation is done, upload CSVs using bahmni CSV upload (Bahmni Home => Admin => CSV Upload) from hypertension folder in below order
    * Upload reference terms from `hypertension/ref_term.csv`.
    * Upload concepts from `hypertension/concepts.csv`.
    * Upload concept sets from `hypertension/concept_sets.csv`.
* Import Hypertension Intake_1.json form using bahmni form builder. Publish this form.


