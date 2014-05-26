#!/bin/bash
task_list=${1:-"task.list"}
#set -x
while IFS= read -r line
do
    echo "============  run task ${line}  ============"
    cat LOCAL_CONFIG.base | sed 's#\(export DT_TASK=\).*#\1'"${line}"'#g' > LOCAL_CONFIG
    bash ./WSJBuildAndTest
done < "$task_list"
#set +x
