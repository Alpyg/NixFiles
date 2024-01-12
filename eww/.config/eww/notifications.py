import dbus
import dbus.service
from dbus.mainloop.glib import DBusGMainLoop
from gi.repository import GLib
import threading
import time

class Notification:
    def __init__(self, app, icon, summary, body, actions, hints):
        self.app = app
        self.icon = icon
        self.summary = summary
        self.body = body
        self.actions = actions
        self.hints = hints

notifications = []

def remove_object(notif, timeout):
    time.sleep(timeout)
    notifications.remove(notif)
    print_state()

def add_object(notif, timeout = 3):
    notifications.insert(0, notif)
    timer_thread = threading.Thread(target=remove_object, args=(notif, max(3, timeout),))
    timer_thread.start()
    print_state()

def print_state():
    string = ""
    for item in notifications:
        string = string + f"""
            (button :class 'notification'
                (box :orientation 'horizontal' :space-evenly false
                    (box :orientation 'vertical'
                        {f"(label :class 'notification_app' :width 100 :wrap true :text '{item.app}')" if item.app else ""}
                        {f"(label :class 'notification_summary' :width 100 :wrap true :text '{item.summary}')" if item.summary else ""}
                        {f"(label :class 'notification_body' :width 100 :wrap true :text '{item.body}')" if item.body else ""}
                    )
                    {f"(image :class 'notification_icon' :image-width 80 :image-height 80 :path '{item.icon}')" if item.icon else ""}
                )
            )
            """
    string = string.replace('\n', '')
    print(fr"""(box :orientation 'vertical' {string or ''})""", flush=True)

class NotificationServer(dbus.service.Object):
    def __init__(self):
        bus_name = dbus.service.BusName('org.freedesktop.Notifications', bus=dbus.SessionBus())
        dbus.service.Object.__init__(self, bus_name, '/org/freedesktop/Notifications')

    @dbus.service.method('org.freedesktop.Notifications', in_signature='susssasa{ss}i', out_signature='u')
    def Notify(self, app_name, replaces_id, app_icon, summary, body, actions, hints, timeout):
        add_object(Notification(app_name, app_icon, summary, body, actions, hints), timeout)
        return 0

    @dbus.service.method('org.freedesktop.Notifications', out_signature='ssss')
    def GetServerInformation(self):
        return ("Custom Notification Server", "ExampleNS", "1.0", "1.2")

DBusGMainLoop(set_as_default=True)

if __name__ == '__main__':
    server = NotificationServer()
    mainloop = GLib.MainLoop()
    mainloop.run()
