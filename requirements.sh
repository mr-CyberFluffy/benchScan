#!/bin/bash

banner()
{
  echo "+---------------------------------------------------+"
  printf " %-40s \n" "`date`"
  echo "                                   "
  printf "`tput bold` %-40s `tput sgr0`\n" "$@"
  echo "+---------------------------------------------------+"
}

banner "AWS Audit- installing requirements..."
sleep 2
echo "=================================================================="
echo -e "\e[1;34m Starting awscli installation...\e[0m"
	sudo apt install awscli
echo -e "\e[1;33m Done Installation! \e[0m"
echo "=================================================================="

