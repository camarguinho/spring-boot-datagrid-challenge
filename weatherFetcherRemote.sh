#!/bin/bash
if [ $# -ne 1 ]
    then
       echo
       echo "Usage: $0 <app_url>"
       echo
else
curl $1/weather/paris     ; echo
curl $1/weather/london    ; echo
curl $1/weather/berlin    ; echo
curl $1/weather/madrid    ; echo
curl $1/weather/tokyo     ; echo
curl $1/weather/lima      ; echo
curl $1/weather/lisboa    ; echo
curl $1/weather/ibiza     ; echo
curl $1/weather/piruleta  ; echo
curl $1/weather/oslo      ; echo
curl $1/weather/stockholm ; echo
fi