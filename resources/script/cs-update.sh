#!/bin/bash
#
# PKC Automatic re-pull docker images for pkc-semanticwiki
#
################################################################################
docker-compose down
docker rmi $(docker images 'emhavis/pkc_semanticwiki' -a -q)
docker-compose up -d