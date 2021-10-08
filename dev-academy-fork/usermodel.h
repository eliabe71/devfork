#ifndef USERMODEL_H
#define USERMODEL_H
#include "database.h"
#include <QObject>
#include <QSqlQuery>
#include <QSqlError>
#include <QVariant>
class userModel :public QObject
{
    Q_OBJECT
private:
    QString id;
    QString email;
    QString senha;
    QString name;
    Database *db;

public:
    explicit userModel(QObject *parent = nullptr , Database *db = new Database());
    Q_PROPERTY(QString name READ getName WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(QString email READ getEmail WRITE setEmail NOTIFY emailChanged)
    QString getName();
    QString getEmail();
    Q_INVOKABLE void setEmail(QString email);
    void setName(QString name);
    Q_INVOKABLE void registerInTheDatabase(QString email , QString name, QString senha);
    Q_INVOKABLE bool existsInDataBase(QString);
    Q_INVOKABLE int getId();
    ~userModel();
signals :
    void nameChanged();
    void emailChanged();
    void singUpcancel();
    //

};

#endif // USERMODEL_H
