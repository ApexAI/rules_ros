#!/bin/bash

REPOS_INDEX_FILE="$1"
REPOS_SETUP_FILE="$2"

REPOS_SETUP_FILE_SHA256=$(grep "SHA256" "${REPOS_SETUP_FILE}" | cut -f 5 -d ' ')

if [[ -z "${REPOS_SETUP_FILE_SHA256}" ]]; then
  echo "${REPOS_SETUP_FILE} DOES NOT HAVE A SHA256 COMMENT. TERMINATING"
  exit -1
elif [[ "${REPOS_SETUP_FILE_SHA256}" =~ ^[a-f0-9]{65}$ ]]; then
  echo "${REPOS_SETUP_FILE} INVALID SHA256 COMMENT of ${REPOS_SETUP_FILE_SHA256}. TERMINATING"
  exit -1
fi

REPOS_INDEX_FILE_SHA256=$(sha256sum "${REPOS_INDEX_FILE}" |  cut -f 1 -d ' ')

if [ "${REPOS_INDEX_FILE_SHA256}" != "${REPOS_SETUP_FILE_SHA256}" ]; then
  echo "SHA256 MISMATCH. RUN 'bazel run @rules_ros//repos/config:repos_lock.update' THEN TRY AGAIN"
  exit -1
fi

exit 0