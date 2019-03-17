import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12
import QtMultimedia 5.4
import QtQuick.Controls 2.5

import ai.lipr 1.0

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("LipR")

    Engine {
        id: engine
    }

    Camera {
        id: camera
        captureMode: Camera.CaptureStillImage

        imageCapture {
            onImageCaptured: {
                engine.process()
            }
        }
    }

    VideoOutput {
        id: viewfinder

        anchors.fill: parent

        source: camera
        autoOrientation: true
    }

    Button {
        text: "Capture"

        onClicked: {
            camera.imageCapture.captureToLocation(engine.imagePath)
        }
    }
}
