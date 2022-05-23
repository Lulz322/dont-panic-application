#ifndef TRAY_H
#define TRAY_H

#include <QGuiApplication>
#include <QObject>
#include <QIcon>
#include <QAction>
#include <QMenu>
#include <QSystemTrayIcon>
#include <QQmlApplicationEngine>
#include <headers/applicationcontroller.h>

class Tray : public QObject {
	Q_OBJECT
public:
	static QSharedPointer<Tray> & getInstance(){
		static QSharedPointer<Tray> instance = QSharedPointer<Tray>(new Tray());
		return instance;
	}

	~Tray();

	void setApplication(QApplication * app);
	void createEngine();


signals:
	void signalIconActivated();
	void signalShow();
	void signalQuit();
	void signalCreate();

private slots:
	/* The slot that will accept the signal from the event click on the application icon in the system tray
	 */
	void iconActivated(QSystemTrayIcon::ActivationReason reason);

public slots:
	void hideIconTray();
	Q_INVOKABLE void exitButton();
	void createNotification(QString tooltip, QString msg, int sec);

private:
	explicit Tray(QObject *parent = nullptr);
	/* Declare the object of future applications for the tray icon*/
	QSystemTrayIcon         *	trayIcon;
	QQmlApplicationEngine *		_engine;
	QApplication *				_app;

};


#endif // TRAY_H
