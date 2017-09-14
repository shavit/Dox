# Self Hosted Geocoding Solution

Convert street addresses to GPS coordinates without making any external API calls, without limit to the number of geocode requests that you can make.

![Geocoder](https://github.com/shavit/Team10House/blob/master/doc/preview.png?raw=true)

This project divided into 2 Docker images:
1. PostGIS Geocoder, based on [moofish32/postgis-geocoder](https://hub.docker.com/r/moofish32/postgis-geocoder/)
2. Go CLI tool

## Usage
1. Start the PostGIS service and compile the CLI tool: `make api`
2. Download the data: `make postgis`
3. To use the CLI run `docker exec -ti app_api app [adddress]`

## Requiremetns
* The downloads can take more than 60GB of disk space
* The database can take more than 5GB
* You should optimize that database to your needs.

## Troubleshooting
* You need to manage the downloads of each state in case of no response from the servers.
* There is a hard-coded `DATABASE_URI` environment variable in the `Dockerfile` that you might want to change.
* For batch requests, edit the `app/main.go` file
