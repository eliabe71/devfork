import QtQuick 2.0
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.12
Item {
    id :root
    property var stack
    property string name : "addnote"
    property string titles
    property string desc
    property var idNote
    property  var modelNota
    property  int userid
    property  var colorD
    property  string colorName
    property bool eliminated
    anchors.fill: parent
    function fill(){
        titles = title.text
        desc = note.text
    }
    function colorBackground(){
        back.color = colorD.color
    }
    Rectangle{
        id : back
        anchors.fill: parent
        color: "#303030"

        ColumnLayout{
            id : rootbackgroud
            spacing: 10
            anchors.fill :parent


            TextField {
                Layout.alignment: Qt.AlignCenter
                Layout.fillWidth:  true
                id:title
                placeholderText: "Titulo"

            }
            Flickable {
                id:flickable
                Layout.fillHeight: true
                Layout.fillWidth: true
                flickableDirection: Flickable.VerticalFlick

                TextArea.flickable: TextArea {
                    id: note
                    placeholderText: "Descrição"
                    wrapMode: TextArea.Wrap

                }

                ScrollBar.vertical: ScrollBar {
                    visible: true
                }

            }
            Component.onCompleted: {
                if(idNote){
                    title.text = titles
                    note.text = desc
                    back.color = colorName
                }
            }
            Component.onDestruction: {

                var currentDate = new Date()
                var data = currentDate.toLocaleDateString(Qt.locale(), Locale.ShortFormat)
                var hora = currentDate.toLocaleTimeString(Qt.locale(), Locale.ShortFormat)
                if(eliminated){
                    console.log("Nota Removida Com Sucesso")
                    modelNota.deleteLine(idNote)
                    return
                }
                if( idNote ){
                    if(title.text && note.text)
                        console.log("Nota Atualizada Com Sucesso")
                        modelNota.updateGrade(idNote,note.text,title.text,data+' '+hora, back.color, userid)

                }else {
                    if(title.text && note.text)
                        console.log("Nota Cadrastada Com Sucesso")
                        modelNota.registerGrade(note.text,title.text,data+' '+hora,back.color,userid);

                }

            }

        }
    }
}
