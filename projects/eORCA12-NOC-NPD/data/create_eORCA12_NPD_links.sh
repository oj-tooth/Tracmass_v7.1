#!/usr/bin/bash

# -----------------------------------------------
# create_eORCA12_NPD_links.sh
#
# Description: This script creates symbolic
# links for 5-day mean .nc output files
# from the eORCA12 NPD ERA-5 v1 simulation.
#
# Created By: Ollie Tooth (oliver.tooth@noc.ac.uk)
# -------------------------------------------------
# Definitions:
SRC_NAME=/gws/nopw/j04/atlantis/atb299/NPD/eORCA12
CONFIG=eORCA12_5d

# Iterate over years:
for yr in {2021..2024}
do
    # Iterate over months each year:
    for mt in {01..12}
    do
        # Get date-string {YYYYMMDD-YYYYMMDD} from filename:
        datestr_list=''
        for fpath in `ls ${SRC_NAME}/${yr}/${CONFIG}_grid_T_${yr}${mt}*.nc`
        do
            # Get filename from path:
            fname=$(echo ${fpath##*/})
            dtstr=$(echo ${fname:18:19})
            # Remove .n from date-string:
            dtstr=${dtstr%.*}
            datestr_list="$datestr_list $dtstr"

        done

        # Iterate over date-strings:
        for datestr in $datestr_list
        do
            # Iterate over output grid types:
            for grid in grid_T grid_U grid_V grid_W
            do
                # Iterate over all output .nc files:
                for filename in `ls ${SRC_NAME}/${yr}/${CONFIG}_${grid}_${datestr}.nc`
                do
                # Create symbolic link to output file using starting date of date-string:
                ln -s ${filename} ${CONFIG}_${datestr:0:8}_${grid}.nc

                done
            done
        done
    done
done