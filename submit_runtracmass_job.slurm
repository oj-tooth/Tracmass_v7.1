#!/bin/bash

#SBATCH --job-name runtracmass_demo
#SBATCH --time=00:45:00
#SBATCH --partition=serial
#SBATCH --qos=serial
#SBATCH --account=n01-CLASS
#SBATCH --mem=6G
#SBATCH --ntasks=1
#SBATCH --output runtracmass.%j.out
#SBATCH --error runtracmass.%j.err

# -------------------------------------------
# Archer2 Job Script for Data Analysis Queue
# -------------------------------------------
# Set the number of threads to 1.
# This prevents any threaded system libraries from automatically
# using threading.
export OMP_NUM_THREADS=1

# Load module dependencies:
module load PrgEnv-gnu
module load cray-hdf5-parallel/1.12.2.1
module load cray-netcdf-hdf5parallel/4.9.0.1

# Remove existing Makefile sym link:
rm Makefile
# Create Makefile sym link:
ln -s Makefile_eORCA12 Makefile

# Compile TRACMASS:
make clean
make

# Run TRACMASS:
srun --unbuffered ./runtracmass &> runtracmass_demo.out
