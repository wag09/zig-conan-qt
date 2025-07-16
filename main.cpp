#include <QApplication>
#include <QPushButton>
#include <QtPlugin>

Q_IMPORT_PLUGIN(QXcbIntegrationPlugin)

int main(int argc, char *argv[]) {
    QApplication app(argc, argv);
    QPushButton button("Hello, Qt!");
    button.show();
    return app.exec();
}