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
            'lms_lmssettings'
        ) }}
),

data_type_rename_conversion AS (
    SELECT
        "id" :: VARCHAR AS "lmssetting_id",
        "name" :: VARCHAR AS "name",
        "value" :: BOOLEAN AS "value",
        "entityid" :: VARCHAR AS "entityid",
        "tenantid" :: INT AS "tenant_id",
        "isdeleted" :: BOOLEAN AS "is_deleted",
        "entitytype" :: VARCHAR AS "entitytype",
        {{ to_timestamp("creationtime") }} :: TIMESTAMP AS "creation_time",
        {{ to_timestamp("deletiontime") }} :: TIMESTAMP AS "deletion_time",
        "creatoruserid" :: INT AS "creator_user_id",
        "deleteruserid" :: INT AS "deleter_user_id",
        "lastmodifieruserid" :: INT AS "last_modifier_user_id",
        {{ to_timestamp("lastmodificationtime") }} :: TIMESTAMP AS "last_modification_time"
    FROM
        source
)

SELECT
    *
FROM
    data_type_rename_conversion
