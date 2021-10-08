#include "notadatabasemodel.h"

NotaDatabaseModel::NotaDatabaseModel(QObject *parent, Database *database):
    QSqlTableModel(parent, database->database()),db(database)
{
    setTable("Nota");
    this->configureRoles();
    setEditStrategy(OnRowChange);
    this->select();
}

void NotaDatabaseModel::configureRoles()
{
    myRoles[Id]= "id";
    myRoles[Titulo]= "titulo";
    myRoles[Cor]= "cor";
    myRoles[Date]= "date";
    myRoles[Desc] = "desc";
}

QVariant NotaDatabaseModel::data(const QModelIndex &index, int role) const
{
    if(myRoles.contains(role)){
        int column = fieldIndex(myRoles.value(role));
        QModelIndex itemListIndex = QSqlTableModel::index(index.row(), column);
        return QSqlTableModel::data(itemListIndex);
    }
    return QVariant();

}

QHash<int, QByteArray> NotaDatabaseModel::roleNames() const
{
    return myRoles;
}

bool NotaDatabaseModel::registerGrade(QString desc, QString titulo, QString date, QString cor,int user_id)
{
    QSqlQuery query(QSqlTableModel::database());
    query.prepare("INSERT INTO Nota (titulo,desc,cor ,date ,user_id "
                  ")VALUES(:titulo , :desc , :cor, :date, :user_id)"
                  );
    query.bindValue(":titulo", titulo);
    query.bindValue(":desc", desc);
    query.bindValue(":date", date);
    query.bindValue(":user_id", user_id);
    query.bindValue(":cor", cor);
    bool r =  query.exec();
    select();
    return r;
}

bool NotaDatabaseModel::updateGrade(int id, QString desc, QString titulo, QString date, QString cor, int user_id)
{
    QSqlQuery updateQuery(QSqlTableModel::database());
    updateQuery.prepare(
                "update Nota set titulo = :titulo, desc = :desc, cor = :cor, date = :date, user_id = :userid "
                "where id = :id"
                );
    updateQuery.bindValue(":id", id);
    updateQuery.bindValue(":titulo", titulo);
    updateQuery.bindValue(":desc", desc);
    updateQuery.bindValue(":cor", cor);
    updateQuery.bindValue(":date", date);
    updateQuery.bindValue(":userid", user_id);
    bool r = updateQuery.exec();
    select();
    return r;
}

bool NotaDatabaseModel::deleteLine(int id)
{
    QSqlQuery updateQuery(QSqlTableModel::database());
    updateQuery.prepare("Delete From Nota Where id = :id");
    updateQuery.bindValue(":id", id);
    bool r = updateQuery.exec();
    select();
    return r;
}


void registerType() {
    qmlRegisterType<NotaDatabaseModel>("Models", 1, 0, "NotaDatabaseModel");
}
Q_COREAPP_STARTUP_FUNCTION(registerType)
