#ifndef APPLICATIONCONTROLLER_H
#define APPLICATIONCONTROLLER_H

#include <QSharedPointer>
#include <QGuiApplication>
#include <QObject>

#include "headers/TCPSocket.h"


class ApplicationController : public QObject
{
	Q_OBJECT

public:
	static QSharedPointer<ApplicationController> & getInstance(){
		static QSharedPointer<ApplicationController> instance =
				QSharedPointer<ApplicationController>(new ApplicationController());
		return instance;
	}
	explicit ApplicationController(QObject * parent = nullptr);


	Q_INVOKABLE void regUser(QByteArray username, QByteArray password);
	Q_INVOKABLE void loginUser(QByteArray username, QByteArray password);

signals:
	void error(QString errorText);

private:
	void onSocketMessage(const std::string & message);



private:
	QSharedPointer<TCPSocket> _socket;

};

#endif // APPLICATIONCONTROLLER_H
