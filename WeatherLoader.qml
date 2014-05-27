import QtQuick 2.2
import QtQuick.XmlListModel 2.0


//Touch at your own peril!

Item {

    property string city: "Aachen, de"
    property var weatherView
    property string error

    XmlListModel {
        id: weather
        source: "http://api.openweathermap.org/data/2.5/weather?mode=xml&units=metric&q=" + city
        query: "/current"

        XmlRole {
            name: "xml_city"
            query: "city/@name/string()"
        }

        XmlRole {
            name: "xml_country"
            query: "city/country/string()"
        }

        XmlRole {
            name: "xml_latitude"
            query: "city/coord/@lat/string()"
        }

        XmlRole {
            name: "xml_longitude"
            query: "city/coord/@lon/string()"
        }

        XmlRole {
            query: "temperature/@value/number()"
            name: "xml_currentTemperature"

        }
        XmlRole {
            query: "temperature/@max/number()"
            name: "xml_maximumTemperature"
        }
        XmlRole {
            query: "temperature/@min/number()"
            name: "xml_minimumTemperature"
        }

        XmlRole {
            query: "humidity/@value/number()"
            name: "xml_humidity"
        }

        XmlRole {
            query: "pressure/@value/number()"
            name: "xml_pressure"
        }

        XmlRole {
            query: "wind/speed/@value/number()"
            name: "xml_windSpeed"
        }

        XmlRole {
            query: "wind/speed/@name/string()"
            name: "xml_windSpeedDescription"
        }

        XmlRole {
            query: "wind/direction/@value/number()"
            name: "xml_windDirection"
        }

        XmlRole {
            query: "wind/direction/@name/string()"
            name: "xml_windDirectionDescription"
        }

        XmlRole {
            query: "wind/direction/@code/string()"
            name: "xml_windDirectionAbbreviation"
        }
        XmlRole {
            query: "clouds/@value/number()"
            name: "xml_cloudLevel"
        }

        XmlRole {
            query: "clouds/@name/string()"
            name: "xml_cloudDescription"
        }

        XmlRole {
            name: "xml_sunrise"
            query: "city/sun/@rise/string()"
        }
        XmlRole {
            name: "xml_sunset"
            query: "city/sun/@set/string()"
        }
        XmlRole {
            name: "xml_weatherCode"
            query: "weather/@number/number()"
        }
        XmlRole {
            name: "xml_weatherDescription"
            query: "weather/@value/string()"
        }

        onStatusChanged:
        {
            if(status === XmlListModel.Ready && count >= 1)
            {
                weatherView.sunset = Qt.formatDateTime(get(0).xml_sunset, "h:mm")
                weatherView.sunrise = Qt.formatDateTime(get(0).xml_sunrise, "h:mm")
                weatherView.city =  get(0).xml_city
                weatherView.country = get(0).xml_country
                weatherView.latitude = get(0).xml_latitude
                weatherView.longitude = get(0).xml_longitude
                weatherView.currentTemperature = get(0).xml_currentTemperature
                weatherView.maximumTemperature =  get(0).xml_maximumTemperature
                weatherView.minimumTemperature = get(0).xml_minimumTemperature
                weatherView.humidity = get(0).xml_humidity
                weatherView.pressure = get(0).xml_pressure
                weatherView.windSpeed = get(0).xml_windSpeed
                weatherView.windSpeedDescription = get(0).xml_windSpeedDescription
                weatherView.windDirection = get(0).xml_windDirection
                weatherView.windDirectionDescription = get(0).xml_windDirectionDescription
                weatherView.windDirectionAbbreviation = get(0).xml_windDirectionAbbreviation
                weatherView.cloudLevel = get(0).xml_cloudLevel
                weatherView.cloudDescription = get(0).xml_cloudDescription
                weatherView.weatherCode = get(0).xml_weatherCode
                weatherView.weatherDescription = get(0).xml_weatherDescription
            }

            if(status == XmlListModel.Error)
            {
                return error = errorString();
            }
            else if (status == XmlListModel.Ready)
            {
                error = weather.count === 0 ? "Error loading weather (invalid city name?)" : "";
            }
        }
    }
}
