#!/bin/sh

fabber --data=asldata_gm_k5 --data-order=singlefile --output=full -@ options.txt

fslmaths full/mean_ftiss.nii.gz -div M0t_gm_k5 -mul 0.9 -mul 6000 perfusion_gm_k5_scaled

fslmaths perfusion_gm_k5_scaled -mas gm_mask perfusion_gm_mask