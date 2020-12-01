FROM swift:5.3 AS build
WORKDIR /app
COPY Package.swift ./
RUN swift package update
COPY ./ ./
RUN swift build -c release
RUN mv /app/.build/release/AdventOfCode2020 /app/.build/release/aoc2020

FROM swift:5.3-slim
WORKDIR /app
COPY --from=build /app/.build/release/ /app/
ENTRYPOINT [ "/app/aoc2020" ]
