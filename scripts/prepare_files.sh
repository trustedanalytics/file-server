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


getAtkAndBuildClientPackage() {

cd ./scripts

   echo "Fetching ATK from github"

   git clone https://github.com/trustedanalytics/atk.git


   mkdir -p atk/package/config/trustedanalytics-python-client/trustedanalytics

   cp -r atk/python-client/trustedanalytics atk/package/config/trustedanalytics-python-client/trustedanalytics/


      cd atk/package/config/trustedanalytics-python-client/

      set +e
      ./pypi.sh intel-data trustedanalytics `date '+%d%m%Y_%H%M%S'` build 
      set -e

   cd -

   cp atk/package/config/trustedanalytics-python-client/trustedanalytics/dist/*.tar.gz ./
   pwd

   rm -fr atk

cd ..

}

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
rm -fr scripts/*.tar.gz

# download repository content


getAtkAndBuildClientPackage
echo "ATK FETCHED"

find ./|grep tar.gz |wc -l


for file in `find ./scripts/ |grep tar.gz`; do mv $file $REPO_FOLDER/; done


echo "Indexing files"
cd $REPO_FOLDER
   makeindex
cd -
echo "Done"

