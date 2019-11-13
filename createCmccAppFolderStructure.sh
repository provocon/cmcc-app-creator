#!/bin/bash
if [ $# -ne 2 ]; then
  echo "      ./createCmccAppFolderStructure.sh EXISTING-TARGET-DIRECTORY APP-NAME"
  echo "e.g.: ./createCmccAppFolderStructure.sh ~/importer-component importer"
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
