import QtQuick 2.12
import QtQuick.Window 2.12
import QtMultimedia 5.4

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("LipR")

    Camera {
        id: camera
    }

    VideoOutput {
        id: viewfinder

        x: 0
        y: 0
        width: parent.width
        height: parent.height

        source: camera
        autoOrientation: true
    }
}
