import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12
import QtMultimedia 5.4
import QtQuick.Controls 2.5

import ai.lipr 1.0

Window {
    visible: true
    width: 1280
    height: 720
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
        id: preview
        source: camera
        autoOrientation: true
    }

    Button {
        text: "Capture"

        onClicked: {
            camera.imageCapture.captureToLocation(engine.imagePath)
        }
    }

    Repeater {
        model: engine.rects

        delegate: Rectangle {
            x: preview.x + preview.width * modelData.x
            y: preview.y + preview.height * modelData.y
            width: preview.width * modelData.width
            height: preview.height * modelData.height
            border.color: "red"
            color: "transparent"
        }
    }
}
