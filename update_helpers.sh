#!/bin/bash

UPDATE_SCRIPTS="php composer.phar selfupdate && php n98-magerun2.phar selfupdate && php n98-magerun.phar selfupdate && php robo.phar self:update && php deployer.phar self-update"

# General purpose images
for D in apache-php*; do
	if [ -d "${D}" ]; then
		cd ${D}/scripts
		bash -c "$UPDATE_SCRIPTS"
		cd ../..
	fi
done

# This one is a special case
cd apache-sylius/scripts/
php composer.phar selfupdate && robo.phar self:update && php deployer.phar self-update
cd ../..
