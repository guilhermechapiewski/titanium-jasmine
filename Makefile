PROJECT_NAME=SampleApp
PROJECT_ROOT=$(shell pwd)
DEVICE_TYPE=ipad

run:
	@mkdir -p ${PROJECT_ROOT}/${PROJECT_NAME}/Resources/test/
	@echo "" > ${PROJECT_ROOT}/${PROJECT_NAME}/Resources/test/enabled.js
	@make launch-titanium

test:
	@mkdir -p ${PROJECT_ROOT}/${PROJECT_NAME}/Resources/test/
	@echo "sampleapp.tests_enabled = true;" > ${PROJECT_ROOT}/${PROJECT_NAME}/Resources/test/enabled.js
	@make launch-titanium

clean:
	@rm -rf ${PROJECT_ROOT}/${PROJECT_NAME}/build/iphone/*
	@mkdir -p ${PROJECT_ROOT}/${PROJECT_NAME}/build/iphone/
	@echo "Deleted: ${PROJECT_ROOT}/${PROJECT_NAME}/build/iphone/*"

launch-titanium:
	@echo "Building with Titanium..."
	@mkdir -p ${PROJECT_ROOT}/${PROJECT_NAME}/build/iphone/
	@PROJECT_NAME=${PROJECT_NAME} PROJECT_ROOT=${PROJECT_ROOT} DEVICE_TYPE=${DEVICE_TYPE} bash ${PROJECT_ROOT}/bin/titanium.sh