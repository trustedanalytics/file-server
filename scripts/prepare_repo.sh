#!/bin/bash
#
# Copyright (c) 2015 Intel Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

set -eu
# run the script from main directory

REPO_FOLDER=src/main/resources/static/files

makeindex() {

	rm -fr index.html
		rm -fr atkclient

		for file in `ls *.gz |sort -r`; do

			echo "<a href=\"$file\">$file</a>" >> index.html
				echo "Adding $file"

		done
		for file in `ls *.gz |sort -r`; do

				echo "{ \"file\": \"$file\" }" >> atkclient
				echo "Putting $file to atkclient"
				break
		done
}

mkdir -p $REPO_FOLDER
#remove old repo content
rm -fr $REPO_FOLDER/*

# download repository content


wget http://host.gao.intel.com/pypi/master/simple/trustedanalytics/ -r -l 1

#copy *tar.gz to main directory
for file in `find ./|grep tar.gz`; do mv $file $REPO_FOLDER/; done

#remove not necessary folder left by wget
rm -fr host.gao*


echo "Indexing files"
cd $REPO_FOLDER
makeindex
cd -
echo "Done"

