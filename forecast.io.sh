#!/bin/bash

export PATH=/usr/local/bin:$PATH

# test to make sure the arguments are correct
test $# -ne 4 && echo "Usage: `basename $0` LATITUDE LONGITUDE TITLE LIGHT/DARK" && exit $E_BADARGS

hash /usr/local/bin/phantomjs &> /dev/null
if [ $? -eq 1 ]; then
    echo "phantomjs not found."
    exit 1
fi

hash /usr/local/bin/gs &> /dev/null
if [ $? -eq 1 ]; then
    echo "ghostscript not found."
    exit 1
fi

hash /usr/local/bin/convert &> /dev/null
if [ $? -eq 1 ]; then
    echo "imagemagick not found."
    exit 1
fi

export LIGHT=""

# checking to make sure if the 4th argument is LIGHT or DARK
if [[ $4 == "LIGHT" ]]; then
    export LIGHT="-negate"
elif [[ $4 == "DARK" ]]; then
    echo ""
else
    echo "Argument #4 must be either LIGHT or DARK"
    exit $E_BADARGS
fi

# rendering forecast.io's html5 page using phantomjs
phantomjs forecast.io.js "$1" "$2" "$3" "temp/weather.png"

if  test -s temp/weather.png
then
    # correcting the background
    echo "Correcting the background."
    convert png:temp/weather.png -fuzz 50% -transparent white png:temp/weather.png
    echo "Finished correcting the background."
    echo "Converting the color to LIGHT or DARK."
    # convert it to a light background
    convert png:temp/weather.png $LIGHT png:weather.png
    echo "Finished converting the weather image color."
    echo "The weather image has been rendered successfully."
else
    echo "There was an issue rendering the weather image: phantomjs did not render the weather image correctly."
fi

rm -Rf temp

exit 0
