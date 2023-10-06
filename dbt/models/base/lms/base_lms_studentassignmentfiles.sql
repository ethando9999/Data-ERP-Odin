{{ config(
    materialized = 'view',
    schema = 'base'
) }}

WITH source AS (

    SELECT
        *
    FROM
        {{ source(
            'raw_lms',
            'lms_studentassignmentfiles'
        ) }}
),

data_type_rename_conversion AS (
    SELECT
        "id" :: VARCHAR AS "studentassignmentfiles_id",
        "filename" :: VARCHAR AS "filename",
        "filepath" :: VARCHAR AS "filepath",
        "minetype" :: VARCHAR AS "minetype",
        "tenantid" :: INT AS "tenantid",
        "isdeleted" :: BOOLEAN AS "isdeleted",
        {{ to_timestamp("creationtime") }} :: TIMESTAMP AS "creation_time",
        {{ to_timestamp("deletiontime") }} :: TIMESTAMP AS "deletion_time",
        "coursegroupid" :: VARCHAR AS "coursegroupid",
        "creatoruserid" :: INT AS "creator_user_id",
        "deleteruserid" :: INT AS "deleter_user_id",
        "lastmodifieruserid" :: INT AS "last_modifier_user_id",
        "assignmentsettingid" :: VARCHAR AS "assignmentsettingid",
        {{ to_timestamp("lastmodificationtime") }} :: TIMESTAMP AS "last_modification_time",
        "courseassignedstudentid" :: VARCHAR AS "courseassignedstudentid"
    FROM
        source
)

SELECT
    *
FROM
    data_type_rename_conversion