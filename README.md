# Llangorse sea-ice code
 CDO and R code used to produce seasonal and mean annual sea-ice plots from the Trace-21ka data. These analyses were produced as part of the publication by Matthews et al. (2025),_Summer warmth between 15.5 and 15 ka BP enabled human repopulation of the Northwest European Margin_. _Nature Ecology and Evolution_. NATECOLEVOL-23020330C. 

**Methodology**
Simulations of sea-ice extent were obtained from the global, coupled ocean-atmosphere-sea ice- land surface climate model simulation TraCE-21ka (Liu et al., 2009; He, 2011; https://www.cgd.ucar.edu/ccr/TraCE/). TraCE-21ka uses the Community Climate System Model version 3 (CCSM3; Collins et al., 2006), with climate boundary conditions forced by orbitally driven insolation, meltwater fluxes, greenhouse gas concentrations and ice sheet extent and topography. The sea ice model employed in TraCE 21ka is the dynamic-thermodynamic National Center for Atmospheric Research (NCAR) Community Sea Ice Model (CSIM) with a longitudinal resolution of 3.6o and a variable latitudinal resolution, with finer resolution near the equator (~0.9o). The TraCE-21ka simulations have been shown to replicate the main features in global hydroclimatic reconstructions over the last 21 ka (e.g. Liu et al., 2009; He et al., 2013; Zhu et al., 2014; Yan and Liu, 2019), including the major shifts in Greenlandic temperatures over the last deglaciation (Buizert et al., 2018). 
100 year means of seasonal and mean annual sea ice extent (n=10 timesteps) were calculated from the full TraCE simulation (with transient forcing changes in greenhouse gases, orbitally-driven insolation variation, ice sheets and meltwater fluxes) using the climate data operators (CDO) command line suite (e.g. the 17.05 to 16.95 ka timesteps were used for 17ka average).


The 'CDO code to subset timesteps' file provides the code used to produce mean timesteps from the raw Trace21 ka sea ice file.

The 'Sea ice plotting code.R' is the code used to produce mean annual and seasonal plots of sea ice extent in the North Atlantic through the Last Termination.

The 'Data files' folder contains the subsetted seasonal and mean annual .nc sea ice and .shp ice extent polygons used in the .R code.
