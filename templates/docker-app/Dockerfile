ARG JAVA_APPLICATION_BASE_IMAGE_TAG
ARG JAVA_APPLICATION_BASE_IMAGE_REPO
FROM ${JAVA_APPLICATION_BASE_IMAGE_REPO}:${JAVA_APPLICATION_BASE_IMAGE_TAG}
ENV JAVA_HEAP=256m
#VOLUME /coremedia/cache
EXPOSE 8080
HEALTHCHECK --start-period=30s --interval=30s --timeout=3s CMD curl -Lf http://localhost:8080/my-new-health || exit 1
COPY --chown=coremedia:coremedia src/docker /coremedia
COPY --chown=coremedia:coremedia target/##APP_NAME##-app.jar /coremedia/application.jar
# Windows compatibility step
RUN find /coremedia -type d -exec chmod 770 {} \;
CMD ["application"]
