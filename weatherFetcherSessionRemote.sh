#!/bin/bash
if [ $# -ne 2 ]
    then
        echo
        echo "Usage: $0 <app_url> <location>"
        echo
        echo "Or"
        echo
        echo "Usage: $0 <app_url> latest"
        echo "For latest the file temp_cookie_delete_me must exist and be a valid cookie."
        echo
elif [ $2 = "latest" ]
    then
        echo Querying latest location at $1...
        curl -b temp_cookie_delete_me $1/latest
        echo
else
    echo Querying $2 at $1...
    curl -c temp_cookie_delete_me $1/weather/$2
    echo
fi