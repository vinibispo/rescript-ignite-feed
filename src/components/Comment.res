@module("./Comment.module.css") external styles: {..} = "default"
@react.component
let make = () => {
  <div className={styles["comment"]}>
    <Avatar hasBorder={false} src="https://github.com/vinibispo.png" />
    <div className={styles["commentBox"]}>
      <div className={styles["commentContent"]}>
        <header>
          <div className={styles["authorAndTime"]}>
            <strong> {"Vinícius Bispo"->React.string} </strong>
            <time title="27 de abril de 2023 às 18:18h" dateTime="2023-04-27 18:18:00">
              {"Cerca de 1h atrás"->React.string}
            </time>
          </div>
          <button title="Deletar comentário">
            <PhosphorReact.Trash size={#number(24)->PhosphorReact.size} />
          </button>
        </header>
        <p> {"Muito bom Devon, parabéns!! 👏👏"->React.string} </p>
      </div>
      <footer>
        <button>
          <PhosphorReact.ThumbsUp />
          {"Aplaudir"->React.string}
          <span> {20->React.int} </span>
        </button>
      </footer>
    </div>
  </div>
}
