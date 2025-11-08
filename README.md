# Getting Started

# Spring Boot (vkspringboot) + Prometheus + Grafana — Complete Local Monitoring Guide (2025)


Spring Boot (vkspringboot) + Prometheus + Grafana — Complete Local Monitoring Guide (2025)

A full end-to-end local observability setup using Spring Boot, Prometheus, Grafana, and Docker Compose.

This guide works on:

✅ Windows
✅ macOS
✅ Linux
✅ IntelliJ / VS Code
✅ Step 0 — Create Spring Boot Project (Name: vkspringboot)
In IntelliJ / Spring Initializr:

    Open IntelliJ → New Project

    Select Spring Initializr

    Fill project details:

Field	Value
Group	com.example
Artifact	vkspringboot
Name	vkspringboot
Java Version	17 or 21
Packaging	Jar

    Select dependencies:
    ✅ Spring Web
    ✅ Spring Boot Actuator
    ✅ Micrometer Prometheus Registry

Click Create.
This generates your project:

vkspringboot/
├── pom.xml
├── src/main/java/com/example/vkspringboot/
└── src/main/resources/

✅ Step 1 — Add Dependencies to pom.xml

Ensure your pom.xml contains:

<dependency>
    <groupId>io.micrometer</groupId>
    <artifactId>micrometer-registry-prometheus</artifactId>
</dependency>

<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-actuator</artifactId>
</dependency>

<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-web</artifactId>
</dependency>

✅ Step 2 — Enable Prometheus Metrics Endpoint

Create or edit:

src/main/resources/application.properties

management.endpoints.web.exposure.include=prometheus,health,info
management.endpoint.prometheus.enabled=true

Metrics will appear at:

👉 http://localhost:8080/actuator/prometheus
✅ Step 3 — Create a Simple REST Controller

src/main/java/com/example/vkspringboot/HelloController.java

package com.example.vkspringboot;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {

    @GetMapping("/hello")
    public String hello() {
        return "Hello!";
    }
}

Test it:

👉 http://localhost:8080/hello
✅ Step 4 — Create Dockerfile (Updated for vkspringboot)

Your Maven build produces:

target/vkspringboot-0.0.1-SNAPSHOT.jar

So your Dockerfile must match it:

# Use official Java runtime
FROM eclipse-temurin:17-jdk

# Set working directory
WORKDIR /app

# Copy the JAR file
COPY target/vkspringboot-0.0.1-SNAPSHOT.jar app.jar

# Expose Spring Boot default port
EXPOSE 8080

# Start the Spring Boot application
ENTRYPOINT ["java", "-jar", "/app/app.jar"]

✅ Correct JAR name
✅ Java 17 (matches project)
✅ Step 5 — Docker Compose (App + Prometheus + Grafana)

Create docker-compose.yml in project root:

version: "3.9"

services:
app:
build: .
container_name: vkspringboot
ports:
- "8080:8080"

prometheus:
image: prom/prometheus
container_name: prometheus
volumes:
- ./prometheus.yml:/etc/prometheus/prometheus.yml
ports:
- "9090:9090"

grafana:
image: grafana/grafana
container_name: grafana
ports:
- "3000:3000"

✅ Step 6 — Prometheus Config File

Create prometheus.yml in project root:

global:
scrape_interval: 5s

scrape_configs:
- job_name: 'vkspringboot'
  metrics_path: '/actuator/prometheus'
  static_configs:
    - targets: ['app:8080']

✅ Prometheus scrapes Spring Boot every 5 seconds
✅ Uses service name app from Docker Compose
✅ Step 7 — Build the Project + Run the Stack
1️⃣ Build the JAR

mvn clean package -DskipTests

2️⃣ Start everything

docker compose up --build

✅ Step 8 — Access All Tools Locally
Component	URL
✅ Spring Boot App	http://localhost:8080/hello
✅ Spring Metrics	http://localhost:8080/actuator/prometheus
✅ Prometheus	http://localhost:9090
✅ Grafana	http://localhost:3000
(login: admin / admin)
✅ Step 9 — Connect Grafana to Prometheus

In Grafana:

    Go to Configuration → Data Sources

    Add Prometheus

    URL:

http://prometheus:9090

    Click Save & Test

✅ Grafana is now connected.
✅ Step 10 — Import Spring Boot Dashboards

Grafana → Dashboard → Import → Enter ID:

✅ 11378 — Spring Boot Micrometer Dashboard
✅ 4701 — JVM + Spring Boot Metrics

You will now see:

✅ API Request Count
✅ Response Time
✅ JVM Memory
✅ CPU Usage
✅ GC Metrics
✅ Thread pools
✅ Uptime
✅ ✅ Final Summary

1. Create Spring Boot project named "vkspringboot"
2. Add Micrometer + Actuator dependencies
3. Expose /actuator/prometheus
4. Create Dockerfile using vkspringboot-0.0.1-SNAPSHOT.jar
5. Use docker-compose to run Spring Boot + Prometheus + Grafana
6. Add Prometheus as a Grafana data source
7. Import pre-built dashboards

You now have a complete local observability platform for Spring Boot.