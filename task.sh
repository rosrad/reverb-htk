#!/bin/bash

# modify the export parameter of the LOCAL CONFIG file
modify_para(){
    if [ $# -ne 2 ]; then
        exit 0;
    fi
    sed -i 's#\(export '"$1"'=\).*#\1'"$2"'#g' LOCAL_CONFIG
}

run_task () {
    task_list=${1:-"task.list"}
    #set -x
    while IFS= read -r line
    do
        echo "============  run task ${line}  ============"
        cp LOCAL_CONFIG.base LOCAL_CONFIG
        dt_task=$(echo ${line}|cut -d';' -f1)
        subtask=$(echo ${line}|cut -d';' -f2)
        modify_para "DT_TASK" ${dt_task}
        modify_para "SUBTASKS" ${subtask}
        bash ./WSJBuildAndTest
    done < "$task_list"
    #set +x
}

run_task $@

