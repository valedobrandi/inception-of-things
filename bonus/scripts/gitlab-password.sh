#! /usr/bin/env bash

kubectl exec -n gitlab -it gitlab -- cat /etc/gitlab/initial_root_password

