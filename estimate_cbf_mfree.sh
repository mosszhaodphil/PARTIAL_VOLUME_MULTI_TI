asldata="asldata_gm_k5"
cinstr="-div M0t_gm_k5 -mul 0.9"
tau=0.64
fa=35

# --- [Model Free] ---
echo "Begin model-free analysis"

# need to separate tissue and arterial signals
# first split up the differenced data into the separate phases (treating as TIs)
asl_file --data=$asldata --ntis=6 --ibf=tis --iaf=diff --split=asldata_ph
fslmaths asldata_ph002 -add asldata_ph005 -mul 0.5 asl_nocrush
fslmaths asldata_ph000 -add asldata_ph001 -add asldata_ph003 -add asldata_ph004 -mul 0.25 asl_tissue
fslmaths asl_nocrush -sub asl_tissue asl_blood

fabber --data=asl_blood --disp=gvf --output=aif -@ aifoptions.txt

# need aBV image (in absolute units) - to determine what voxels contain viable aif
fslmaths aif/mean_fblood $cinstr aBV
    
# need aif shapes (scale aifs by the aBV)
fslmaths aif/modelfit -div aif/mean_fblood aifs

#smooth data (a little) before model-free analysis
fslmaths asl_tissue -s 2.1 asl_tissue

# do deconvolution
asl_mfree --data=asl_tissue --mask=mask --out=modfree --aif=aifs --dt=0.3 --metric=aBV --mthresh=0.012 --tcorrect --t1=1.6 --fa=$fa

#copy results to output directory
#cd "$stdir"
fslmaths modfree_magntiude $cinstr -mul 6000 -div $tau -mas gm_mask perfusion_gm_mask
    # note that in the calibration we have to account for the scaling of the AIF by the bolus duration
    # this is still required (even though we have tau in the model-fitting for the AIF) becuase we normalise the AIF above before deconvolution
#imcp $tempdir/aBV $outdir/aCBV