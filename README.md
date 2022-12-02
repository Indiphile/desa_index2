# Indexing Process (Step by Step) - In BETA

 1. login/Register : https://geoworkroom-desa.sansa.org.za

 2. On `jupyterLab` start a new terminal session

 3. `git clone` https://github.com/SANSA-DESA/sansa-desa-datacube-indexing ( ***new users***)

 4. `pip install typer` (***If not installed***)

 5. `export PSH=/pan-sharping-directory` and `export CLS=/spectral-classification-directory`(***Optional***)

 6. Run `main.py` module to index SPOT 6 (`S6`) or SPOT 7 (`S7`):
    `python sansa_desa_datacube_indexing/main.py --verbose --dataset-pattern='S6-*_PSH.pix' --output-path=$(pwd)/SA-PROVINCE-NAME_S6.yml --datasets-directory-spectral-classification=$CLS PRODUCT-NAME $PSH`
    -Output = dataset-document `p   PROVINCE_PRODUCT.yml`

 7. Define a varibale to store dataset-document path `DATASET_DOCUMENT=$(pwd)SA-PROVINCE-NAME_S6.yml`

 8. Run the ODC command for adding dataset `datacube --env ODC-ENVIRONMENT dataset add $DATASET_DOCUMENT`

 
 # COMMON ERRORS

