# Urgent News
## Docker Files
### Database
This pulls the main mysql 5.7 image and intitializes a db with credentials, then executes the sql script I added in the same directory to that database.
```
FROM mysql:5.7

ENV MYSQL_DATABASE=UrgentNews \
    MYSQL_USER=user \
    MYSQL_PASSWORD=password \
    MYSQL_ROOT_PASSWORD=password

COPY ./InitializeDb.sql /docker-entrypoint-initdb.d/
```
Image Link: https://hub.docker.com/repository/docker/doppura/urgent-news-mysql
### Backend
This pulls the .NET 7 SDK and then:
- Restores the project's Nuget packages
- Publishes (extracts artifacts) of the application and places them in a directory called out
- Then it takes the published files and sets them in an app directory inside the image
- Sets the entry point of the image being the application's startup
```
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build

WORKDIR /app

# Copy and restore the project file
COPY ./UrgentNews/UrgentNews.csproj .
RUN dotnet restore

# Copy the remaining source code and build the application
COPY ./UrgentNews/. .
RUN dotnet publish -c Release -o out

# Runtime image
FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS runtime

WORKDIR app

# Copy the published output from the build image
COPY --from=build /app/out .

# Set the entry point
ENTRYPOINT ["dotnet", "UrgentNews.dll"]
```
Image Link: https://hub.docker.com/repository/docker/doppura/urgent-news-backend
### Client
This builds the nodejs's application's artifacts (by pulling the node:18 image from docker), then sets the default apache2 server's website to the built app
```
FROM node:18 AS builder

WORKDIR /app

COPY . .

RUN yarn install

RUN yarn build

FROM httpd:2.4

COPY --from=builder /app/dist /usr/local/apache2/htdocs

```
Image Link: https://hub.docker.com/repository/docker/doppura/urgent-news-client

## Docker Compose
This script builds each dockerfile mentioned above, and sets the environment variables for each of the built containers. Then exposes each container to a certain port on the host machine, enabling them to be used in between each other
```
version: "3"
services:
  mysql:
    build:
      context: ./database
      dockerfile: database.Dockerfile
    container_name: mysql
    ports:
      - 3306:3306
  backend:
    build:
      context: ./backend
      dockerfile: backend.Dockerfile
    container_name: backend
    environment:
      - UrgentNewsConnection=server=mysql;port=3306;userid=user;password=password;database=UrgentNews
    ports:
      - 5000:5000
    depends_on:
      - mysql
  client:
    build:
      context: ./client
      dockerfile: client.Dockerfile
    ports:
      - 8080:80
    depends_on:
      - backend
```
## Running The Application
Navigate to the root directory of the application, then execute `docker-compose up`, then input `localhost:8080` on the browser to see the client, or `localhost:5000`, to see the swagger generation for the APIs from the backend container.
