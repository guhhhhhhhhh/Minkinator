FROM eclipse-temurin:19-jdk-alpine AS builder

COPY gradle /repo/gradle
COPY src /repo/src
COPY gradlew gradlew.bat build.gradle.kts settings.gradle.kts /repo/
WORKDIR /repo

RUN ./gradlew installDist --no-daemon

FROM eclipse-temurin:19-jre-alpine AS runner

COPY --from=builder /repo/build/install/Minkinator /app/
ENTRYPOINT ["/app/bin/Minkinator"]