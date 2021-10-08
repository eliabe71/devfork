#ifndef NOTADATABASEMODEL_H
#define NOTADATABASEMODEL_H
#include <QtSql/QSqlTableModel>
#include "database.h"
#include <QQmlEngine>
#include <QCoreApplication>

class NotaDatabaseModel : public QSqlTableModel
{
    Q_OBJECT
private :
    QHash<int, QByteArray> myRoles;
    Database *db;
public:
    enum Roles{Id = Qt::UserRole+1,Titulo, Desc,Cor, Date};
    Q_ENUM(Roles)
    explicit NotaDatabaseModel(QObject *parent = nullptr, Database *database = new Database());
    void configureRoles();
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;
    Q_INVOKABLE bool registerGrade(QString desc, QString titulo,QString date,QString cor,int user_id);
    Q_INVOKABLE bool updateGrade(int id ,QString desc, QString titulo,QString date,QString cor,int user_id);
    Q_INVOKABLE bool deleteLine(int id);
};

#endif // NOTADATABASEMODEL_H
