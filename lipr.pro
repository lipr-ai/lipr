QT += quick
CONFIG += c++11

# The following define makes your compiler emit warnings if you use
# any Qt feature that has been marked deprecated (the exact warnings
# depend on your compiler). Refer to the documentation for the
# deprecated API to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        main.cpp \
    Engine.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    Engine.h

mac {
    OPENCV_PATH = /usr/local/opt/opencv
	message("mac build")
}

win {
    OPENCV_PATH = "C:/tools/opencv/build"
	message("win build")
}

win32 {
    OPENCV_PATH = "C:/tools/opencv/build"
	message("win32 build")
}

win64 {
    OPENCV_PATH = "C:/tools/opencv/build"
	message("win64 build")
}

message("OPENCV_PATH:")
message($$OPENCV_PATH)

INCLUDEPATH += $$OPENCV_PATH/include/opencv4

LIBS += -L$$OPENCV_PATH/lib -lopencv_core -lopencv_imgcodecs -lopencv_imgproc -lopencv_objdetect -lopencv_highgui
