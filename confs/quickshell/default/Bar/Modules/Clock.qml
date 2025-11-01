import Quickshell
import QtQuick
import qs.Theme
import qs.Common

Row {
    id: root
    spacing: 5

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }

    DefaultText {
        text: Qt.formatDateTime(clock.date, "ddd MMM d  hh:mm:ss")
    }
}
