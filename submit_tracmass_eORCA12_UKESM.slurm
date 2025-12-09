#!/bin/bash

#SBATCH --job-name="runtracmass_test_eORCA12"
#SBATCH --time=05:00:00
#SBATCH --mem=12G
#SBATCH --account=noc_msm
#SBATCH --partition=standard
#SBATCH --qos=standard

# ------------------------------------------------
# Run Tracmass v7.1 eORCA12 UKESM Experiment.
# Created on: 11/03/2025
# Created by: Ollie Tooth (oliver.tooth@noc.ac.uk)
# ------------------------------------------------

# -- Loading Modules -- #
module load jaspy

# -- Running Tracmass v7.1 -- #
rm Makefile
ln -s Makefile_eORCA12 Makefile

# Compile Tracmass v7.1.
make clean
make

# Run Tracmass v7.1 - eORCA12 UKESM simulation.
# Run TRACMASS:
srun --unbuffered ./runtracmass &> ./logs/runtracmass_log.out