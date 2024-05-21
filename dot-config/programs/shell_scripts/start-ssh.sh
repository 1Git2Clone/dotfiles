#!/bin/bash

cd ./

eval $(ssh-agent)
ssh-add ~/.ssh/id_rsa
ssh-add -l
