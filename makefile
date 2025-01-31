
#>>>> https://stackoverflow.com/questions/53382383/makefile-cant-use-conda-activate
# Need to specify bash in order for conda activate to work.
SHELL=/bin/bash
# Note that the extra activate is needed to ensure that the activate floats env to the front of PATH
CONDA_ACTIVATE=source $$(conda info --base)/etc/profile.d/conda.sh ; conda activate ; conda activate 
# <<<<

#install:
#	conda install -c conda-forge mne==0.23 -n enigma_meg_prep
#	pip install wget
#	pip install git+https://github.com/nih-megcore/nih_to_mne

	
install_test:
	conda install --channel=conda-forge --name=base mamba -y
	mamba create --override-channels --channel=conda-forge --name=enigma_meg_test mne pip -y
	($(CONDA_ACTIVATE) enigma_meg_test ; pip install -e .; pip install pytest pytest-reportlog )
	git submodule init
	git pull --recurse-submodules

install_system_requirements:
	dnf install Xvfb -y
	dnf install git git-annex -y

test:
	($(CONDA_ACTIVATE) enigma_meg_test ; cd enigma_anonymization_lite; pytest -vv --report-log=./test_logfile.txt )  #xvfb-run -a pytest -s )
