@module("./Comment.module.css") external styles: {..} = "default"
@react.component
let make = (~content, ~onDeleteComment, ~id) => {
  let handleDeleteComment = () => {
    onDeleteComment(id)
  }

  let (openModal, setOpenModal) = React.useState(_ => false)

  let handleOpenModal = () => {
    setOpenModal(_ => true)
  }
  let handleCloseModal = () => {
    setOpenModal(_ => false)
  }

  let (likeCount, setLikeCount) = React.useState(_ => 0)
  let handleLikeComment = _ => {
    setLikeCount(like => like + 1)
  }
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
          <button onClick={_ => handleOpenModal()} title="Deletar comentário">
            <PhosphorReact.Trash size={#number(24)->PhosphorReact.size} />
          </button>
          <Modal
            isOpen={openModal}
            onClose={_ => handleCloseModal()}
            onDeleteComment={_ => handleDeleteComment()}
          />
        </header>
        <p> {content->React.string} </p>
      </div>
      <footer>
        <button onClick={handleLikeComment}>
          <PhosphorReact.ThumbsUp />
          {"Aplaudir"->React.string}
          <span> {likeCount->React.int} </span>
        </button>
      </footer>
    </div>
  </div>
}
