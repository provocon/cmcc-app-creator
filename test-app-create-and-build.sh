NEW_APP_NAME=test-app-$(date +%s)
NEW_APP_DIR=/tmp/"$NEW_APP_NAME"

mkdir "$NEW_APP_DIR"

./app-create.sh "$NEW_APP_DIR" "$NEW_APP_NAME"

cd "$NEW_APP_DIR"

mvn install

if [ $? -eq 0 ];
then
    echo "New workspace was built successfully. Removing it."
    rm -rf "$NEW_APP_DIR"
else
    echo "$NEW_APP_DIR was not built successfully. Leaving it for further examination."
fi
