import QtQuick 2.2



Rectangle
{
    color: "#333333"
    width: 600
    height: 400

    WeatherLoader {
        id: loader
        anchors.rightMargin: -94
        anchors.bottomMargin: 0
        anchors.leftMargin: 94
        anchors.topMargin: 0
        anchors.fill: parent
        city: "Aachen"
        weatherView: weatherView
    }

    FlickrLoader {
        id: flickrloader
        anchors.rightMargin: -94
        anchors.bottomMargin: 0
        anchors.leftMargin: 94
        anchors.topMargin: 0
        anchors.fill: parent
        city: "Aachen"
        weatherView: weatherView
    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        text: loader.error
        color: "#d3d3d3"
        font.pointSize: 30
        z: 1000
    }

    WeatherView {
        id: weatherView
        flickrLoader: flickrloader
        weatherLoader: loader
        anchors.fill: parent
        color: "#00000000"
    }

}
