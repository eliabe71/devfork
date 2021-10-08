import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.3
import QtQuick 2.15

Item {
    id : root
    property string name : "singup"

    property var stack

    anchors.fill: parent
    ColumnLayout{
        function widthC(){
            if(parent.width <= 640){
                return 280
            }
            return 310
        }
        spacing: 5
        anchors.centerIn: parent
        width:widthC()
        ColumnLayout{
            Layout.alignment: Qt.AlignCenter
            Layout.bottomMargin: 50
            Image {
                id: imgCad
                source: "/icons/cadrasto.png"
                sourceSize.width: 100
                sourceSize.height: 100
            }
        }
        ColumnLayout{
            Layout.bottomMargin: 50
            TextField{
                id: texname
                Layout.fillWidth : true
                placeholderText: "Nome"
            }
            Label{
                id:nameerr
                color: "red"
                visible: false
                text: "O Campo Nome Está Vazio"

            }
            TextField{
                id: texemail
                Layout.fillWidth : true
                placeholderText: "Email"
                validator : RegExpValidator { regExp: /([a-z]+[0-9A-F]*)@.[a-z]+.[a-z]+/ }

            }
            Label{
                id:emailerr
                color: "red"
                visible: false
                function error(){
                    if(!texemail.text){
                        return "O Campo Email está vazio"
                    }
                    else {
                        return "email Ja Cadrastado"
                    }
                }
                onVisibleChanged: {
                    emailerr.text=error()
                }

            }
            TextField{
                id: texpassword
                Layout.fillWidth : true
                placeholderText: "Senha"
            }
            Label{
                id:passworderr
                color: "red"
                visible: false
                text: "Senha Inválida"

            }
            RowLayout {


                Button {
                    Layout.leftMargin:25
                    text: "Cancelar"
                    onClicked: stack.pop()
                }
                Button {
                    Layout.leftMargin:25
                    text: "Cadrastar"
                    onClicked: {
                        if(!texpassword.text){
                            passworderr.visible = true
                        }
                        if(!texname.text){
                            nameerr.visible = true
                        }
                        if(!texemail.text ){
                            emailerr.visible = true
                        }
                        if((userModel.existsInDataBase(texemail.text.toString()))){
                            console.log(texemail.text.toString())
                            emailerr.visible = true
                        }
                        else if(texpassword.text && texname.text && texname.text ){
                            let password = texpassword.text.toString()
                            let nameS = texname.text.toString()
                            let emailS = texemail.text.toString()
                            userModel.registerInTheDatabase(emailS, nameS, password)
                            stack.pop()
                        }

                    }


                }
            }
        }
    }

}
