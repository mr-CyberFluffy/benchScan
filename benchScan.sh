#!/bin/bash

banner()
{
  echo "+---------------------------------------------------+"
  printf " %-40s \n" "`date`"
  echo "                                   "
  printf "`tput bold` %-40s `tput sgr0`\n" "$@"
  echo "+---------------------------------------------------+"
}

banner "AWS Audit- IAM (CIS Benchmark)"
sleep 2
echo "=================================================================="
echo -e "\e[1;34m Starting aws configuration...\e[0m"
	aws configure
echo -e "\e[1;33m Configuration Done! \e[0m"
echo "=================================================================="
echo ""
echo "+---------------------------------------------------+"
	echo -e "\e[1;34m Identity and Access Management Audit...\e[0m"
echo "+---------------------------------------------------+"
echo ""
echo "=================================================================="

#Audit #1.4
echo -e "\e[1;34m CIS BENCHMARK #1.4 : To Ensure no 'root' user account access key exists..\e[0m"
	aws iam get-account-summary | grep "AccountAccessKeysPresent"  
	sleep 2
echo -e "\e[1;33m CIS BENCHMARK #1.4 Audit Done! \e[0m"
echo "=================================================================="

#Audit #1.5
echo -e "\e[1;34m CIS BENCHMARK #1.5 : To Ensure MFA is enabled for the 'root' user account..\e[0m"
	aws iam get-account-summary | grep "AccountAccessKeysPresent"  
	sleep 2
echo -e "\e[1;33m CIS BENCHMARK #1.5 Audit Done! \e[0m"
echo "=================================================================="

#Audit #1.6
echo -e "\e[1;34m CIS BENCHMARK #1.6 : To Ensure hardware MFA is enabled for the 'root' user account..\e[0m"
	aws iam get-account-summary | grep "AccountMFAEnabled"  
	sleep 2
echo -e "\e[1;33m CIS BENCHMARK #1.6 Audit Done! \e[0m"
echo "=================================================================="

#Audit #1.8
echo -e "\e[1;34m CIS BENCHMARK #1.8 : To Ensure IAM password policy requires minimum length of 14 or greater..\e[0m"
	aws iam get-account-password-policy
	sleep 2
echo -e "\e[1;33m CIS BENCHMARK #1.8 Audit Done! \e[0m"
echo "=================================================================="

#Audit #1.9
echo -e "\e[1;34m CIS BENCHMARK #1.9 : To Ensure IAM password policy prevents password reuse..\e[0m"
	aws iam get-account-password-policy
	sleep 2
echo -e "\e[1;33m CIS BENCHMARK #1.9 Audit Done! \e[0m"
echo "=================================================================="

#Audit #1.10
echo -e "\e[1;34m CIS BENCHMARK #1.10 : To Ensure multi-factor authentication (MFA) is enabled for all IAM users that have a console password..\e[0m"
	aws iam generate-credential-report
	sleep 2
	aws iam get-credential-report --query 'Content' --output text | base64 -d | cut -d, -f1,4,8
	sleep 2
echo -e "\e[1;33m CIS BENCHMARK #1.10 Audit Done! \e[0m"
echo "=================================================================="

#Audit #1.11
echo -e "\e[1;34m CIS BENCHMARK #1.11 : To Do not setup access keys during initial user setup for all IAM users that have a console password..\e[0m"
	aws iam generate-credential-report
	sleep 2
	aws iam get-credential-report --query 'Content' --output text | base64 -d | cut -d, -f1,4,9,11,14,16
	sleep 2
echo -e "\e[1;33m CIS BENCHMARK #1.11 Audit Done! \e[0m"
echo "=================================================================="

#Audit #1.12
echo -e "\e[1;34m CIS BENCHMARK #1.12 : To Ensure credentials unused for 45 days or greater are disabled..\e[0m"
	aws iam generate-credential-report
	sleep 2
	aws iam get-credential-report --query 'Content' --output text | base64 -d | cut -d, -f1,4,5,6,9,10,11,14,15,16
	sleep 2
