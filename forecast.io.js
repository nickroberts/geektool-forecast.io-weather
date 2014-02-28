var page = require('webpage').create();
var system = require('system');

if (system.args.length !== 5) {
    console.log('You need to pass in the latitude, longitude, filename and title.');
    phantom.exit();
} else {
    console.log('Checking the weather.');

    var lat = system.args[1];//'42.797806';
    var lon = system.args[2];//'-83.704950';
    var title = system.args[3];//'Fenton, MI';
    var image = system.args[4];//'temp/tmp1.png';
    var url = 'http://forecast.io/embed/#lat=' + lat + '&lon=' + lon + '&name=' + title;

    page.open(url, function() {
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