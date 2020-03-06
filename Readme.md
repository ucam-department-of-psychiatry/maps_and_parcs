---
title: "Maps and parcellations"
output: html_document
---

# Maps and parcellations commonly used
This repo contains annotations in fsaverage for commonly used parcellations and mappings as well as code to transfer between maps.

**annot2classes2labels.m**: simple function to convert a freesurfer annotation files to a list of classes and labels for clarity    
**map2map**: takes two sets of annotations and outputs a mapping from one to another. Mapping is based on the mode of the class in the second set masked for each class in the first set. With partial overlap this obviously doesn't provide a perfect mapping, but the output also includes a goodness of fit (Gof) that is simply the percentage of vertices in which the mode of that class matches (e.g. 100% means all vertices from class 1 in annotation 1 match with a class in annotation 2).    
**map2map_centroid.m**: takes the coordinates of each parcels centroid on the fsaverage sphere and for the coordinates in input map 1 finds the closest coordinate in the second map (currently *map2map.m* seems to perform a lot better).
**centroid_extraction_sphere.m**: script written by Rafael Romero-Garcia to extract spherical coordinates from any given parcellation
**plotMap2Map.R**: simple R function to plot the alluvial diagram for a given map2map csv file

## Requirements
- MATLAB v17 or higher    
- Freesurfer installed and freesurfer matlab function added to path   
- For visualisation requires *ggplot2*, *ggalluvial* and *viridis* packages    

## to-do
[] add some form of spherical rotation permutation for each map    
[] explore alternative mapping options?    
[] add AIBS tools?    
[] add other useful tools?    
[] split per hemisphere?    
