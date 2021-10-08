import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.3
Item {
    id : root
    property string name : "login"

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
                id: imgIcon
                source: "/icons/iconinit.png"
                sourceSize.width: 100
                sourceSize.height: 100
            }
        }
        ColumnLayout{
            Layout.bottomMargin: 50

            TextField{
                id:email

                Layout.fillWidth : true
                placeholderText: "Email"
                validator : RegExpValidator { regExp: /([a-z]+[0-9A-F]*)@.[a-z]+.[a-z]+/ }

            }
            Label{
                function errorEmail(){
                    emailerror.text = "Campo Email Vazio"
                }
                id:emailerror
                color:"red"
                text: "email Não Cadastrado"
                visible: false
            }
            TextField{
                id:password
                echoMode : TextField.Password
                Layout.fillWidth : true
                placeholderText: "Senha"
            }
            Label{
                id:passworderror
                color:"red"
                text: "Senha Inválida"
                visible: false
            }
            CheckBox{

                id: hidepassword
                checked: false
                text: "Mostrar Senha"
                onClicked: {
                    if(hidepassword.checked){
                        password.echoMode = TextField.Normal
                    }
                    else {
                        password.echoMode = TextField.Password
                    }
                }
            }
            Button {
                Layout.fillWidth : true
                text: "Login"
                onClicked: {
                    let registered = userModel.existsInDataBase(email.text.toString())
                    if(!password.text){
                        passworderror.visible = true
                        if(!email.text){
                            emailerror.errorEmail()
                            return
                        }
                        return
                    }
                    if(!email.text){
                        emailerror.errorEmail()
                        return
                    }
                    if(registered) {
                        email.text = ""
                        password.text = ""

                        stack.push('qrc:/home.qml', { 'stack' : stack })
                    }
                    else{
                        emailerror.visible = true
                    }
                }


            }
            Button {
                Layout.fillWidth : true
                text: "Cadastro"
                flat: true
                onClicked: {
                    stack.push('qrc:/singup.qml', { 'stack' : stack })
                }
            }


        }
    }

}
