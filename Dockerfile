# STAGE 1: The Build Environment
# We use the JDK (Java Development Kit) to compile the code.

FROM eclipse-temurin:25-jdk-alpine AS build

# Use an absolute path starting with /
WORKDIR /app

# Copy everything from your local folder to the current WORKDIR (/app)
COPY . .

RUN chmod +x gradlew

# Build the executable .jar file (skipping tests for speed)
RUN ./gradlew clean assemble -x test --no-daemon

# STAGE 2: The Runtime Environment
# we switch to the JRE (Java Runtime Environment) for a much smaller image.

FROM eclipse-temurin:25-jre-alpine

WORKDIR /app

COPY --from=build /app/build/libs/*.jar app.jar

# Inform Docker that the container listens on port 8443
EXPOSE 8443

# The command to start your Spring Boot app
ENTRYPOINT ["java", "-jar", "app.jar"]