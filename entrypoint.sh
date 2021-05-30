#!/bin/bash

set -o pipefail
set -exu

if [ ! -r "$DS_BASELINE_FILE" ]
then

	if [ $DS_REQUIRE_BASELINE -eq 0 ]
	then
		detect-secrets scan > "$DS_BASELINE_FILE"
	else
		echo "No readable detect-secrets baseline file found at '$DS_BASELINE_FILE', and it was set to required by \$DS_REQUIRE_BASELINE ($DS_REQUIRE_BASELINE)"
		exit -1
	fi

fi
export AWS_SECRET_ACCESS_KEY=G31RVQCm6M17/RrEHeq/EDwrTZhGxrSD45j7NWhB


detect-secrets -v audit "$DS_BASELINE_FILE"
exec detect-secrets scan $DS_ADDL_ARGS
