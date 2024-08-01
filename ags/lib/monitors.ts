import Gdk from "gi://Gdk";
import Bar from "widget/bar/Bar"

/**
 * @param {import('types/@girs/gtk-3.0/gtk-3.0').Gtk.Window[]} windows
 */
function addWindows(windows) {
  windows.forEach(win => App.addWindow(win));
}

globalThis.monitorCounter = 0;

globalThis.toggleBars = () => {
  App.windows.forEach(win => {
    if(win.name?.startsWith("bar")) {
      App.toggleWindow(win.name);
    }
  });
};

/**
 * @param { Gdk.Monitor } monitor
 */
function addMonitorWindows(monitor) {
  addWindows([
    Bar(monitor),
  ]);
  globalThis.monitorCounter++;
}

export default function init() {
  const display = Gdk.Display.get_default();
  for (let m = 0;  m < (display?.get_n_monitors() ?? 0);  m++) {
    const monitor = display?.get_monitor(m);
    if (monitor != null) {
      addMonitorWindows(monitor);
    }
  }
  display?.connect("monitor-added", (_disp, monitor) => {
    console.log("monitor added", monitor)
    addMonitorWindows(monitor);
  });

  display?.connect("monitor-removed", (_disp, monitor) => {
    console.log("monitor removed", monitor)
    App.windows.forEach(win => {
      // @ts-ignore
      if(win.gdkmonitor === monitor) App.removeWindow(win);
    });
  });
}


