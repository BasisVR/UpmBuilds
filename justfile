# Default recipe to run when just is called without arguments
default: build

# Set the project name
project := "SimpleBase"

# Clean build outputs
clean:
    dotnet clean
    rm -rf **/bin **/obj

# Restore NuGet packages
restore:
    dotnet restore

# Build the project
build: restore
    dotnet build --configuration Release

# Create a new release build
release: clean restore
    dotnet publish --configuration Release --output ./publish
