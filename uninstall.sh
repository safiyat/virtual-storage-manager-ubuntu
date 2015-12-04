#!/bin/bash

# Copyright 2014 Intel Corporation, All Rights Reserved.

# Licensed under the Apache License, Version 2.0 (the"License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

#  http://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied. See the License for the
# specific language governing permissions and limitations
# under the License.


#!/bin/bash

TOPDIR=$(cd $(dirname "$0") && pwd)
USER=`whoami`

source $TOPDIR/installrc

for ip in $CONTROLLER_ADDRESS; do
    ssh -t $ip "sudo clean-data -f; sudo service vsm-api stop; sudo service vsm-scheduler stop; sudo service vsm-conductor stop; sudo service mysql restart; sudo service rabbitmq-server restart; sleep 3; sudo apt-get remove --yes vsm vsm-dashboard python-vsmclient vsm-deploy; sudo apt-get autoclean --yes"
done

for ip in $AGENT_ADDRESS_LIST; do
    ssh -t $ip "sudo clean-data -f; sudo service vsm-agent stop; sudo service vsm-physical stop; sudo apt-get remove --yes vsm vsm-dashboard python-vsmclient vsm-deploy; sudo apt-get autoclean --yes"
done

