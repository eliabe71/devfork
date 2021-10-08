#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <database.h>
#include <QLocale>
#include <QTranslator>
#include "usermodel.h"
#include <QQmlContext>
#include <QAbstractItemModel>
#include  "notadatabasemodel.h"
#include <QSortFilterProxyModel>
#include <proxymodel.h>
int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);
    Database db;
    userModel *usermodel = new userModel(nullptr,&db);
//    auto p = new QSortFilterProxyModel(usermodel);
//    auto newProxy = new MyProxyModel(usermodel->getId(),0,0);


    QTranslator translator;
    const QStringList uiLanguages = QLocale::system().uiLanguages();
    for (const QString &locale : uiLanguages) {
        const QString baseName = "dev-academy_" + QLocale(locale).name();
        if (translator.load(":/i18n/" + baseName)) {
            app.installTranslator(&translator);
            break;
        }
    }

    app.setOrganizationName("Some Company");
    app.setOrganizationDomain("somecompany.com");
    app.setApplicationName("Amazing Application");


    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("userModel", usermodel);
    //    engine.rootContext()->setContextProperty("filterModel", proxymodel);
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
