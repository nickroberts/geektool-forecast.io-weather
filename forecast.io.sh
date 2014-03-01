#!/bin/bash

export PATH=/usr/local/bin:$PATH

export latitude="37.322998"
export longitude="-122.032182"
export title="Cupertino, CA"
export opacity=.65
export color="#ffffff"
export font="Helvetica"
export units="us"

# get the options
while getopts :c:o:f:u: option
do
    case "${option}" in

    c) color=$OPTARG;;
    o) opacity=$OPTARG;;
    f) font=$OPTARG;;
    u) units=$OPTARG;;
    ?)
        echo "You passed an illegal option. The available options are -c COLOR, -o OPACITY, -f FONT and -u UNITS."
        exit 0;;
    esac
done

# remove the options to leave us with the latitude and longitude
shift $((OPTIND - 1))

if [ $# -gt 0 ]; then
    test $# -ne 3 && echo "Usage: `basename $0` [options] LATITUDE LONGITUDE TITLE" && exit $E_BADARGS
fi

hash /usr/local/bin/phantomjs &> /dev/null
if [ $? -eq 1 ]; then
    echo "PhantomJS was not found. Please make sure it is installed."
    exit 1
fi

hash /usr/local/bin/convert &> /dev/null
if [ $? -eq 1 ]; then
    echo "ImageMagick was not found. Please make sure it is installed."
    exit 1
fi

cd `dirname $0`

# set the variables
if [ $# -gt 0 ]; then
    latitude=$1
    longitude=$2
    title=$3
fi

# rendering forecast.io's html5 page using phantomjs
phantomjs forecast.io.js "$latitude" "$longitude" "$title" "$color" "$font" "$units" "temp/weather.png"

if  test -s temp/weather.png
then
    # change the color and opacity
    echo "Rendering the color and opacity."
    convert png:temp/weather.png -fill $color -fuzz 100% -opaque '#888' -channel Alpha -evaluate multiply $opacity png:weather.png
    echo "Finished rendering the color and opacity."
    echo "The weather image has been rendered successfully."
else
    echo "There was an issue rendering the weather image: PhantomJS did not render the weather image correctly."
fi

rm -Rf temp

exit 0
