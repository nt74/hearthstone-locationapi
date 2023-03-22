#!/bin/sh
# script:       hs_locationapi_fix.sh
# description:  Search for Hearthstone options.txt file under Steam directory
#               and disable LocationAPI.
# author:       Nikos Toutountzoglou, nikos.toutou@gmail.com
# revision:     22-03-23

# variables
STEAMDIR=$HOME/.local/share/Steam
HS_OPTS_FILE=$(find $STEAMDIR -wholename "*AppData/Local/Blizzard/Hearthstone/options.txt")
LOCAPI="PrivacyDisableGeolocation\=False" # Do not change, this is the Default value
LOCAPI_FLAG="True" # Enable LocationAPI="False", Disable LocationAPI="True"

# check if $HS_OPTS_FILE has multiple hits, if so exit
if [ $(echo "$HS_OPTS_FILE" | wc -l) -gt 1 ]; then
    echo "Error: More than one Hearthstone options file found, exiting."
    exit 1
fi

# check if $HS_OPTS_FILE exists, else exit
if [ ! -f "$HS_OPTS_FILE" ]; then
    echo "Error: Hearthstone options file not found, exiting."
    exit 1
fi

# main script
echo
echo "Found Hearthstone options file, located at:"
echo "$HS_OPTS_FILE"

sed -i "s/$LOCAPI/PrivacyDisableGeolocation\=$LOCAPI_FLAG/g" "$HS_OPTS_FILE"
echo
echo "LocationAPI flag (Enabled="False", Disabled="True"), active setting:"
cat $HS_OPTS_FILE | grep PrivacyDisableGeolocation

exit
