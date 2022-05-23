#ifndef TCPSOCKET_H
#define TCPSOCKET_H

#include <QGuiApplication>
#include <QObject>
#include <QQmlApplicationEngine>
#include <QTcpSocket>
#include <atomic>


class TCPSocket : public QObject {
	Q_OBJECT
private:
	TCPSocket();

public:
	static QSharedPointer<TCPSocket> & getInstance(){
		static QSharedPointer<TCPSocket> instance = QSharedPointer<TCPSocket>(new TCPSocket());
		return instance;
	}

	~TCPSocket();

	void connect_to_host(const std::string & ip = "localhost", uint16_t port = 1488);

	enum STATUS{
		CONNECTED,
		DISCONNECTED
	};

	void sendMessage(const QByteArray & message);

signals:
	void connected();
	void disconnected();
	void bytesWritten(qint64 bytes);
	void readyRead();
	void message(const std::string &);

private slots:
	void onConnected();
	void onDisconnected();
	void onBytesWritten(quint64);
	void onReadyRead();

public slots:


private:
	void timerEvent(QTimerEvent * event);
	QThread *			_thread;

private:
	QTcpSocket *				_socket;
	STATUS						_socket_status;

	std::string					_ip;
	uint16_t					_port;
	std::atomic_uint32_t		_timer_id;
};


#endif // TCPSOCKET_H
