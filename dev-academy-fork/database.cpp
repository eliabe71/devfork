#include "database.h"
const static QString CONNECTION_NAME = "dev_adb";
bool Database::openDatabase()
{
    QDir currentPath = QDir::currentPath();
    QString path = currentPath.absolutePath() + "/" + CONNECTION_NAME+ ".db3";
    bool driver =  QSqlDatabase::isDriverAvailable("QSQLITE");

    if( conected()){
        this->m_dataBase = QSqlDatabase::database(CONNECTION_NAME);
    }
    else if(driver){
        this->m_dataBase = QSqlDatabase::addDatabase("QSQLITE", CONNECTION_NAME);
    }
    m_dataBase.setDatabaseName(path);
    bool needCreated = currentPath.exists(path);
    if(m_dataBase.open() && !needCreated){
        return sqlScript(":/init_db.sql");
    }

    return (needCreated) ? true: false;
}

bool Database::conected()
{
    return QSqlDatabase::contains(CONNECTION_NAME);
}

bool Database::sqlScript(QString path)
{
    QFile scriptFile(path);
    if(scriptFile.exists() && m_dataBase.open() && m_dataBase.isValid()){
        if(scriptFile.open(QIODevice::ReadOnly)){
            QStringList querys = QTextStream(&scriptFile).readAll().split(";");
            for(QString query : querys){
                if(query.trimmed().isEmpty() )
                    continue;
                if(m_dataBase.exec(query.trimmed()).lastError().isValid()) {
                    qDebug()<<"Erro, Tabela Não Criadas No Banco de Dados";
                    return false;
                }

            }
            return true ;
        }
    }
    return false;
}

Database::Database()
{

    if(openDatabase()){
        qDebug()<< "Database Open";
    }
    else {
        qDebug()<< "Error Database";
    }
}

QSqlDatabase &Database::database()
{
    return m_dataBase;
}
