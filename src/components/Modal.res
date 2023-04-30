@module("./Modal.module.css") external styles: {..} = "default"
@react.component
let make = (~onClose, ~isOpen, ~onDeleteComment) => {
  switch isOpen {
  | true => <div className={styles["overlay"]}>
      <div className={styles["modalContainer"]}>
        <div className={styles["content"]}>
          <div />
          <PhosphorReact.X size={#number(24)->PhosphorReact.size} onClick={onClose} />
        </div>
        <div className={styles["titleModal"]}>
          <h3> {"Excluir comentário"->React.string} </h3>
        </div>
        <div className={styles["subTitle"]}>
          <div>
            <p> {"Você tem certeza que gostaria de excluir este comentário?"->React.string} </p>
          </div>
        </div>
        <div className={styles["modalBtn"]}>
          <button onClick={onClose}> {"Cancelar"->React.string} </button>
          <button
          onClick={onDeleteComment}
          >
            {"Sim, excluir"->React.string}
          </button>
        </div>
      </div>
    </div>
  | _ => React.null
  }
}
