#!/bin/bash

# Source the general setup script from DUNE's Open Science Grid
source /cvmfs/dune.opensciencegrid.org/products/dune/setup_dune.sh

# Find the localProducts directory with a wildcard for version
localProductsDir=$(find . -maxdepth 1 -type d -name 'localProducts_larsoft_v*' | sort | head -n 1)

# Check if the directory was found
if [[ -d "$localProductsDir" ]]; then
    # Source the setup script inside the found directory
    source "${localProductsDir}/setup"
else
    echo "Error: localProducts directory not found."
    exit 1
fi

# Move to the build directory
cd build_slf7.x86_64/ || exit

# Set the environment for mrb (multi-repository build tool)
mrbsetenv

# Setup DUNE plot style - sets up environment for DUNE's specific plotting style guidelines
setup dune_plot_style v01_00

# Setup FNAL (Fermilab) security - necessary for accessing Fermilab's computing resources securely
setup_fnal_security

# Setup the SAM Web Client - SAM (Sequential Access via Metadata) is a data management system
# used for organizing and accessing experiment data; this sets up the client for interacting with SAM
setup sam_web_client

# Set the SAM experiment environment variable to DUNE
export SAM_EXPERIMENT=dune

# Setup FIFE utilities - FIFE (Fabric for Frontier Experiments) is a project at Fermilab
# offering services and tools for high-throughput computing; this command sets up those tools
setup fife_utils -t

