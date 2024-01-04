# Custom Spack environments for CARC HPC clusters

This repo contains template YAML files for creating custom [Spack](https://spack.io/) software environments for use on CARC HPC clusters.

## Installation

### Install Spack

The template files have been developed and tested using Spack v0.21.0. They may need to be modified if using a different version of Spack.

First, download Spack into one of your directories:

```
git clone --branch v0.21.0 --depth 1 https://github.com/spack/spack
```

Then, set up Spack for your shell:

```
module purge
export SPACK_PYTHON=/spack/2206/apps/linux-centos7-x86_64_v3/gcc-11.3.0/python-3.11.3-gl2q3yz/bin/python
source ./spack/share/spack/setup-env.sh
```

### Create Spack environment

To create an environment based on a template file, using a Python stack as an example, first download the template file:

```
curl -LO https://raw.githubusercontent.com/uschpc/spack-envs/main/python/python.yaml
```

Then modify the template file as needed (change group, add more packages, modify preferred versions and variants, specify target CPU architecture, etc.)

Next create a named environment:

```
spack env create python python.yaml
```

### Activate Spack environment

Assuming the environment is successfully created, activate it:

```
spack env activate python
```

Add the `-p` option if you want the environment name added to the shell prompt:

```
spack env activate -p python
```

### Concretize and install environment

If desired, first concretize the environment to see exactly what will be installed:

```
spack concretize
```

If needed, adjust the environment specs with `spack config edit` and reconcretize with `spack concretize -f`. Then install:

```
spack install
```

If there are any failures, consult the error messages and try to debug and find solutions to the failures. Feel free to submit a support ticket.

## Usage

When a Spack environment is activated, all the installed software in the environment is loaded and becomes available for you to use. After a successful install of Python, for example, the environment now has a version of Python (check with `which python`). In the future, make sure to activate Spack and then the environment in order to use this version of Python:

```
module purge
export SPACK_PYTHON=/spack/2206/apps/linux-centos7-x86_64_v3/gcc-11.3.0/python-3.11.3-gl2q3yz/bin/python
source ./spack/share/spack/setup-env.sh
spack env activate python
python
```

To deactivate the environment:

```
spack env deactivate
```

## CPU microarchitectures on CARC HPC clusters

CARC HPC clusters have a heterogeneous mix of CPU models and therefore CPU microarchitectures. See the [Discovery Resource Overview](https://www.carc.usc.edu/user-information/user-guides/hpc-basics/discovery-resources) and [Endeavour Resource Overview](https://www.carc.usc.edu/user-information/user-guides/hpc-basics/endeavour-resources) for more details.

Spack can target specific CPU microarchitectures when building packages, which will improve performance when running applications on those specific CPU models compared to using a generic target. You can target a generic `x86_64` if you want to use your Spack environment on any compute node. A better approach is to target `x86_64_v3`, which includes AVX2 and will run on most compute nodes (those with AVX2 instructions). You can target the specific microarchitectures listed in the tables below, but your Spack environment may only run on those specific compute nodes. If it is worth it for your use case, you could also create multiple Spack environments where each one targets a specific microarchitecture, and then in Slurm jobs detect the microarchitecture you are running on and activate the corresponding environment (see [arch.sh](arch.sh)).

To detect CPU microarchitectures on compute nodes, use `spack arch -t`.

To specify a target for your environment, add it to the YAML file under:

```
packages:
    all:
      target: [x86_64_v3]
```

Replace `x86_64_v3` with your preferred target.


The following table lists microarchitectures and vector extensions on Discovery nodes:

| CPU model | Microarchitecture | Partitions | AVX | AVX2 | AVX-512 |
|---|---|---|---|---|---|
| xeon-2640v3 | haswell | main | &#10003; | &#10003; |  |
| xeon-2640v4 | broadwell | main, gpu, oneweek, debug | &#10003; | &#10003; |  |
| xeon-4116 | skylake_avx512 | main, oneweek, debug | &#10003; | &#10003; | &#10003; |
| xeon-6130 | skylake_avx512 | gpu | &#10003; | &#10003; | &#10003; |
| epyc-7542 | zen2 | epyc-64 | &#10003; | &#10003; |  |
| epyc-7513 | zen3 | epyc-64, gpu, largemem | &#10003; | &#10003; |  |
| epyc-7282 | zen2 | gpu | &#10003; | &#10003; |  |
| epyc-7313 | zen3 | gpu, debug | &#10003; | &#10003; |  |

The following table lists microarchitectures and vector extensions on Endeavour condo nodes:

| CPU model | Microarchitecture | AVX | AVX2 | AVX-512 |
|---|---|---|---|---|
| xeon-2640v3 | haswell | &#10003; | &#10003; |  |
| xeon-2640v4 | broadwell | &#10003; | &#10003; |  |
| xeon-6248r | cascadelake | &#10003; | &#10003; | &#10003; |
| xeon-4216 | cascadelake | &#10003; | &#10003; | &#10003; |
| epyc-7542 | zen2 | &#10003; | &#10003; |  |
| epyc-7513 | zen3 | &#10003; | &#10003; |  |
| epyc-7532 | zen2 | &#10003; | &#10003; |  |
| epyc-7282 | zen2 | &#10003; | &#10003; |  |
| epyc-9354 | zen4 | &#10003; | &#10003; | &#10003; |

Other legacy or purchased nodes may have different microarchitectures.

## Additional resources

- [Spack website](https://spack.io/)
- [Spack documentation](https://spack.readthedocs.io/en/latest/)
- [Spack tutorials](https://spack-tutorial.readthedocs.io/en/latest/)
- [Spack package search](https://packages.spack.io/)

## License

[0BSD](LICENSE)
