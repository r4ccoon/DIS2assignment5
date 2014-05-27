import QtQuick 2.0

Rectangle {
    id: page
    width: 800
    height: 1000
    color: "#333333"

    //properties and standard values
    //these will be set by the loader
    property string sunrise: "never"
    property string sunset: "never"
    property string city: "nowhere"
    property string country: "nowhere"
    property double latitude: 0
    property double longitude: 0
    property double currentTemperature: 0 //in C
    property double maximumTemperature: 0 //in C
    property double minimumTemperature: 0 //in C
    property int humidity: 0 //in %
    property double pressure: 0 //in hPa
    property double windSpeed: 0
    property string windSpeedDescription: "nonexistent"
    property double windDirection: 0 //in deg
    property string windDirectionDescription: "nonexistent"
    property string windDirectionAbbreviation: "nonexistent"
    property int cloudLevel: 0 // in %
    property string cloudDescription: "nonexistent" // in %
    property string weatherDescription: "nothing"
    property int weatherCode: 0 //see http://bugs.openweathermap.org/projects/api/wiki/Weather_Condition_Codes

    // Uncomment this for animation when the temperature changes:
    Behavior on currentTemperature { PropertyAnimation { duration: 2000} }

    //Go crazy!

    Text {
        y: 8
        color: "#d4d4d4"
        text: "Weather for " + city
        anchors.leftMargin: 8
        anchors.left: parent.left
        font.pixelSize: 18
        z: 2
    }

    Text {
        y: 36
        width: 170
        color: "#d4d4d4"
        text: "It is currently " + currentTemperature.toFixed(2) + "°C"
        anchors.left: parent.left
        anchors.leftMargin: 8
        font.pixelSize: 18
        z: 2
    }

    Text {
        y: 64
        width: 170
        color: "#d4d4d4"
        text: "Humidity " + humidity.toString()
        anchors.left: parent.left
        anchors.leftMargin: 8
        font.pixelSize: 18
        z: 2
    }

    Text {
        y: 94
        width: 170
        color: "#d4d4d4"
        text: "Cloud level " + cloudLevel.toString()
        anchors.left: parent.left
        anchors.leftMargin: 8
        font.pixelSize: 18
        z: 2
    }

    Text {
        y: 124
        width: 170
        color: "#d4d4d4"
        text: "Wind direction " + windDirection.toString()
        anchors.left: parent.left
        anchors.leftMargin: 8
        font.pixelSize: 18
        z: 2
    }

    Image {
        z: 1
        anchors.top: parent.top
        anchors.left: parent.left
        width: page.width
        fillMode: Image.Pad
        verticalAlignment: Image.AlignTop
        horizontalAlignment: Image.AlignLeft
        source: "http://farm1.staticflickr.com/231/483342623_5a4e9bde18_b.jpg"
    }

}
