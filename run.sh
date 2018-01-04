docker run --name liferay6-db -e POSTGRES_DB=lportal -e POSTGRES_USER=liferay -e POSTGRES_PASSWORD=liferay --publish 5433:5432 postgres
docker run --name initial --link liferay6-db:postgres --publish 8080:8080 --volume ~/docker/liferay6/deploy:/usr/local/liferay-portal-6.2-ce-ga6/deploy borxa/liferay6-single:latest
