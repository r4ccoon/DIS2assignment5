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
    // sunrise sunset date in string but raw from the xml
    property string sunriseRaw: ""
    property string sunsetRaw: ""

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
    property WeatherLoader weatherLoader

    Behavior on currentTemperature {
        PropertyAnimation {
            duration: 500
        }
    }

    Behavior on cloudLevel {
        PropertyAnimation {
            duration: 500
        }
    }

    Behavior on minimumTemperature {
        PropertyAnimation {
            duration: 500
        }
    }

    Behavior on maximumTemperature {
        PropertyAnimation {
            duration: 500
        }
    }

    Behavior on humidity {
        PropertyAnimation {
            duration: 500
        }
    }

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

        TextInput {
            id: textEditCity
            width: 385
            height: 89
            color: "#d4d4d4"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 120
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignTop
            font.family: "Tahoma"
            font.pixelSize: 80
            z: 2
            text: qsTr("")
            visible: false

            Keys.onPressed: {
                if (event.key === Qt.Key_Enter || event.key === Qt.Key_Return) {
                    city = textEditCity.text
                    textEditCity.visible = false
                    textEditCity.focus = false
                    labelCity.visible = true
                    labelCity.text = city
                    editButton.visible = true

                    weatherLoader.city = city
                    flickrLoader.city = city
                }
            }
        }

        Text {
            id: labelCity
            x: 170
            width: 368
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

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    textEditCity.visible = true
                    textEditCity.focus = true

                    labelCity.visible = false
                    editButton.visible = false
                }
            }

            Image {
                id: editButton
                x: 71
                y: 77
                width: 32
                height: 32
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.top: parent.top
                anchors.topMargin: 0
                source: "qrc:///images/edit_ico.png"

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        textEditCity.visible = true
                        textEditCity.focus = true
                        labelCity.visible = false
                        editButton.visible = false
                    }
                }
            }
        }
    }

    function swapNight(sr, ss) {

        var currD = new Date()
        var unixCurrD = currD.getDate()

        var sunriseD = new Date(sr)
        var unixSunrise = sunriseD.getDate()

        var sunsetD = new Date(ss)
        var unixSunset = sunsetD.getDate()

        var agl = 0.0
        agl = ((unixCurrD - unixSunrise) / (unixSunset - unixSunrise)) * 360
        return agl
    }

    Image {
        id: sunBg
        x: 121
        y: 44
        z: 2
        width: 500
        height: 257
        opacity: 0.5
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter

        source: "qrc:///images/sunset_bg.png"

        Image {
            id: sunRotation
            x: -150
            y: 0
            width: 500
            height: 257
            anchors.left: parent.left
            anchors.leftMargin: 0
            fillMode: Image.Stretch
            anchors.bottom: parent.bottom
            source: "qrc:///images/sun.png"

            transform: Rotation {
                id: sunRot
                origin.x: 250
                origin.y: 257
                axis.x: 0
                axis.y: 0
                axis.z: 1
                angle: swapNight(sunriseRaw, sunsetRaw) + 200

                Behavior on angle {
                    PropertyAnimation {
                        duration: 3000
                    }
                }
            }
        }

        Text {
            id: labelSunrise
            y: 312
            color: "#d4d4d4"
            text: qsTr(sunrise)
            style: Text.Raised
            font.bold: true
            font.family: "Tahoma"
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20
            anchors.left: parent.left
            anchors.leftMargin: 0
            font.pixelSize: 12
        }

        Text {
            id: labelSunset
            x: 535
            y: 378
            color: "#d4d4d4"
            text: qsTr(sunset)
            style: Text.Raised
            font.family: "Tahoma"
            font.bold: true
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20
            font.pixelSize: 12
        }
    }

    // to swap background every 5 seconds
    Timer {
        interval: 5000
        running: true
        repeat: true
        onTriggered: {
            console.log("swap background")
            background.opacity = 0.0
            flickrLoader.reGenerateRandom()
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

        Behavior on opacity {
            NumberAnimation {
                duration: 600

                onRunningChanged: {
                    if (!running) {
                        background.opacity = 1
                    }
                }
            }
        }
    }
}
