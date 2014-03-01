var page = require('webpage').create();
var system = require('system');
var retina = true;

system.args.forEach(function (arg, i) {
        console.log(i + ': ' + arg);
});

if (system.args.length !== 5) {
    console.log('You need to pass in the latitude, longitude, filename and title.');
    phantom.exit();
} else {
    console.log('Checking the weather.');

    var lat = system.args[1];
    var lon = system.args[2];
    var title = system.args[3];
    var image = system.args[4];
    var url = 'http://forecast.io/embed/#lat=' + lat + '&lon=' + lon + '&name=' + title;

    page.open(url, function() {
        // take 'retina' images
        if (retina) {
            page.evaluate(function () {
                /* scale the whole body */
                document.body.style.webkitTransform = "scale(2)";
                document.body.style.webkitTransformOrigin = "0% 0%";
                /* fix the body width that overflows out of the viewport */
                document.body.style.width = "50%";
            });
        }
        // wait 3 seconds so the page can load
        setTimeout(function() {
            // remove the forecast.io link
            page.evaluate(function() {
                $('.fe_forecast_link').remove();
            });
            page.render(image);

            console.log('Rendered the weather image.');
            phantom.exit();
        }, 3000);
    });

}