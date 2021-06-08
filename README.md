**Required**:

  - python3
  - numpy
  - gnuplot


**Datasets**:

Datasets are located at SIGCOMM21/datasets/
  - IXPs/: IXP locations across the globe
  - dns/: DNS root server locations
  - intertubes/: US land cables dataset
  - submarine-map/: Global submarine cable dataset from www.submarine.com
  - world-map/: world map outline for plotting PDF distribution with a map backgorund

All datasets except CAIDA and ITU datasets used in the paper have been added to the repository. CAIDA dataset can be obtained from http://data.caida.org/datasets/topology/ark/ipv4/itdk/2019-04/. ITU land cables dataset is private.

**Generating Plots**

All scripts required for generating the plots are in the "scripts" folder. For example, generate Fig 3:

cd scripts/

bash fig-3-getLandingPtDistr.sh

The output plots are stored in the "outputs" folder and the intermediate data in the "processedData" folder.
