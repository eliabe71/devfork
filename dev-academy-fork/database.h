#ifndef DATABASE_H
#define DATABASE_H
#include <QSqlDatabase>
#include <QDir>
#include <QTextStream>
#include <QSqlQuery>
#include <QSqlError>
#include <QDebug>
class Database : public QSqlDatabase
{
private :
    QSqlDatabase m_dataBase;
    bool openDatabase();
    bool conected();
    bool sqlScript(QString);
public:
    Database();
    QSqlDatabase& database();


};

#endif // DATABASE_H
