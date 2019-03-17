#ifndef ENGINE_H
#define ENGINE_H

#include <QObject>
#include <QVariantList>
#include <QRect>

#include <opencv2/objdetect.hpp>

class Engine : public QObject {
	QString _imagePath;
	QVariantList _rects;
	cv::CascadeClassifier _cascade;

	Q_OBJECT
	Q_PROPERTY(QString imagePath READ imagePath)
	Q_PROPERTY(QVariantList rects READ rects NOTIFY rectsChanged)

public:
	explicit Engine(QObject *parent = nullptr);

	const QString imagePath() const;
	const QVariantList rects() const;

signals:
	void rectsChanged(const QVariantList rects);

public slots:
	Q_INVOKABLE void process();
};

#endif // ENGINE_H