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
