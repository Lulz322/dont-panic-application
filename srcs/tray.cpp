#include "headers/tray.h"
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QAbstractEventDispatcher>
#include <QAbstractNativeEventFilter>
#include <QQmlContext>
#include <QApplication>

Tray::Tray(QObject *parent) : QObject(parent)
{
	_engine = nullptr;

	QMenu *trayIconMenu = new QMenu();

	QAction * viewWindow = new QAction(tr("Open Window"), this);
	QAction * quitAction = new QAction(tr("Exit"), this);

	connect(trayIconMenu, &QMenu::triggered, this, [&](){

	});
	connect(viewWindow, &QAction::triggered, this, &Tray::createEngine);
	connect(quitAction, &QAction::triggered, this,  [&](){

		_app->quit();
	});

	trayIconMenu->addAction(viewWindow);
	trayIconMenu->addAction(quitAction);


	trayIcon = new QSystemTrayIcon();
	trayIcon->setContextMenu(trayIconMenu);
    trayIcon->setIcon(QIcon(":/images/Assets/images/logo.png"));
	trayIcon->show();
    trayIcon->setToolTip("Don't Panic!" "\n"
						 "Work with winimizing program to tray");

	connect(trayIcon, &QSystemTrayIcon::activated, this, [&](QSystemTrayIcon::ActivationReason reason){
		if (reason == QSystemTrayIcon::ActivationReason::Context)
			return ;
		if (_engine)
			exitButton();
		else
			createEngine();

	});

//	connect(trayIcon, SIGNAL(activated(QTrayIcon::ActivationReason)),
//			this, [&](QTrayIcon::ActivationReason){

//	});/*SLOT(iconActivated(QTrayIcon::ActivationReason)));*/


	QQmlEngine::setObjectOwnership(this, QQmlEngine::CppOwnership);

}

Tray::~Tray()
{
	delete trayIcon;
}

void Tray::setApplication(QApplication *app)
{
	_app = app;
}

void Tray::createEngine()
{
	const QUrl url(u"qrc:/client_app/UI/main.qml"_qs);
	if (_engine)
	{
		emit signalShow();
		return ;
	}


	_engine = new QQmlApplicationEngine(_app);


	auto appController = ApplicationController::getInstance();

//	Translator::getInstance()->setQApplication(_app);
//	Translator::getInstance()->setQmlEngine(_engine);

	QObject::connect(_engine, &QQmlApplicationEngine::objectCreated,
					 _app, [url](QObject *obj, const QUrl &objUrl) {
		if (!obj && url == objUrl)
			QCoreApplication::exit(-1);
	}, Qt::QueuedConnection);
	_engine->load(url);

	emit signalCreate();

}


void Tray::iconActivated(QSystemTrayIcon::ActivationReason reason)
{
	switch (reason){
	case QSystemTrayIcon::Trigger:
		emit signalIconActivated();
		break;
	default:
		break;
	}
}

void Tray::createNotification(QString tooltip, QString msg, int sec)
{
	QSystemTrayIcon::MessageIcon icon = QSystemTrayIcon::MessageIcon(QSystemTrayIcon::Information);
		trayIcon->showMessage(tooltip, msg,
							  icon,
							  sec);

}

void Tray::hideIconTray()
{
	trayIcon->hide();
}

void Tray::exitButton()
{
	(_engine)->deleteLater();
	_engine = nullptr;
}
