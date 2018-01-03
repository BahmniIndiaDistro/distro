# Distro
This repository will contain the database dump files, concept CSVs, reports definitions &amp; form definitions.

## Setting up the Base Distro
The base distro comes with the bahmni metadata and few essential findings,tests,drugs,diagnoses,forms,reports etc which can be used for a general purpose hospital. On top of this a specific program module can be installed.

To setup the base distro you need to follow steps given below:-
#### Install bahmni with base database
* Install bahmni with `base_db/openmrs_backup.sql`,`base_db/openelis_backup.sql` and `base_db/openerp_backup.sql` as the base database dump for openmrs, openelis and openerp respectively. See here for [how to provide database dumps while installation](https://bahmni.atlassian.net/wiki/spaces/BAH/pages/35291242/Install+Bahmni+on+CentOS+Advanced+Installation+Options#InstallBahmnionCentOS(AdvancedInstallationOptions)-Step3:Copyappconfigandbasedatabasedump).

#### Install the bahmni analytics app without docker
To install the bahmni analytics app you need to do the following :-

* Create a properties file `/tmp/app.properties` with below contents. The values in `<>` needs to be changed.
```
host=<the host of bahmni having mysql and psql db>
sshUsername=bahmni_support
identityFilePath=dummy_file
mysqlDbName=openmrs
mysqlUser=<mysql user name>
mysqlPassword=<mysql user password>
localMysqlPort=9001
usePostgres=TRUE
psqlDbName=openerp
psqlUser=<openerp user name>
psqlPassword=<openerp passowrd>
localPsqlPort=9002
pluginsFolder=/var/lib/bahmni-shiny/plugins/
sqliteDbFilePath=/var/lib/bahmni-shiny/shiny.sqlite
preferencesFolderPath=/var/lib/bahmni-shiny/preferences/
```
* Download the `setup_analytics.sh`.

```
sudo su
wget https://raw.githubusercontent.com/BahmniIndiaDistro/distro/master/setup_analytics.sh
```

* Run the `setup_analytics.sh` with the host of bahmni having mysql and psql db as argument.

```
sh setup_analytics.sh
```

The above will setup analytics application with the minimal visualisatons. Visualisations about specific program will come along with the module installation.

### Steps to setup hypertension module
* Once the installation is done, upload CSVs using bahmni CSV upload (Bahmni Home => Admin => CSV Upload) from hypertension folder in below order
    * Upload reference terms from `hypertension/ref_term.csv`.
    * Upload concepts from `hypertension/concepts.csv`.
    * Upload concept sets from `hypertension/concept_sets.csv`.
* Import `hypertension/Hypertension Intake_1.json` using bahmni form builder. Publish this form.


