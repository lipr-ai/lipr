#include <QDebug>
#include <QDir>
#include <QStandardPaths>

#include <vector>

#include <opencv2/highgui/highgui.hpp>
#include <opencv2/imgproc/types_c.h>
#include <opencv2/imgproc/imgproc.hpp>

#include "Engine.h"

using namespace cv;
using namespace std;

Engine::Engine(QObject *parent) : QObject(parent) {
	QDir dir(QStandardPaths::writableLocation(QStandardPaths::PicturesLocation));
	_imagePath = dir.filePath("lipr.png");
	QString haarPath = "/usr/local/opt/opencv/share/opencv4/haarcascades/haarcascade_frontalface_default.xml";
	qDebug() << "Loading cascade:" << _cascade.load(haarPath.toStdString());
}

const QString Engine::imagePath() const {
	return _imagePath;
}

const QVariantList Engine::rects() const {
	return _rects;
}

void Engine::process() {
	qDebug() << "Processing:" << imagePath();
	Mat image = imread(imagePath().toStdString());
	qDebug() << image.cols << "x" << image.rows;
	Mat gray, smallImg;
	cvtColor(image, gray, CV_BGR2GRAY);

	double fx = 1;

	// Resize the Grayscale Image
	resize(gray, smallImg, Size(), fx, fx, INTER_LINEAR);
	equalizeHist(smallImg, smallImg);

	vector<Rect> faces;
	// Detect faces of different sizes using cascade classifier
	_cascade.detectMultiScale(smallImg, faces, 1.1,
	                          2, 0 | CASCADE_SCALE_IMAGE, Size(30, 30));
	qDebug() << smallImg.cols << "x" << smallImg.rows;

	qDebug() << "faces:" << faces.size();

	_rects.clear();

	double width = static_cast<double>(smallImg.cols);
	double height = static_cast<double>(smallImg.rows);

	for (size_t i = 0; i < faces.size(); i++) {
		Rect rect = faces[i];
		qDebug() << rect.x << rect.y << rect.width << rect.height;
		_rects.append(QRectF(static_cast<double>(rect.x) / width,
		                     static_cast<double>(rect.y) / height,
		                     static_cast<double>(rect.width) / width,
		                     static_cast<double>(rect.height) / height));
	}

	emit rectsChanged(_rects);
}
