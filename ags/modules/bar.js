import Widget from "resource:///com/github/Aylur/ags/widget.js";
import Hyprland from "resource:///com/github/Aylur/ags/service/hyprland.js";
import Notifications from "resource:///com/github/Aylur/ags/service/notifications.js";
import Mpris from "resource:///com/github/Aylur/ags/service/mpris.js";
import Audio from "resource:///com/github/Aylur/ags/service/audio.js";
import Battery from "resource:///com/github/Aylur/ags/service/battery.js";
import Systemtray from "resource:///com/github/Aylur/ags/service/systemtray.js";

const date = Variable("", {
  poll: [1000, 'date "+%H:%M:%S %b %e."'],
})

// widgets can be only assigned as a child in one container
// so to make a reuseable widget, make it a function
// then you can simply instantiate one by calling it

function Workspaces() {
  const activeId = Hyprland.active.workspace.bind("id")
  const workspaces = Hyprland.bind("workspaces").as(ws =>
    ws
    .filter(({ id }) => id > 0)
    .sort(({ id: a }, { id: b }) => a - b)
    .map(({ id }) => Widget.Button({
      on_clicked: () => Hyprland.messageAsync(`dispatch workspace ${id}`),
      child: Widget.Label(`${id}`),
      class_name: activeId.as(i => `${i === id ? "focused" : ""}`),
    })))

  return Widget.Box({
    class_name: "workspaces",
    children: workspaces,
  })
}


function ClientTitle() {
  return Widget.Label({
    class_name: "client-title",
    label: Hyprland.active.client.bind("title"),
  })
}


function Clock() {
  return Widget.Label({
    class_name: "clock",
    label: date.bind(),
  })
}


// we don't need dunst or any other notification daemon
// because the Notifications module is a notification daemon itself
function Notification() {
  const popups = Notifications.bind("popups")
  return Widget.Box({
    class_name: "notification",
    visible: popups.as(p => p.length > 0),
    children: [
      Widget.Icon({
        icon: "preferences-system-notifications-symbolic",
      }),
      Widget.Label({
        label: popups.as(p => p[0]?.summary || ""),
      }),
    ],
  })
}


function Media() {
  const label = Utils.watch("", Mpris, "player-changed", () => {
    if (Mpris.players[0]) {
      const { track_artists, track_title } = Mpris.players[0]
      const artists = track_artists.join(", ")
      if (artists !== "" && track_title !== "") {
        return `${artists} - ${track_title}`
      }
    }

    return ""
  })

  return Widget.Button({
    class_name: "media",
    visible: label.as((l) => l !== ""),
    on_primary_click: () => Mpris.getPlayer("")?.playPause(),
    on_scroll_up: () => Mpris.getPlayer("")?.next(),
    on_scroll_down: () => Mpris.getPlayer("")?.previous(),
    child: Widget.Label({ label }),
  })
}


function Volume() {
  const icons = {
    101: "overamplified",
    67: "high",
    34: "medium",
    1: "low",
    0: "muted",
  }

  function getIcon() {
    const icon = Audio.speaker.is_muted ? 0 : [101, 67, 34, 1, 0].find(
      threshold => threshold <= Audio.speaker.volume * 100)

    return `audio-volume-${icons[icon]}-symbolic`
  }

  const icon = Widget.Icon({
    icon: Utils.watch(getIcon(), Audio.speaker, getIcon),
  })

  const slider = Widget.Slider({
    hexpand: true,
    draw_value: false,
    on_change: ({ value }) => Audio.speaker.volume = value,
    setup: self => self.hook(Audio.speaker, () => {
      self.value = Audio.speaker.volume || 0
    }),
  })

  return Widget.Box({
    class_name: "volume",
    css: "min-width: 180px",
    children: [icon, slider],
  })
}


function BatteryLabel() {
  const value = Battery.bind("percent").as(p => p > 0 ? p / 100 : 0)
  const icon = Battery.bind("percent").as(p =>
    `battery-level-${Math.floor(p / 10) * 10}-symbolic`)

  return Widget.Box({
    class_name: "battery",
    visible: Battery.bind("available"),
    children: [
      Widget.Icon({ icon }),
      Widget.LevelBar({
        widthRequest: 140,
        vpack: "center",
        value,
      }),
    ],
  })
}


function SysTray() {
  const items = Systemtray.bind("items")
  .as(items => items.map(item => Widget.Button({
    child: Widget.Icon({ icon: item.bind("icon") }),
    on_primary_click: (_, event) => item.activate(event),
    on_secondary_click: (_, event) => item.openMenu(event),
    tooltip_markup: item.bind("tooltip_markup"),
  })))

  return Widget.Box({
    children: items,
  })
}

function Left() {
  return Widget.Box({
    spacing: 8,
    children: [
      Workspaces(),
      ClientTitle(),
    ],
  })
}

function Center() {
  return Widget.Box({
    spacing: 8,
    children: [
      Media(),
      Notification(),
    ],
  })
}

function Right() {
  return Widget.Box({
    hpack: "end",
    spacing: 8,
    children: [
      Volume(),
      BatteryLabel(),
      Clock(),
      SysTray(),
    ],
  })
}


const Bar = () => Widget.CenterBox({
  start_widget: Left(),
  center_widget: Center(),
  end_widget: Right(),
  child: Widget.Revealer(),
})

const BarWindow = (/** @type {import('types/@girs/gdk-3.0/gdk-3.0').Gdk.Monitor} */ gdkmonitor) => Widget.Window({
  gdkmonitor,
  name: `bar${monitorCounter}`,
  class_name: "bar",
  anchor: ["top", "left", "right"],
  exclusivity: "exclusive",
  child: Bar()
});

export default BarWindow;
