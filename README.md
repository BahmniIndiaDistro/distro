# Distro
This repository will contain the database dump files, concept CSVs, reports definitions &amp; form definitions.

## Setting up the Base Distro
The base distro comes with the bahmni metadata and essential findings,tests,drugs,diagnoses,forms,reports etc which can be used for a general purpose hospital. On top of this a specific program module can be installed.

To setup the base distro you need to follow steps given below:-
#### Install bahmni with distro-base-db and distro-config.
* Install bahmni-installer. Refer [Here](https://bahmni.atlassian.net/wiki/spaces/BAH/pages/33128505/Install+Bahmni+on+CentOS).
* Prepare the setup and inventory files.
* Use `base_db/india_distro_base_db/openmrs_backup.sql`,`base_db/india_distro_base_db/openelis_backup.sql` and `base_db/india_distro_base_db/openerp_backup.sql` as the base database dump for openmrs, openelis and openerp respectively.
```
cd /etc/bahmni-installer/deployment-artifacts/
wget https://raw.githubusercontent.com/BahmniIndiaDistro/distro/master/base/india_distro_base_db/openmrs_backup.sql
wget https://raw.githubusercontent.com/BahmniIndiaDistro/distro/master/base/india_distro_base_db/openelis_backup.sql
wget https://raw.githubusercontent.com/BahmniIndiaDistro/distro/master/base/india_distro_base_db/openerp_backup.sql
```
* Use [distro-config](https://github.com/BahmniIndiaDistro/distro-config) as the config for this installation.
```
cd /etc/bahmni-installer/deployment-artifacts/
wget https://github.com/BahmniIndiaDistro/distro-config/archive/master.zip
unzip master.zip
rm master.zip
mv distro-config-master india-distro_config
```
* Change `implementation-name` to `india-distro` in `/etc/bahmni-installer/setup.yml`.
* Run the installer

Once the installation is done you should have the bahmni up with the base data.

#### Install the bahmni analytics app
To install the bahmni analytics app you need to do the following :-

* Create a properties file `/tmp/app.properties` with below contents. The values in `<>` needs to be changed.
```
host=localhost
sshUsername=bahmni_support
identityFilePath=dummy_file
mysqlDbName=openmrs
mysqlUser=<mysql user name>
mysqlPassword=<mysql user password>
localMysqlPort=3306
usePostgres=TRUE
psqlDbName=openerp
psqlUser=<openerp user name>
psqlPassword=<openerp passowrd>
localPsqlPort=5432
pluginsFolder=/var/lib/bahmni-shiny/plugins/
sqliteDbFilePath=/var/lib/bahmni-shiny/shiny.sqlite
preferencesFolderPath=/var/lib/bahmni-shiny/preferences/
```
* Download the `setup_analytics.sh`.

```
sudo su
wget https://raw.githubusercontent.com/BahmniIndiaDistro/distro/master/setup_analytics.sh
```

* Run the `setup_analytics.sh`.

```
sh setup_analytics.sh
```

The above will setup analytics application with the minimal visualisatons. Visualisations about specific program will come along with the module installation.

### Setup Distro Module Manager and User
This is a utility service which helps us to install the different modules for specific purpose. Checkout the [README](https://github.com/BahmniIndiaDistro/distro-module-manager/blob/master/README.md) for how to install and use.



## Contributing to the distro

#### Changes in base-distro database
If there are changes needed as base-distro DBs. Follow the below steps:-
* Make sure you have a fresh installation of distro. Make sure no modules are installed.
* Make the necessary changes needed in the database. You need to export the DB dumps along with the schema and push it to github.
```
mysqldump --routines -uroot -p openmrs > openmrs_backup.sql
pg_dump -U postgres clinlims > openelis_backup.sql
pg_dump -U postgres openerp > openerp_backup.sql
```
* Overwrite the above files in `distro/master/base/india_distro_base_db` and push to github.