echo -e "\e[1;33m CIS BENCHMARK #1.12 Audit Done! \e[0m"
echo "=================================================================="

#Audit #1.13
echo -e "\e[1;34m CIS BENCHMARK #1.13 : To Ensure there is only one active access key available for any single IAM user..\e[0m"
	aws iam list-users --query "Users[*].UserName"
	sleep 2
echo ""
echo -e "\e[1;37m Use folowing command to verify \e[0m"
echo -e "\e[1;37m Command1:aws iam list-access-keys --user-name <user-name> \e[0m"
echo -e "\e[1;33m CIS BENCHMARK #1.13 Audit Done! \e[0m"
echo "=================================================================="

#Audit #1.14
echo -e "\e[1;34m CIS BENCHMARK #1.14 : To Ensure access keys are rotated every 90 days or less..\e[0m"
	aws iam generate-credential-report
	sleep 2
	aws iam get-credential-report --query 'Content' --output text | base64 -d
	sleep 2
echo -e "\e[1;33m CIS BENCHMARK #1.14 Audit Done! \e[0m"
echo "=================================================================="

#Audit #1.15
echo -e "\e[1;34m CIS BENCHMARK #1.15 : To Ensure IAM Users Receive Permissions Only Through Groups..\e[0m"
	aws iam list-users --query 'Users[*].UserName' --output text
	sleep 2
echo ""
echo -e "\e[1;37m For each user returned, run the following command to determine if any policies are attached to them: \e[0m"	
echo -e "\e[1;37m Command1:aws iam list-attached-user-policies --user-name <iam_user>\e[0m"
echo -e "\e[1;37m Command2:aws iam list-user-policies --user-name <iam_user>\e[0m"
	sleep 1
echo ""
echo -e "\e[1;33m CIS BENCHMARK #1.15 Audit Done! \e[0m"
echo "=================================================================="

#Audit #1.16
echo -e "\e[1;34m CIS BENCHMARK #1.16 : To Ensure IAM policies that allow full *:* administrative privileges are not attached\e[0m"
	aws iam list-policies --only-attached --output text
	sleep 2
echo -e "\e[1;37m For each policy returned, run the following command to determine if any policies is allowing full administrative privileges on the account: \e[0m"	
echo -e "\e[1;37m Command1:aws iam get-policy-version --policy-arn <policy_arn> --version-id <version> \e[0m"
	sleep 2
echo -e "\e[1;33m CIS BENCHMARK #1.16 Audit Done! \e[0m"
echo "=================================================================="

#Audit #1.17
echo -e "\e[1;34m CIS BENCHMARK #1.17 : To Ensure a support role has been created to manage incidents with AWS Support \e[0m"
	aws iam list-policies --query "Policies[?PolicyName == 'AWSSupportAccess']"
	sleep 2
echo -e "\e[1;37m Check if the 'AWSSupportAccess' policy is attached to any role: \e[0m"	
echo -e "\e[1;37m Command1:aws iam list-entities-for-policy --policy-arn arn:aws:iam::aws:policy/AWSSupportAccess \e[0m"
	sleep 2
echo -e "\e[1;33m CIS BENCHMARK #1.17 Audit Done! \e[0m"
echo "=================================================================="

#Audit #1.19
echo -e "\e[1;34m CIS BENCHMARK #1.19 : To Ensure that all the expired SSL/TLS certificates stored in AWS IAM are removed \e[0m"
	aws iam list-server-certificates
	sleep 2
echo -e "\e[1;33m CIS BENCHMARK #1.19 Audit Done! \e[0m"
echo "=================================================================="

#Audit #1.20
echo -e "\e[1;34m CIS BENCHMARK #1.20 : To Ensure that IAM Access analyzer is enabled for all regions \e[0m"
	aws accessanalyzer list-analyzers | grep status
	sleep 2
echo -e "\e[1;33m CIS BENCHMARK #1.20 Audit Done! \e[0m"
echo "=================================================================="
