import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

Item {
    GridLayout {
        id: frontGridLayout
        columns: 3
        anchors.fill: parent
        Label {
            Layout.row: 0
            Layout.column: 1
            text: qsTr("Your location:")
        }
        Label {
            Layout.row: 1
            Layout.column: 0
            Layout.alignment: Qt.AlignRight
            text: qsTr("Latitude:")

        }
        Label {
            Layout.row: 2
            Layout.column: 0
            Layout.alignment: Qt.AlignRight
            text: qsTr("Longtitude:")
        }

        TextField {
            text: "55.7522200";
            Layout.row: 1
            Layout.column: 1
            id: userLatitude
        }
        TextField {
            text: "37.6155600";
            Layout.row: 2
            Layout.column: 1
            id: userLongtitude
        }
        Button {
            text: "Make Trip"
            Layout.row: 3
            Layout.column: 1
            onClicked: {
                swipeView.incrementCurrentIndex();
                mapPage.make_trip(parseFloat(userLatitude.text), parseFloat(userLongtitude.text));
            }
        }
    }

}
