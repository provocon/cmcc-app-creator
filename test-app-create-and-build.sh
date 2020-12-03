#!/bin/bash
#
# Copyright 2020 Markus Schwarz.
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
