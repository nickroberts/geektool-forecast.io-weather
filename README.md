# Forecast.io Weather Geeklet

This is a Geeklet that will display the weather using the forecast.io embedable code. It uses phantomjs and imagemagick to render an image to display.

## Installation

Make sure you have a few things installed:

* [Homebrew](http://brew.sh/) (easiest way to install the following two packages)
* [ImageMagick](http://www.imagemagick.org/)
* [phantomjs](http://phantomjs.org/)

Once you have Homebrew installed, you can run the following command to install imagemagick and phantomjs:

`brew install imagemagick phantomjs`

### Clone the repo into a directory:

`git clone git@github.com:nickroberts/geektool-forecast.io-weather.git <your installation directory>`

### Get your location's latitude and longitude:
You can use the site [itouchmap](http://itouchmap.com/latlong.html) to find out your latitude and longitude.

### Create a Geektool script with the following format:

Replace the arguments with your own values.

`<your installation directory>/forecast.io.sh <latitude> longitude "<title>" <LIGHT/DARK>`

Set the script to refresh every 600s. (you can make this whatever you want)

Check the override text so that there is no text shown on the screen.

*Note: the 4th argument has to be either "LIGHT" or "DARK" depending on which version you would like.*

### Create an image Geektool Geeklet:

Update the image URL:

`file://localhost/<your installation directory>/weather.png`

Set the image to refresh every 600s. (you can make this whatever you want)

*Note: don't forget the file://localhost part, or else it will not find the image. You can also browse for the file.*

### You're now in business!

In the future, I will look to add color customization, and perhaps font customization, and any other options that forecast.io has.