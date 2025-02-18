# **Archer2:** TRACMASS v7.1 Setup

TRACMASS version 7.1 is a forked GitHub repository of the original TRACMASS version 7 GitHub repository. 

In addition to the updates made to TRACMASS version 7.1, the mCDR experiments require several further modifications to the Fortran code. These include:

- An updated Makefile to compile TRACMASS version 7.1 on Archer2.
- A new eORCA12 project directory containing the mCDR exeriment namelists & updated read_field.F90 and kill_zones.F90 files.
- Modifications to mod_seed.F90 to allow grid cell volume (m3) to be assigned to trajectories upon their release.
- Modification to read_field.F90 to include the 2-dimensional Exclusive Economic Zone ID tracer, which is read along water parcel trajectories.

The additions above are available on the dev_mCDR branch, which has been added to the TRACMASS_v7.1 repository.

## Running TRACMASS on Archer2
To run a Lagrangian experiment using TRACMASS on Archer2, we must first load the GNU & netCDF libraries needed to compile the code:

```sh
# -- Load GNU & netCDF libraries -- #
module load PrgEnv-gnu

module load cray-hdf5-parallel/1.12.2.1
module load cray-netcdf-hdf5parallel/4.9.0.1
```

Next, modify the ```Makefile``` in the TRACMASS_v7.1 directory to use the ```PROJECT``` and ```CASE``` variables which match your Lagrangian experiment (together these determine the filepath to the namelist input file).

Once you've saved your changes to the namelist file, compile TRACMASS using the ```make``` command.

Assuming the compilation is successful, we can finally run our experiment using ```./runtracmass```.

**Note:** It is recommended to ```make clean``` and recompile TRACMASS each time you modify the namelist for your experiment.