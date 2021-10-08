import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.12
import Models 1.0
import QtQuick.Layouts 1.15
import QtQuick.Dialogs 1.3

ApplicationWindow {
    width: 640
    height: 480
    visible: true


    Material.theme: Material.dark

    Component.onCompleted:{
//        filterData.setId(userModel.getId())
        stack.push('qrc:/login.qml', { 'stack' : stack })

    }
    header: MyToolbar{
        id: toolbar
        stack: stack
        onListbuttonClicked:{
            stack.currentItem.alterGrid()

        }
        onTrashButtonClicked:{
            if(stack.currentItem.name == "addnote"){
                stack.currentItem.eliminated = true
                stack.pop()
            }
        }
        onSearchTextChanged:{
            if(stack.currentItem.name =="homeView"){
                stack.currentItem.filterOpacity = filter
            }
        }
        onSearchButtonClicked:{
            if(stack.currentItem.name =="homeView"){
                stack.currentItem.filterOpacity = ""
            }
        }
    }
    ColorDialog{
        id:colorSet
        onColorChanged: {
            stack.currentItem.colorBackground()
        }

    }

    footer: ToolBar{
        function onButtonsHome(){
           colorsetButton.visible = false
           plusButton.visible = true
        }
        function onButtonsadd(){
           colorsetButton.visible = true
           plusButton.visible = false
        }
        id : toolbarFooter

        RowLayout{
            anchors.fill: parent


            Image {
                Layout.leftMargin: 8
                id: colorsetButton
                source: "/icons/pallete.png"
                sourceSize.width: 35
                sourceSize.height: 35
                MouseArea{
                    anchors.fill: parent
                     cursorShape: Qt.PointingHandCursor
                    onClicked: colorSet.open()
                }

            }
            ToolButton{
                id :plusButton
                visible: true
                Layout.alignment: Qt.AlignRight
                icon.source: "/icons/plusbutton.png"

                onClicked: {

                    toolbar.alterMagnify()
                    stack.push('qrc:/addnote.qml', { 'modelNota':notadata, 'userid' :userModel.getId() ,'stack' : stack })
                }
            }

        }
    }
    NotaDatabaseModel{
        id: notadata
    }
    ProxyModel{
        id: filterData
    }
    StackView {
        id:stack
        visible: true
        anchors.fill : parent
        onCurrentItemChanged: {
            if(currentItem.name == "login" ){
                toolbar.visible = false
                toolbarFooter.visible = false
                 toolbar.setTrashButton(false)
            }
            if(currentItem.name == "singup" ){
                toolbar.visible = false
                toolbarFooter.visible = false
                 toolbar.setTrashButton(false)
            }
            if(currentItem.name == "homeView" ){
                toolbar.visible = true
                currentItem.notadata= notadata
                toolbarFooter.visible = true
                toolbar.onButtons()
                toolbarFooter.onButtonsHome()
                toolbar.setTrashButton(false)
            }
            if(currentItem.name == "addnote"){
                toolbar.offButtons()
                currentItem.colorD = colorSet
                toolbarFooter.onButtonsadd()
                if(currentItem.idNote){
                    toolbar.setTrashButton(true)
                }
            }
         }
    }
}
