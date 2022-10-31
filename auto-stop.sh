#!/bin/bash

# Auto stop monitor job on nodes running SLURM jobs

NODES_mix=$(sinfo | grep All | grep -i mix | awk '{print $NF}')
NODES_alloc=$( sinfo | grep All | grep -i alloc | awk '{print $NF}')
NODES_avail=$( sinfo | grep All |grep idle | awk '{print $NF}')

# Stopping monitor on mix and allocated nodes

if test "${NODES_mix}" != "$(cat /dev/null)" 
	then 
		bash /root/stop_m.sh ${NODES_mix} 
	fi

if test "${NODES_alloc}" != "$(cat /dev/null)"
        then
                bash /root/stop_m.sh ${NODES_alloc}
        fi

# Starting monitor on idle nodes

bash /root/start_m.sh $NODES_avail
