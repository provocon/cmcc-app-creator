#
# Copyright 2019 Markus Schwarz.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
ARG JAVA_APPLICATION_BASE_IMAGE_TAG
ARG JAVA_APPLICATION_BASE_IMAGE_REPO
FROM ${JAVA_APPLICATION_BASE_IMAGE_REPO}:${JAVA_APPLICATION_BASE_IMAGE_TAG}
ENV JAVA_HEAP=256m
#VOLUME /coremedia/cache
EXPOSE 8080
HEALTHCHECK --start-period=30s --interval=30s --timeout=3s CMD curl -Lf http://localhost:8080/my-new-health || exit 1
COPY --chown=coremedia:coremedia src/docker /coremedia
COPY --chown=coremedia:coremedia target/##APP-NAME##-app.jar /coremedia/application.jar
# Windows compatibility step
RUN find /coremedia -type d -exec chmod 770 {} \;
CMD ["application"]
