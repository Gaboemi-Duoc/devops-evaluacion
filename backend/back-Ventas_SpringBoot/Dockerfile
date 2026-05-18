# =============================================
# STAGE 1: BUILD
# =============================================
FROM maven:3.9.6-eclipse-temurin-17 AS build

WORKDIR /app

# Copiar pom.xml primero para aprovechar cache de dependencias
COPY Springboot-API-REST/pom.xml .
RUN mvn dependency:go-offline -B

# Copiar el resto del código fuente
COPY Springboot-API-REST/src ./src

# Compilar y empaquetar (sin tests para acelerar el build)
RUN mvn clean package -DskipTests -B

# =============================================
# STAGE 2: RUNTIME
# =============================================
FROM eclipse-temurin:17-jre-alpine

# Usuario no root (buena práctica de seguridad)
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

WORKDIR /app

# Copiar solo el JAR generado desde el stage de build
COPY --from=build /app/target/*.jar app.jar

# Cambiar propietario al usuario no root
RUN chown appuser:appgroup app.jar

USER appuser

# Puerto del microservicio Ventas (por defecto Spring Boot)
EXPOSE 8080

# Healthcheck básico
HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
  CMD wget --quiet --tries=1 --spider http://localhost:8080/actuator/health || exit 1

ENTRYPOINT ["java", "-jar", "app.jar"]