#!/usr/bin/env bash

source ~/.bashrc

echo "Installing sdkman..."

# Check for SDKMAN and install if not present
if [ ! $SDKMAN_VERSION ]; then
    curl -s "https://get.sdkman.io" | bash
fi


echo "Setting up sdkman..."

####################################
## Not working!
####################################

# Java
sdk install java 8.0.302-open
yes | sdk install java 11.0.17-tem

# Other tools
#yes | sdk install grails 1.3.7
#yes | sdk install grails 2.2.4
#yes | sdk install grails 2.5.0
#yes | sdk install grails 3.3.11
sdk install grails #set as default
sdk install groovy
sdk install gradle
sdk install micronaut


# Switch extension: https://github.com/sdkman/sdkman-extensions
echo "Installing sdkman switch extension..."
git clone git@github.com:sdkman/sdkman-extensions.git
cd sdkman-extensions
gradle install
cd ..
rm -rf sdkman-extensions
