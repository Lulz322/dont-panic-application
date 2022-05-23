#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQmlEngine>

#include <QDirIterator>
#include <QLocale>
#include <QTranslator>

#include "headers/applicationcontroller.h"
#include "headers/tray.h"

int main(int argc, char *argv[])
{
	QApplication app(argc, argv);



	QTranslator translator;
	const QStringList uiLanguages = QLocale::system().uiLanguages();
	for (const QString &locale : uiLanguages) {
		const QString baseName = "ClientApp" + QLocale(locale).name();
		if (translator.load(":/i18n/" + baseName)) {
			app.installTranslator(&translator);
			break;
		}
	}

	qmlRegisterType<ApplicationController>("Back", 1, 0, "ApplicationController");
	qmlRegisterUncreatableType<Tray>("Back", 1, 0, "Tray", "Becouse");

	auto tray = Tray::getInstance();
	tray->setApplication(&app);
	tray->createEngine();


//	QQmlApplicationEngine engine;
//    const QUrl url(u"qrc:/client_app/UI/main.qml"_qs);
//	QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
//					 &app, [url](QObject *obj, const QUrl &objUrl) {
//		if (!obj && url == objUrl)
//			QCoreApplication::exit(-1);
//	}, Qt::QueuedConnection);
//	engine.load(url);



	return app.exec();
}
