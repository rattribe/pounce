#!/bin/bash

# Run as sudo!!
if [[ $EUID -ne 0 ]]
then
  echo "Please run as root"
  exit 1
fi

# Get Github credentials and logged in user vars
GHUSER=$(cat github_keys | cut -d: -f1)
GHTOKEN=$(cat github_keys | cut -d: f2)
export LIUSER=$(cat /etc/passwd | grep 1000 | cut -d: -f1)

# Clone the rest of the repo to working directory
cd /tmp
git clone https://$GHUSER:$GHTOKEN@github.com/$GHUSER/kickstart.git

# Set permissions on cloned files to run correctly.
chown root:$LIUSER /tmp/kickstart/main.sh
chmod 4754 /tmp/kickstart/main.sh

# Run main.sh from cloned repo
/bin/bash /tmp/kickstart/main.sh

# Implement sleep cmd to cleanup?
