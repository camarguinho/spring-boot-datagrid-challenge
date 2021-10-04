#!/bin/bash
if [ $# -ne 1 ]
    then
        echo
        echo "Usage: $0 <location>"
        echo
        echo "Or"
        echo
        echo "Usage: $0 latest"
        echo "For latest the file temp_cookie_delete_me must exist and be a valid cookie."
        echo
elif [ $1 = "latest" ]
    then
        echo Querying latest location...
        curl -b temp_cookie_delete_me localhost:8080/latest
        echo
else
    echo Querying $1...
    curl -c temp_cookie_delete_me localhost:8080/weather/$1
    echo
fi