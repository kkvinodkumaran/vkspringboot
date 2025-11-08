# Getting Started

# Spring Boot (vkspringboot) + Prometheus + Grafana — Complete Local Monitoring Guide (2025)


mvn clean package -DskipTests

2️⃣ Start everything

docker compose up --build

✅ Access All Tools Locally
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

