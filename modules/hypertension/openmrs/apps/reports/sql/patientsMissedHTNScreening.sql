SELECT Identifier, `Given Name`, `Family Name`, Gender, Age, `Contact Number`  FROM (SELECT
   p.person_id,
   pi.identifier                             AS 'Identifier',
   pn.given_name                             AS 'Given Name',
   pn.family_name                            AS 'Family Name',
   p.Gender,
   TIMESTAMPDIFF(YEAR, birthdate, CURDATE()) AS 'Age',
   pa.value                                  AS 'Contact Number'
 FROM person p
   INNER JOIN patient_identifier pi ON pi.patient_id = p.person_id AND pi.identifier_type =
                                                                       (SELECT patient_identifier_type_id
                                                                        FROM patient_identifier_type
                                                                        WHERE name = "Patient Identifier")
   INNER JOIN person_name pn ON pn.person_id = p.person_id
   LEFT JOIN person_attribute pa ON p.person_id = pa.person_id AND pa.person_attribute_type_id =
                                                                   (SELECT person_attribute_type_id
                                                                    FROM person_attribute_type
                                                                    WHERE name = "primaryContact")
 WHERE p.person_id NOT IN (
   SELECT person_id
   FROM obs
   WHERE concept_id =
         (SELECT concept_id FROM concept_name WHERE name = "Hypertension Screening Done" AND concept_name_type = "FULLY_SPECIFIED")
         AND value_coded =
             (SELECT concept_id FROM concept_name WHERE name = "True" AND concept_name_type = "FULLY_SPECIFIED"))
) as tbl WHERE Age >= 30;