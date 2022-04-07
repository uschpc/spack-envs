# Custom Spack environments for CARC systems

This repo contains template YAML files for creating custom Spack software environments for use on CARC systems.

## Installation

### Install Spack

First, download the latest (development) version of Spack into one of your directories:

```
git clone --single-branch --depth 1 https://github.com/spack/spack
```

Then set up Spack for your shell:

```
source ./spack/share/spack/setup-env.sh
```

### Create Spack environment

To create an environment based on a template file, using a Python stack as an example, first download the template file:

```
wget https://raw.githubusercontent.com/uschpc/spack-envs/main/python/python.yaml
```

Then modify the template file as needed (change group, add more packages, modify preferred versions and variants, specify target CPU architecture, etc.)

Next create a named environment:

```
spack env create python python.yaml
```

### Activate Spack environment

Assuming the environment is successfully created, activate it:

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

After a successful install, the environment now has a version of Python:

```
which python
```

In the future, make sure to activate Spack and then the environment in order to use this Python:

```
source ./spack/share/spack/setup-env.sh
spack env activate -p python
python
```

To deactivate the environment:

```
spack env deactivate
```

## License

[0BSD](LICENSE)
