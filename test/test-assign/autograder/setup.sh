#!/usr/bin/env bash

if [ "${BASE_IMAGE}" != "ucbdsinfra/otter-grader" ]; then
    apt-get clean
    apt-get update
    apt-get install -y pandoc texlive-xetex texlive-fonts-recommended texlive-generic-recommended build-essential libcurl4-gnutls-dev libxml2-dev libssl-dev libgit2-dev texlive-lang-chinese

    # install wkhtmltopdf
    wget --quiet -O /tmp/wkhtmltopdf.deb https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6-1/wkhtmltox_0.12.6-1.bionic_amd64.deb
    apt-get install -y /tmp/wkhtmltopdf.deb

    # install conda
    wget -nv -O /autograder/source/miniconda_install.sh "https://repo.anaconda.com/miniconda/Miniconda3-py38_4.10.3-Linux-x86_64.sh"
    chmod +x /autograder/source/miniconda_install.sh
    /autograder/source/miniconda_install.sh -b
    echo "export PATH=/root/miniconda3/bin:\$PATH" >> /root/.bashrc

    export PATH=/root/miniconda3/bin:$PATH
    export TAR="/bin/tar"
fi

# install dependencies with conda
conda env create -f /autograder/source/environment.yml

# set conda shell
conda init --all

conda run -n otter-env pip install /home/otter-grader
conda run -n otter-env pip install /home/otter-grader
conda run -n otter-env pip install /home/otter-grader