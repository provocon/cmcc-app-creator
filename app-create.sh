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
  echo "      $0 CMCC-TARGET-DIRECTORY APP-NAME"
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

# TARGET_DIR seems to be the workspace root
if [ -d $TARGET_DIR/workspace-configuration ] ; then
  if [ -d $TARGET_DIR/apps ] ; then
    echo "Found CMCC Workspace in $TARGET_DIR."
    TARGET_DIR=$TARGET_DIR/apps
  fi
fi

# TARGET_DIR seems to be the apps root
if [ -d $TARGET_DIR/content-server ] ; then
  echo "CMCC Apps reside in $TARGET_DIR."
  TARGET_DIR=$TARGET_DIR/$NEW_APP_NAME
  if [ ! -d $TARGET_DIR/$NEW_APP_NAME ] ; then
    mkdir $TARGET_DIR
    echo "New App Directory created as $TARGET_DIR."
  fi
fi

# https://github.com/koalaman/shellcheck/wiki/SC2103#use-a--subshell--to-avoid-having-to-cd-back
(
  cd "$TARGET_DIR" || exit

  createFolderAndReplacePom "${NEW_APP_NAME}"-blueprint-bom blueprint-bom
  createFolderAndReplacePom .
  createFolderAndReplacePom blueprint-parent
  createFolderAndReplacePom modules
  createFolderAndReplacePom docker
  createFolderAndReplacePom docker/"$NEW_APP_NAME" docker-app
  sed "s/##APP_NAME##/${NEW_APP_NAME}/g" "$SCRIPT_TEMPLATE_FOLDER"/templates/docker-app/Dockerfile > docker/"$NEW_APP_NAME"/Dockerfile

  createFolderAndReplacePom spring-boot
  createFolderAndReplacePom spring-boot/"$NEW_APP_NAME"-app spring-boot-app
  cp -r "$SCRIPT_TEMPLATE_FOLDER"/templates/spring-boot-app/src spring-boot/"$NEW_APP_NAME"-app
)
