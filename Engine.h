#ifndef ENGINE_H
#define ENGINE_H

#include <QObject>

#include <opencv2/objdetect.hpp>

class Engine : public QObject {
	QString _imagePath;
	cv::CascadeClassifier _cascade;

	Q_OBJECT
	Q_PROPERTY(QString imagePath READ imagePath)

public:
	explicit Engine(QObject *parent = nullptr);

	const QString imagePath() const;

signals:

public slots:
	Q_INVOKABLE void process();
};

#endif // ENGINE_H