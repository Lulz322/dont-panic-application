#include "headers/TCPSocket.h"
#include <QObject>
#include <QThread>

TCPSocket::TCPSocket()
{
	_socket = new QTcpSocket();

	connect(_socket, &QTcpSocket::connected, this, &TCPSocket::onConnected);
	connect(_socket, &QTcpSocket::disconnected, this, &TCPSocket::onDisconnected);
	connect(_socket, &QTcpSocket::bytesWritten, this, &TCPSocket::onBytesWritten);
	connect(_socket, &QTcpSocket::readyRead, this, &TCPSocket::onReadyRead);

	_socket_status = DISCONNECTED;

	connect_to_host();
}

TCPSocket::~TCPSocket()
{
	if (_socket && _socket->isOpen())
		_socket->disconnectFromHost();
	delete _socket;
}

void TCPSocket::connect_to_host(const std::string & ip, uint16_t port)
{
	_ip = ip;
	_port = port;
	qInfo() << "Connecting to " << ip.c_str() << ":" << port;


	_socket->connectToHost(ip.c_str(), port);

	if (!_socket->waitForConnected(5000)){
		qInfo() << "Error " << _socket->errorString();
		qInfo() << "Reconnecting in 5 seconds";
		_timer_id = startTimer(5000);
	}


}

void TCPSocket::sendMessage(const QByteArray &message)
{
	if (_socket_status == CONNECTED)
		_socket->write(message);
}

void TCPSocket::onConnected()
{
	qInfo() << "Connected";
	_socket_status = CONNECTED;
	_socket->write("Hello world!");
}

void TCPSocket::onDisconnected()
{
	_socket_status = DISCONNECTED;
	qInfo() << "Disconnected";
	qInfo() << "Error " << _socket->errorString();
	qInfo() << "Reconnecting in 5 seconds";
	_timer_id = startTimer(5000);

}

void TCPSocket::onBytesWritten(quint64 value)
{
	qInfo() << "Bytes written " << value;
}

void TCPSocket::onReadyRead()
{
	emit message(_socket->readAll().toStdString());
}

void TCPSocket::timerEvent(QTimerEvent *event)
{
	if (event->timerId() == _timer_id){
		qInfo() << "Connecting to " << _ip.c_str() << ":" << _port;

		_socket->connectToHost(_ip.c_str(), _port);

		if (!_socket->waitForConnected(5000)){
			qInfo() << "Error " << _socket->errorString();
		}else{
			killTimer(_timer_id);
			_timer_id = 0;
		}
	}

}
