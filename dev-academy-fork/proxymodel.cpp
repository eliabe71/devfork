#include "proxymodel.h"

MyProxyModel::MyProxyModel(int idd,QObject *parent, NotaDatabaseModel *model) :
    QSortFilterProxyModel(parent)
{
    setId(idd);

    if(model)
        this->setSourceModel(model);
}

void MyProxyModel::setId(int id)
{
    this->idUserFilter=id;
}

bool MyProxyModel::filterAcceptsRow(int source_row, const QModelIndex &source_parent) const
{
    QModelIndex  userIndex = sourceModel()->index(source_row, 5, source_parent);
    qDebug()<< sourceModel()->data(userIndex).toInt();
    return sourceModel()->data(userIndex).toInt() == this->idUserFilter;
}

void registerType3() {
    qmlRegisterType<MyProxyModel>("Models", 1, 0, "ProxyModel");
}
Q_COREAPP_STARTUP_FUNCTION(registerType3)
