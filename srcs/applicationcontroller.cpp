#include "../headers/applicationcontroller.h"
#include <QJsonObject>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonValue>

ApplicationController::ApplicationController(QObject *parent)
{
	_socket = TCPSocket::getInstance();
	connect(_socket.get(), &TCPSocket::message, this, &ApplicationController::onSocketMessage);
}

void ApplicationController::regUser(QByteArray username, QByteArray password)
{
	QJsonObject obj;

	obj["cmd"] = 10001;
	QJsonObject data;

	data["login"] = username.data();
	data["password"] = password.data();
	obj["data"] = data;

	_socket->sendMessage(QJsonDocument(obj).toJson());
}

void ApplicationController::loginUser(QByteArray username, QByteArray password)
{
	QJsonObject obj;

	obj["cmd"] = 10000;
	QJsonObject data;

	data["login"] = username.data();
	data["password"] = password.data();
	obj["data"] = data;

	_socket->sendMessage(QJsonDocument(obj).toJson());
}

void ApplicationController::onSocketMessage(const std::string &message)
{
	auto doc = QJsonDocument::fromJson(message.c_str());
	auto obj = doc.object();

	auto data = obj["data"].toObject();


	if (data["ret_code"].toInt() < 0)
		emit error(QString(data["message"].toString()));

//	qInfo() << "get " << message.c_str();

}
