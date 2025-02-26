FROM --platform=${BUILDPLATFORM} mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /App
ARG BUILDPLATFORM, TARGETPLATFORM, TARGETARCH
RUN echo "Build Platform: $BUILDPLATFORM"
RUN echo "Target Platform: $TARGETPLATFORM"
RUN echo "Target Arch: $TARGETARCH"
COPY . ./
RUN dotnet restore -a $TARGETARCH
RUN dotnet publish -c release -o /app -a $TARGETARCH --self-contained false --no-restore ./Worker.csproj
EXPOSE 80
FROM mcr.microsoft.com/dotnet/runtime:8.0
WORKDIR /App
COPY --from=build /app .
ENTRYPOINT ["dotnet", "Worker.dll"]
#docker build --build-arg BUILDPLATFORM=arm64 --build-arg TARGETPLATFORM=linux/amd64 --build-arg TARGETARCH=amd64 -t worker .   