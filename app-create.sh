#!/bin/bash
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
if [ $# -ne 2 ]; then
  echo "      $0 EXISTING-TARGET-DIRECTORY APP-NAME"
  echo "e.g.: $0 ~/importer-component importer"
  exit 1
fi

TARGET_DIR=$1
NEW_APP_NAME=$2
SCRIPT_TEMPLATE_FOLDER=$(dirname $0)
if [ "$SCRIPT_TEMPLATE_FOLDER" = '.' ]; then
  SCRIPT_TEMPLATE_FOLDER="$(pwd)" # current dir
fi

createFolderAndReplacePom() {    
  TARGET_FOLDER=$1
  TEMPLATE_FOLDER="$TARGET_FOLDER"
  if [ $# -eq 2 ]; then
    TEMPLATE_FOLDER=$2
  fi
  [ -d "$TARGET_FOLDER" ] || mkdir "$TARGET_FOLDER"
  sed "s/##APP_NAME##/${NEW_APP_NAME}/g" "$SCRIPT_TEMPLATE_FOLDER"/templates/"$TEMPLATE_FOLDER"/pom.xml > "$TARGET_FOLDER"/pom.xml
}

# https://github.com/koalaman/shellcheck/wiki/SC2103#use-a--subshell--to-avoid-having-to-cd-back
(
  cd "$TARGET_DIR" || exit

  createFolderAndReplacePom "${NEW_APP_NAME}"-blueprint-bom blueprint-bom
  createFolderAndReplacePom blueprint-parent
  createFolderAndReplacePom modules
  createFolderAndReplacePom spring-boot
  createFolderAndReplacePom spring-boot/"$NEW_APP_NAME"-app spring-boot-app
  createFolderAndReplacePom docker
  createFolderAndReplacePom docker/"$NEW_APP_NAME"-app docker-app
  sed "s/##APP_NAME##/${NEW_APP_NAME}/g" "$SCRIPT_TEMPLATE_FOLDER"/templates/docker-app/Dockerfile > docker/"$NEW_APP_NAME"-app/Dockerfile
)
