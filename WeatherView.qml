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
    property string weatherIcon: "01d"
    property string flickrUrl: "qrc:///images/defaultbg.jpg"
    property FlickrLoader flickrLoader

    // Uncomment this for animation when the temperature changes:
    Behavior on currentTemperature {
        PropertyAnimation {
            duration: 500
        }
    }

    //Go crazy!
    Flow {
        id: flow1
        x: 121
        y: 44
        z: 3
        width: 558
        height: 400
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter

        Text {
            id: labelCurrentTemp
            width: 436
            height: 135
            color: "#d4d4d4"
            text: currentTemperature.toFixed(1) + "°"
            verticalAlignment: Text.AlignTop
            anchors.top: parent.top
            anchors.topMargin: 197
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 100
            horizontalAlignment: Text.AlignHCenter
            style: Text.Raised
            font.family: "Tahoma"
            font.bold: true
            font.pixelSize: 115
            z: 2

            Text {
                id: text1
                x: 418
                y: 82
                color: "#ffffff"
                text: qsTr("Min")
                styleColor: "#000000"
                font.pixelSize: 12
            }

            Text {
                id: labelMinTemp
                x: 418
                y: 89
                width: 24
                height: 46
                color: "#d4d4d4"
                text: minimumTemperature.toFixed(0)
                anchors.right: parent.right
                anchors.rightMargin: -6
                style: Text.Raised
                font.bold: true
                font.pixelSize: 30
                z: 2
            }

            Text {
                id: labelMaxTemp
                x: 418
                y: 42
                width: 24
                height: 46
                color: "#d4d4d4"
                text: maximumTemperature.toFixed(0)
                styleColor: "#d4d4d4"
                anchors.right: parent.right
                anchors.rightMargin: -6
                style: Text.Raised
                font.bold: true
                font.pixelSize: 30
                z: 2
            }

            Text {
                id: text2
                x: 418
                y: 35
                width: 39
                height: 14
                color: "#ffffff"
                text: qsTr("Max")
                styleColor: "#000000"
                font.pixelSize: 12
            }

            Image {
                z: 3
                id: compassArrow
                width: 48
                height: 48
                anchors.top: parent.top
                anchors.topMargin: 36
                sourceSize.height: 66
                sourceSize.width: 66
                fillMode: Image.PreserveAspectFit
                anchors.left: parent.left
                anchors.leftMargin: -22
                source: "qrc:///images/compass_ico.png"

                transform: Rotation {
                    id: rot
                    origin.x: 24
                    origin.y: 24
                    axis.x: 0
                    axis.y: 0
                    axis.z: 1
                    angle: windDirection

                    Behavior on angle {
                        PropertyAnimation {
                            duration: 2000
                        }
                    }
                }

                Text {
                    id: labelWindDirection
                    x: 54
                    y: 13
                    width: 170
                    color: "#d4d4d4"
                    text: windDirection.toString()
                    visible: false
                    anchors.left: parent.left
                    anchors.leftMargin: 54
                    font.pixelSize: 18
                    z: 2
                }
            }

            Image {
                id: imgCloudLevel
                x: -95
                y: -77
                z: 1
                width: 50
                height: 50
                anchors.left: parent.left
                anchors.leftMargin: -100
                anchors.top: parent.top
                anchors.topMargin: 90
                clip: false
                source: "http://openweathermap.org/img/w/" + weatherIcon + ".png"

                Text {
                    id: labelCloudLevel
                    x: 38
                    y: 20
                    width: 170
                    color: "#d4d4d4"
                    text: cloudLevel.toString()
                    font.bold: true
                    style: Text.Raised
                    font.pixelSize: 16
                    z: 2
                }
            }

            Image {
                id: imglabelHumidity
                x: -25
                y: -77
                z: 1
                width: 48
                height: 48
                anchors.left: parent.left
                anchors.leftMargin: -22
                anchors.top: parent.top
                anchors.topMargin: 90
                sourceSize.height: 48
                sourceSize.width: 48
                source: "qrc:///images/humidity_ico.png"

                Text {
                    id: labelHumidity
                    x: 38
                    y: 21
                    width: 170
                    color: "#d4d4d4"
                    text: humidity.toString()
                    font.bold: true
                    font.family: "Tahoma"
                    style: Text.Outline
                    font.pixelSize: 16
                    z: 2
                }
            }
        }

        Text {
            id: labelCity
            x: 170
            width: 385
            height: 89
            color: "#d4d4d4"
            text: city
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 120
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignTop
            font.family: "Tahoma"
            style: Text.Raised
            font.pixelSize: 80
            z: 2
        }
    }

    Timer {
        interval: 3000; running: true; repeat: true;
        onTriggered: {
            console.log("reGenerateRandom")
            flickrLoader.reGenerateRandom();
            background.opacity = 0.0;
            /*
            if(){
                background.opacity = 1;
                console.log("i want to fade in");
            }
            else if(background.opacity == 1.0){
                background.opacity = 0;
                console.log("i want to fade out");
            }
            */
        }
    }


    Image {
        id: background
        asynchronous: true
        smooth: true

        anchors.fill: parent
        z: 1
        fillMode: Image.PreserveAspectCrop
        verticalAlignment: Image.AlignTop
        horizontalAlignment: Image.AlignLeft
        source: flickrUrl

        states:[
            State {
                name: 'loaded';
                when: image.status === Image.Ready
                changes: {

                }
                PropertyChanges {
                    target: background;
                    opacity: 0
                }
            }
        ]

        Behavior on opacity {
            NumberAnimation {
                duration: 600
                onStarted:{
                    console.log("opa got changed")
                }

                onRunningChanged: {
                    if(!running){
                        console.log("i d k")
                        background.opacity = 1;
                    }
                }

                onStopped:{
                    console.log("Animation stopped")
                    if(background.opacity == 0){
                        console.log("set opa back to 1")
                        background.opacity = 1;
                    }
                }
            }
        }
    }
}
