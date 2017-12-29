SELECT DISTINCT
  pi.identifier  AS 'Identifier',
  pn.given_name  AS 'Given Name',
  pn.family_name AS 'Family Name',
  p.Gender,
  DATE_FORMAT(NOW(), '%Y') - DATE_FORMAT(p.dob, '%Y') - (DATE_FORMAT(NOW(), '00-%m-%d') < DATE_FORMAT(p.dob, '00-%m-%d')) AS Age,
  pa.value AS 'Contact Number'
FROM obs o
  INNER JOIN patient_identifier pi ON pi.patient_id = o.person_id
  INNER JOIN person_name pn ON pn.person_id = o.person_id
  INNER JOIN person p ON o.person_id = p.person_id
  INNER JOIN person_attribute pa ON p.person_id = pa.person_id
WHERE o.concept_id =
      ( SELECT concept_id FROM concept_name WHERE name = "Hypertension Screening Done" AND concept_name_type = "FULLY_SPECIFIED")
      AND o.value_coded =
          ( SELECT concept_id FROM concept_name WHERE name = "NO" AND concept_name_type = "FULLY_SPECIFIED")
      AND pa.person_attribute_type_id =
          (SELECT person_attribute_type_id FROM person_attribute_type WHERE name = "primaryContact")
      AND pi.identifier_type =
          (SELECT patient_identifier_type_id FROM patient_identifier_type WHERE name = "Patient Identifier")
      AND DATE_FORMAT(NOW(), '%Y') - DATE_FORMAT(p.dob, '%Y') - (DATE_FORMAT(NOW(), '00-%m-%d') < DATE_FORMAT(p.dob, '00-%m-%d')) > 30;