docker-compose -f docker-compose-dwh.yml -f docker-compose-airbyte.yml -f docker-compose-airflow.yml -f docker-compose-superset.yml --env-file .env down