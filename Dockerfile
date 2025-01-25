##importa o maven na versão 3.8.4
FROM maven:3.8.3-openjdk-17 AS build

##Copida todos os arquivos para dentro da aplicaçõo - src para dentro de app/src(DENTRO DO CONTAINER)
COPY src /app/src
COPY pom.xml /app

##ENTRA DENTRO DO DIRETORIO
WORKDIR /app

##APOS ENTRAR DENTRO DO /APP INTALA AS DEPENDENCIAS COM O MAVEN E BUID DA APLICACAO
RUN mvn clean install

FROM eclipse-temurin:17-jdk

##Copiar o jar pelo build para dentro do /app/jar
COPY --from=build /app/target/spring-boot-docker-0.0.1-SNAPSHOT.jar /app/app.jar

##ENTRA DENTRO DO DIRETORIO
WORKDIR /app

EXPOSE 8080

##COMANDO EXECUTADO DENTRO DO CONTAINER
CMD ["java", "-jar","app.jar"]


