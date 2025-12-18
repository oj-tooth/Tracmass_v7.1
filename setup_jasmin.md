# **JASMIN:** TRACMASS v7.1 Setup

TRACMASS version 7.1 is a forked GitHub repository of the original TRACMASS version 7 GitHub repository. 

In addition to the updates made to TRACMASS version 7.1, NEMO-MEDUSA experiments require several further modifications to the Fortran code. These include:

- An updated Makefile to compile TRACMASS version 7.1 on Archer2.
- A new eORCA12 project directory containing the eORCA12_UKESM exeriment namelists & updated read_field.F90 and kill_zones.F90 files.

The additions above are available on the dev_JASMIN branch, which has been added to the TRACMASS_v7.1 repository.

## Running TRACMASS on JASMIN
To run a Lagrangian experiment using TRACMASS on JASMIN, we must first load the GNU & netCDF libraries needed to compile the code using either jaspy or conda:

#### **Using Conda:**

The simplest way to get started with **TRACMASS** on any HPC system is to use a conda virtual environment. Note that this virtual environment can also include the Python libraries used for analysis.

To do this:

* Create a new virtual environment using [**miniforge**](https://github.com/conda-forge/miniforge) - a minimal installer for **Conda** and **Mamba**:
    ```bash
    conda create -n env_tracmass
    ```

> **To learn more about miniforge on JASMIN: https://help.jasmin.ac.uk/docs/software-on-jasmin/creating-and-using-miniforge-environments/#activating-the-base-environment**

* Next, install the **gfortran** and **netcdf-fortran** libraries required by **TRACMASS** from the conda-forge open-source package manager.
    ```bash
    conda activate env_tracmass

    conda install gfortran netcdf-fortran
    ```

* Verify **gfortran** and **netCDF** libraries are available.
    ```bash
    which gfortran

    nf-config --all
    ```

* Update the *Makefile* `ARCH` and `NETCDFLIBS` options.
    ```bash
    # Project and case definition
    ...
    ARCH              = conda
    NETCDFLIBS        = conda
    #=============================
    ```

#### **Using Jaspy:**

```sh
# -- Load GNU & netCDF libraries -- #
module load jaspy
```

Next, modify the ```Makefile_eORCA12``` in the TRACMASS_v7.1 directory to use the ```PROJECT``` and ```CASE``` variables which match your Lagrangian experiment (together these determine the filepath to the namelist input file).

Once you've saved your changes to the namelist file, create a symbolic link to your project-specific ``Makefile_eORCA12`` file using: 

```sh
# -- Create link to Makefile -- #
ln -s Makefile_eORCA12 Makefile
```

This allows you to create multiple Makefiles rather than overwriting the expected `Makefile` input to TRACMASS repeatedly.

Next, compile TRACMASS using the ```make``` command.

**Note:** It is recommended to ```make clean``` and recompile TRACMASS each time you modify the namelist for your experiment.

Assuming the compilation is successful, we can finally run our experiment using ```./runtracmass```.

### **Submitting TRACMASS Jobs using LOTUS2**

An example slurm job script `submit_tracmass_eORCA12_UKESM.slurm`, which submits a test TRACMASS experiment to the LOTUS2 standard / serial queue, is provided in this directory and below:

```sh
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
```

**Note:** You may need to modify the account in the sbatch directives `#SBATCH --account=noc_msm` alongside the time and memory requirements for the job.

The `srun --unbuffered ./runtracmass &> ./logs/runtracmass_log.out` command writes the TRACMASS logging output to a file as the experiment progresses, so be sure to look here in case of any errors!