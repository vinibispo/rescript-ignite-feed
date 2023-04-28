@module("./Avatar.module.css") external styles: {..} = "default"

@react.component
let make = (~src, ~hasBorder=true) => {
  <img src={src} className={hasBorder ? styles["avatarWithBorder"] : styles["avatar"]} />
}
