FROM python:3.7-slim AS compile-image
ENTRYPOINT ["tail"]
CMD ["-f","/dev/null"]
FROM streamsets/datacollector:3.22.1
ARG SDC_LIBS
RUN "${SDC_DIST}/bin/streamsets" stagelibs -install="${SDC_LIBS}"
