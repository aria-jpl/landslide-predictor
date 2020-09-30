#!/bin/bash -xv

#set -e

# ------------------------------------------------------------------------------
# Automatically determines the full canonical path of where this script is
# located--regardless of what path this script is called from. (if available)
# ${BASH_SOURCE} works in both sourcing and execing the bash script.
# ${0} only works for when execing the bash script. ${0}==bash when sourcing.
BASE_PATH=$(dirname "${BASH_SOURCE}")
# convert potentially relative path to the full canonical path
BASE_PATH=$(cd "${BASE_PATH}"; pwd)
# get the name of the script
BASE_NAME=$(basename "${BASH_SOURCE}")
# ------------------------------------------------------------------------------

WORK_DIR=$(pwd)
echo "WORK_DIR:" $WORK_DIR


s3Uri=`python $BASE_PATH/get_param.py`


eval "$(/opt/conda/bin/conda shell.bash hook)"

echo "which conda"
which conda

#------
# run predictor
(
echo "run predictor"

date

cd $BASE_PATH/predictor

sh -xv ./run.sh

date
)

#------
# run plot
(
echo "run plot"

date

cd ${BASE_PATH}/plot

sh -xv ./run.sh

date
)

#------
# save result
(
echo "create dataset"

date

cd ${BASE_PATH}

sh -xv ./create_dataset.sh $WORK_DIR $BASE_PATH

date
)
