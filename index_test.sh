#!/bin/bash

#require library
pip install typer

YELLOW='\033[1;33m'
GREEN='\033[1;32m'
RED='\033[1;31m'

#input dataset directory(PSH & CLS)
echo " "
echo -e "${GREEN}-> STEP 1 : Enter pan-sharping-datasets-directory-PSH"
echo " "

read psh_path
export PSH=$psh_path
echo " "
echo -e "${GREEN}-> STEP 2 : Enter spectral-classification-datasets-directory-CLS"
echo " "
read cls_path
export CLS=$cls_path

#Check whether PSH directory is empty or not

if [ "$(ls -A $PSH)" ]; then
    echo " "
    echo -e "${RED}*Error : PSH directory is not Empty"
    echo " "

else
    echo " "
    echo -e "${YELLOW}*To continue Enter CORRECT PSH PATH!"
    echo " "
    read psh_path
fi

# Define product and province
province_list=("EC" "FS" "GP" "KZN" "LP" "MP" "NC" "NW" "WC")
echo -e "${GREEN}-> STEP 3 : Choose a South African Province to index :
========== SA Provinces ===========
- EC
- FS
- GP
- KZN
- LP 
- MP
- NC
- NW
- WC
===================================
${YELLOW} -> Enter Province Abbreviation:"
echo " "

read value
#SA province list
province_list=("EC" "FS" "GP" "KZN" "LP" "MP" "NC" "NW" "WC")

if [[ " ${province_list[*]} " =~ " ${value^^} " ]]; then
    PROVINCE=${value^^}
    echo -e "${GREEN}-> STEP 4 : Choose Dataset :
     1. Spot6
     2. Spot7
    ${YELLOW} -> Insert number and press ENTER"
    echo " "
    read number

    if [ $number == 1 ]; then
        echo " "
        echo -e "${YELLOW}you are about to create ${PROVINCE}_S6.yml dataset document, ${RED}Continue(Y or N)"
        echo " "
        read confirmation
        confirm=${confirmation^^}

        if [ $confirm == "Y" ]; then

            python sansa_desa_datacube_indexing/main.py --verbose --dataset-pattern='S6-*_PSH.pix' --output-path=$(pwd)/${PROVINCE}_S6.yml --datasets-directory-spectral-classification=$CLS spot6_snbar_card4l_harmonized $PSH
            dataset_document=${PROVINCE}_S6.yml
        fi
        if [ $confirm == "N" ]; then
            exit "Bye"
        fi

    elif
        [ $number == 2 ]
    then
        echo " "
        echo -e "${GREEN}you are about to create ${PROVINCE}_S7.yml dataset document, ${RED}Continue(Y or N)"
        echo " "
        read confirmation
        confirm=${confirmation^^}

        if [ $confirm == "Y" ]; then

            python sansa_desa_datacube_indexing/main.py --verbose --dataset-pattern='S7-*_PSH.pix' --output-path=$(pwd)/${PROVINCE}_S7.yml --datasets-directory-spectral-classification=$CLS spot7_snbar_card4l_harmonized $PSH
            dataset_document=${PROVINCE}_S7.yml
        fi
        if [ $confirm == "N" ]; then
            exit "Bye"
        fi

    else
        echo " "
        echo -e "${RED}*ERROR : Enter a valid value"
        echo " "
    fi

fi

if [[ ! " ${province_list[*]} " =~ " ${value^^} " ]]; then
    echo -e "${RED}ERROR : Please enter a valid province abbreviation"
    echo " "
fi

ls -l

#Check yml file

if [ -f "$dataset_document" ]; then

    echo -e "${YELLOW}$dataset_document exists."
    echo " "
    DATASET_DOCUMENT=$(pwd)/$dataset_document
    echo $DATASET_DOCUMENT
    echo " "
    #datacube --env sandbox-eo3 dataset add $DATASET_DOCUMENT
else

    echo -e "${YELLOW}$dataset_document does not exist."
fi
