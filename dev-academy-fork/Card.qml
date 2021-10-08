import QtQuick 2.9
import QtQuick.Controls.Material 2.2
import QtQuick.Controls.Material.impl 2.12
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.0

Item {
    id: cardItem
    property int elevation: 10
    property string cardColor: "#fafafa"
    property string borderColor: 'red'
    property string title
    property string description
    Rectangle {
        id:rect
        anchors.leftMargin: 5
        anchors.topMargin: 5
        anchors.fill: parent
        color: cardColor
        border.color: borderColor
        radius: 4

        layer.enabled: cardItem.elevation > 0
        layer.effect: ElevationEffect {
            elevation: cardItem.elevation
        }
        ColumnLayout{
            anchors.fill: parent
            TextField{
                Layout.topMargin: 5
                Layout.leftMargin: 5
                Layout.maximumHeight: 30
                Text{
                    font.pointSize: 8; font.bold: true
                    text: title
                }
                Layout.fillWidth: true
                readOnly: true
            }
            Text {
                Layout.leftMargin: 5
                Layout.fillHeight: true
                id: name
                text: description
                font.pointSize: 8.5
                font.italic: true
            }

        }
    }
}
