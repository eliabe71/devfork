#ifndef MYPROXYMODEL_H
#define MYPROXYMODEL_H
#include <QAbstractItemModel>
#include <QVariant>
#include <QSortFilterProxyModel>
#include <notadatabasemodel.h>
#include <database.h>
#include <QQmlEngine>
#include <QCoreApplication>
#include <QObject>
class MyProxyModel : public QSortFilterProxyModel
{
    Q_OBJECT
private:
    int idUserFilter;
public:
    MyProxyModel(int idd=-1, QObject *parent=nullptr, NotaDatabaseModel *model = nullptr);
    Q_INVOKABLE void setId(int id);

    bool filterAcceptsRow(int source_row, const QModelIndex &source_parent) const override;
};

#endif // MYPROXYMODEL_H
