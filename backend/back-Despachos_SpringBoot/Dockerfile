FROM maven:3.9.6-eclipse-temurin-17 AS build

WORKDIR /app

# Copiar pom.xml primero para aprovechar cache de dependencias
COPY Springboot-API-REST-DESPACHO/pom.xml .
RUN mvn dependency:go-offline -B

COPY Springboot-API-REST-DESPACHO/src ./src

RUN mvn clean package -DskipTests -B

FROM eclipse-temurin:17-jre-alpine

# Usuario no root 
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

WORKDIR /app

COPY --from=build /app/target/*.jar app.jar

# Cambiar propietario al usuario no root
RUN chown appuser:appgroup app.jar

USER appuser

EXPOSE 8081

HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
  CMD wget --quiet --tries=1 --spider http://localhost:8081/actuator/health || exit 1

ENTRYPOINT ["java", "-jar", "app.jar"]