export PROJECT_NAME=SampleApp
export PROJECT_ROOT=$(shell pwd)
export TMP_DIR=$(PROJECT_ROOT)/tmp/
export SVN_DIR=$(TMP_DIR)/$(PROJECT_NAME)_trunk/

run:
	@mkdir -p ${PROJECT_ROOT}/${PROJECT_NAME}/Resources/test/
	@echo "" > ${PROJECT_ROOT}/${PROJECT_NAME}/Resources/test/enabled.js
	@make launch-titanium

test:
	@mkdir -p ${PROJECT_ROOT}/${PROJECT_NAME}/Resources/test/
	@echo "sampleapp.tests_enabled = true;" > ${PROJECT_ROOT}/${PROJECT_NAME}/Resources/test/enabled.js
	@make launch-titanium

clean: clean-languages
	@rm -rf ${PROJECT_ROOT}/${PROJECT_NAME}/build/iphone/*
	@mkdir -p ${PROJECT_ROOT}/${PROJECT_NAME}/build/iphone/
	@echo "Deleted: ${PROJECT_ROOT}/${PROJECT_NAME}/build/iphone/*"

launch-titanium:
	@echo "Building with Titanium..."
	@mkdir -p ${PROJECT_ROOT}/${PROJECT_NAME}/build/iphone/
	@PROJECT_ROOT=${PROJECT_ROOT} bash ${PROJECT_ROOT}/bin/titanium.sh