import QtQuick 2.2
import QtQuick.XmlListModel 2.0

Item {

    property string city: "Aachen"
    property var weatherView
    property string error
    property string flickrAPIKEY: "4ef2fe2affcdd6e13218f5ddd0e2500d"
    property int randomNumber : reGenerateRandom()

    function generateRandom(){
        return Math.random () * 360;
    }

    function reGenerateRandom(){
        randomNumber = generateRandom();
    }

    XmlListModel {
        id: rsp
        source: "http://api.flickr.com/services/rest/?&method=flickr.photos.search&privacy_filter=1&safe_search=1&api_key=" + flickrAPIKEY + "&per_page=1&page=" + randomNumber + "&tags=" + city

        XmlRole {
            name: "xml_id"
            query: "photos/photo/@id/string()"
        }

        XmlRole {
            name: "xml_secret"
            query: "photos/photo/@secret/string()"
        }

        XmlRole {
            name: "xml_server"
            query: "photos/photo/@server/string()"
        }

        XmlRole {
            name: "xml_farm"
            query: "photos/photo/@farm/string()"
        }

        onStatusChanged:
        {
            if(status === XmlListModel.Ready && count >= 1)
            {
                var url = "http://farm" + get(0).xml_farm + ".staticflickr.com/" + get(0).xml_server + "/" + get(0).xml_id + "_" + get(0).xml_secret + ".jpg"
                weatherView.flickrUrl = url;
            }

            if(status == XmlListModel.Error)
            {
                return error = errorString();
            }
            else if (status == XmlListModel.Ready)
            {
                error = rsp.count === 0 ? "Error loading flickr img (invalid city name?)" : "";
            }
        }
    }
}
