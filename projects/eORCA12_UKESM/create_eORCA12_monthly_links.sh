#!/usr/bin/bash

# -----------------------------------------------
# create_eORCA12_monthly_links.sh
#
# Description: This script creates symbolic
# links for monthly mean .nc output files
# from the eORCA12 CLASS simulation.
#
# Created By: Ollie Tooth (oliver.tooth@noc.ac.uk)
# -------------------------------------------------
# Definitions:
SRC_NAME=/gws/nopw/j04/class_vol1/CLASS-MEDUSA/OUT_eORCA12/C001/monthly
CONFIG=eORCA12_MED_UKESM

# Move to fields output directory:
cd /home/users/o_tooth/NOC/proj_future_amoc/data/fields/monthly/

# Iterate over years:
for yr in {1981..2100}
do
    # Iterate over months in each year:
    for mt in {01..12}
    do
        # Iterate over NEMO grid types:
        for grid in grid_T grid_U grid_V
        do
        # Define filename:
        filename=${SRC_NAME}/${yr}/${CONFIG}_y${yr}m${mt}_${grid}.nc

        # Create symbolic link to output file using YYYYMM date format:
        ln -s ${filename} eORCA12_UKESM_${yr}${mt}_${grid}.nc

        done
    done
done