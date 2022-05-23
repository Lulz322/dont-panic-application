cmake_minimum_required(VERSION 3.16)

project(client_app VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 6.2 COMPONENTS Quick Widgets Network REQUIRED)


qt_add_executable(appclient_app
    resources.qrc
    srcs/main.cpp
    srcs/applicationcontroller.cpp
    srcs/tray.cpp
    srcs/TCPSocket.cpp

    headers/tray.h
    headers/applicationcontroller.h
    headers/TCPSocket.h
)


qt_add_qml_module(appclient_app
    URI client_app
    VERSION 1.0
    QML_FILES UI/main.qml
        UI/StartupWindows/LoginScreen.qml
        UI/Styles/DefaultText.qml
        UI/Styles/Input.qml
        UI/Styles/ToolBarButton.qml
        UI/Styles/DefaultButton.qml
        UI/Styles/PasswordInput.qml
        UI/StartupWindows/RegScreen.qml
        UI/StartupWindows/ForgetPassword.qml
        UI/Styles/BottomError.qml
)

set_target_properties(appclient_app PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_compile_definitions(appclient_app
    PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(appclient_app
    PRIVATE Qt6::Quick)
target_link_libraries(appclient_app PRIVATE Qt6::Widgets)
target_link_libraries(appclient_app PRIVATE Qt6::Network)
