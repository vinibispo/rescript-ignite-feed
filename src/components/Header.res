@module external styles: {..} = "./Header.module.css"

@module("../assets/ignite-logo.svg") external igniteLogo: string = "default"

@react.component
let make = () => {
  <header className={styles["header"]}>
    <img src=igniteLogo alt="" />
  </header>
}
