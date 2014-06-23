#!/bin/bash
# this is used for prepare task feature for develop set


# Configure paths by editing LOCAL_CONFIG, then load it.
if [ -e LOCAL_CONFIG ] ; then
    . LOCAL_CONFIG
else
    print_msg 'Copy LOCAL_CONFIG.template to LOCAL_CONFIG and adapt paths as needed.'
    exit 1
fi

# if  [ $extractFeatures != true ] ; then
#     exit;
# fi
# extract features steps
# for extract basic feature


# remove the original nouseful data $REVREB
if [ -d ${REVERBWSJBASE} ]; then
    rm ${REVERBWSJBASE} -fr
fi

# extract the original feature
bash scripts/reverbwsjcam0_code_data_testing

DAE_OUT="/home/14/ren/exp/DAE/work/tmp/feature/dae/reverb/iphone/all/"

echo "FEATURE:${FEATURE}"
if [ "${FEATURE}" == "DAE" ] ; then
    echo "begin the  DAE process "
    cd ./DAE/
    echo $(pwd)
    mrun.sh converter dt.conf
    mrun.sh translate_mfcc dt.conf
    reverb_bk=${REVERBWSJBASE}#$(date +%Y%m%d-%H:%M)
    dir_list=reverb.dlist
    find ${REVERBWSJBASE} -type d |sort -u >${REVERBWSJBASE}/${dir_list}
    mv ${REVERBWSJBASE} ${reverb_bk}
    cat ${reverb_bk}/${dir_list} | xargs mkdir -p
    echo "begin to copy dae feature to target"
    cp -r ${DAE_OUT}/* ${REVERBWSJFEATURES}/
fi
