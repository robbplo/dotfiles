import { type MprisPlayer } from "types/service/mpris"
import PanelButton from "../PanelButton"
import options from "options"
import icons from "lib/icons"
import { icon } from "lib/utils"

const mpris = await Service.import("mpris")
const { length, direction, preferred, monochrome, format } = options.bar.media

const getPlayer = (name = preferred.value) =>
    mpris.getPlayer(name) || mpris.players[0] || null

const Content = (player: MprisPlayer) => {
    const label = Widget.Label({
        truncate: "end",
        max_width_chars: length.bind().as(n => n > 0 ? n : -1),
        setup: self => {
            let current = ""
            self.hook(player, () => {
                if (current === player.track_title)
                return

                current = player.track_title
            })
        },
        label: Utils.merge([
            player.bind("track_title"),
            player.bind("track_artists"),
            format.bind(),
        ], () => `${format}`
            .replace("{title}", player.track_title)
            .replace("{artists}", player.track_artists.join(", "))
            .replace("{artist}", player.track_artists[0] || "")
            .replace("{album}", player.track_album)
            .replace("{name}", player.name)
            .replace("{identity}", player.identity),
        ),
    })

    const playericon = Widget.Icon({
        icon: Utils.merge([player.bind("entry"), monochrome.bind()], (entry => {
            const name = `${entry}${monochrome.value ? "-symbolic" : ""}`
            return icon(name, icons.fallback.audio)
        })),
    })

    return Widget.Box({
        attribute: { label },
        children: direction.bind().as(d => d === "right"
            ? [playericon, label] : [label, playericon]),
    })
}

export default () => {
    let player = getPlayer()

    let icon = Widget.Icon(icons.fallback.audio)
    const btn = PanelButton({
        class_name: "media",
        child: icon,
    })

    const update = () => {
        player = getPlayer()
        btn.visible = !!player

        if (!player)
            return

        const content = Content(player)
        const { label } = content.attribute
        btn.child = content
        btn.on_primary_click = () => { player.playPause() }
        btn.on_secondary_click = () => { player.playPause() }
        btn.on_scroll_up = () => { player.next() }
        btn.on_scroll_down = () => { player.previous() }
    }

    return btn
        .hook(preferred, update)
        .hook(mpris, update, "notify::players")
}
