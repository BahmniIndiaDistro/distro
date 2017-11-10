# Distro
This will contain the database dump files, report &amp; form definitions.

### Steps to setup base DB
###### Openmrs
	Drop openmrs Database
	Create openmrs database 
	From https://github.com/BahmniIndiaDistro/distro
		Apply the openmrs_base_db.sql(Diagnosis set of sets missing)
###### OpenELIS
	Drop clinlims Database
	create clinlims database
	From https://github.com/BahmniIndiaDistro/distro
		Apply the clinlims_base_db.sql

###### OpenERP
	Drop openERP Database
	create openERP database
	From https://github.com/BahmniIndiaDistro/distro
		Apply the openerp_base_db.sql

### Steps to setup module
* Upload Module/concepts.csv using bahmni csv upload.
* Upload Module/concept_sets.csv using bahmni csv upload.
