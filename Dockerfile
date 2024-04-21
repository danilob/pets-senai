# FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base

# EXPOSE 80
# EXPOSE 443
# ARG source
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /source
COPY . .
RUN dotnet restore "./Projeto_Web-Lh_Pets_Alunos.csproj" --disable-parallel
RUN dotnet publish "./Projeto_Web-Lh_Pets_Alunos.csproj" -c realease -o /app --no-restore

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
COPY --from=build /app .

EXPOSE 7350

ENTRYPOINT [ "dotnet", "Projeto_Web-Lh_Pets_Alunos.dll"]
# COPY ["MeuProjeto/MeuProjeto.csproj", "MeuProjeto/"]
# RUN apt-get update \
#     && apt-get install -y mssql-tools \
#     && apt-get clean 

# RUN /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'MyPETS#001' -i vendas.sql

# RUN dotnet new web --use-program main

# WORKDIR "/src/MeuProjeto"
# RUN dotnet build "MeuProjeto.csproj" -c Release -o /app/build

# FROM build AS publish
# RUN dotnet publish "MeuProjeto.csproj" -c Release -o /app/publish

# FROM base AS final
# WORKDIR /app
# COPY --from=publish /app/publish .
# ENTRYPOINT ["dotnet", "run"]
