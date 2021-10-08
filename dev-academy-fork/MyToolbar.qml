import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
ToolBar {
    id: root
    property  var stack
    property  string magnifyclosesrc : "qrc:/icons/magnify-close.png"
    property  string magnifysrc : "qrc:/icons/magnify.png"
    property  string  buttongridsrc : "qrc:/icons/view-grid-outline.png"
    property  string  buttonlistsrc : "qrc:/icons/view-grid-rows.png"
    signal listbuttonClicked();
    signal buttonSaved();
    signal trashButtonClicked();
    signal searchButtonClicked();
    signal searchTextChanged(string filter);
    function offButtons(){
        search.visible = false
        magnify.visible = false
        savebutton.visible = true
        gridorlist.visible = false
    }
    function alterMagnify(){
        magnify.icon.source = magnifysrc
        search.visible = false
        searchButtonClicked()
    }
    function onButtons(){
        savebutton.visible = false
        magnify.visible = true
        gridorlist.visible = true
    }
    function setTrashButton(on){
        excluir.visible = on
    }
    RowLayout{

        spacing: 10
        anchors.fill:parent

        ToolButton{
            id : buttonreturn
            icon.source: "/icons/return.png"
            onClicked: stack.pop()

        }
        Rectangle{
            id:fillArea
            Layout.fillWidth: true

        }

        TextField{
            id: search
            visible: false
            Layout.fillWidth: true
            placeholderText: "Buscar"
            onTextChanged: {
                searchTextChanged(search.text);
            }

        }

        Image {
            id: excluir
            visible: false
            source: "/icons/trash.png"
            sourceSize.width: 30
            sourceSize.height: 30
            MouseArea{
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: trashButtonClicked()

            }
        }
        Image {
            id: savebutton
            Layout.rightMargin: 8
            source: "/icons/save.png"
            sourceSize.width: 30
            sourceSize.height: 30
            MouseArea{
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor

                onClicked: stack.pop()
            }
        }
        ToolButton{

            id: magnify
            icon.source: magnifysrc

            onClicked: {

                if(magnify.icon.source == magnifysrc){

                    magnify.icon.source = magnifyclosesrc
                    fillArea.width = 30
                    search.visible= true

                }
                else{
                    magnify.icon.source = magnifysrc
                    search.visible = false
                    search.text=""
                    searchButtonClicked()
                }
            }

        }
        ToolButton{
            id: gridorlist
            icon.source: buttonlistsrc

            onClicked: {

                if(gridorlist.icon.source == buttonlistsrc){

                    gridorlist.icon.source = buttongridsrc

                }
                else{
                    gridorlist.icon.source = buttonlistsrc

                }
                listbuttonClicked()
            }

        }
    }
}
