#!/bin/bash
#
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements. See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership. The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License. You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied. See the License for the
# specific language governing permissions and limitations
# under the License.
#

VER_NUM="dev-$CURR_VERSION-build.1$GITHUB_SHA_SHORT"
CONTAINER_MAIN_TAG="dev"
FINERACT_SECURITY_AUTH0_DOMAIN="devauth.velocitynetwork.foundation"
FINERACT_SECURITY_AUTH0_ISSUER_URI="https://$FINERACT_SECURITY_AUTH0_DOMAIN/"
FINERACT_SECURITY_AUTH0_AUDIENCE="$FINERACT_SECURITY_AUTH0_ISSUER_URI/userinfo"

echo "VER_NUM=$VER_NUM" >> $GITHUB_ENV
echo "CONTAINER_MAIN_TAG=$CONTAINER_MAIN_TAG" >> $GITHUB_ENV
echo "FINERACT_SECURITY_AUTH0_DOMAIN=$FINERACT_SECURITY_AUTH0_DOMAIN" >> $GITHUB_ENV
echo "FINERACT_SECURITY_AUTH0_ISSUER_URI=$FINERACT_SECURITY_AUTH0_ISSUER_URI" >> $GITHUB_ENV
echo "FINERACT_SECURITY_AUTH0_AUDIENCE=$FINERACT_SECURITY_AUTH0_AUDIENCE" >> $GITHUB_ENV
