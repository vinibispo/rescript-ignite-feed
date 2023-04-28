@module("./Sidebar.module.css") external styles: {..} = "default"
@react.component
let make = () => {
  <aside className={styles["sidebar"]}>
    <img
      className={styles["cover"]}
      src="https://images.unsplash.com/photo-1605379399642-870262d3d051?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=50"
    />
    <div className={styles["profile"]}>
      <Avatar src="https://github.com/vinibispo.png" />
      <strong> {"Vinícius Bispo"->React.string} </strong>
      <span> {"Full Stack Engineer"->React.string} </span>
    </div>
    <footer>
      <a href="#">
        <PhosphorReact.PencilLine size={#number(20)->PhosphorReact.size} />
        {"Editar seu perfil"->React.string}
      </a>
    </footer>
  </aside>
}
