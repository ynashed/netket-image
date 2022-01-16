# netket-image
A repo to hold the build for a [netket](https://www.netket.org/) Docker image.

## Use on SDF
Currently a Singularity image is working on SDF with GPU support and netket v3.3.1. It can be located under `/sdf/group/ml/xpcs/singularity_images/netket-image-main_latest.sif`.

### Jupyter
To launch a Jupyter session on SDF, choose `Custom Singularity Image ...` under `Jupyter Instance`, then enter
```
export SINGULARITY_IMAGE_PATH=/sdf/group/ml/xpcs/singularity_images/netket-image-main_latest.sif
function jupyter() { singularity exec --nv -B /sdf,/gpfs,/scratch,/lscratch ${SINGULARITY_IMAGE_PATH} jupyter $@; }
```
in the `Commands to initate Jupyter` text areah (which should be editable with the custom image option selected). Pick a GPU and other parameters normally, and you should be good to go.
