#!/usr/bin/ags -c

import Gdk from "gi://Gdk";
import BarWindow from "./modules/bar.js";

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
    BarWindow(monitor),
  ]);
  globalThis.monitorCounter++;
}

function addMonitorListeners() {
  const display = Gdk.Display.get_default();
  for (let m = 0;  m < (display?.get_n_monitors() ?? 0);  m++) {
    const monitor = display?.get_monitor(m);
    if (monitor != null) {
      addMonitorWindows(monitor);
    }
  }
  display?.connect("monitor-added", (_disp, monitor) => {
    addMonitorWindows(monitor);
  });

  display?.connect("monitor-removed", (_disp, monitor) => {
    App.windows.forEach(win => {
      // @ts-ignore
      if(win.gdkmonitor === monitor) App.removeWindow(win);
    });
  });
}

addMonitorListeners();

App.config({
  style: "./style.css",
})

export { }
