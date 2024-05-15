# Use the official Microsoft .NET SDK image as the base image
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build

# Set the working directory to the root directory of the project
WORKDIR /app

# Copy the entire project directory into the container
COPY . .

# Restore the NuGet packages
RUN dotnet restore

# Build the project
RUN dotnet build -c Release

# Publish the project
RUN dotnet publish -c Release -o out

# Use the official Microsoft .NET runtime image as the base image for the final stage
FROM mcr.microsoft.com/dotnet/runtime:6.0

# Set the working directory to the root directory of the project
WORKDIR /app

# Copy the published files from the build stage
COPY --from=build /app/out .

# Set the entry point to the published application
ENTRYPOINT ["dotnet", "StudentManagementSystem.dll"]