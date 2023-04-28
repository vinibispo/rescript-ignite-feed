@module("./Post.module.css") external styles: {..} = "default"


type author = {
  avatarUrl: string,
  name: string,
  role: string,
}

type content = {
  type_: string,
  content: string,
}


type publishedAt = Js.Date.t
type contents = array<content>

@react.component
let make = (~author, ~content, ~publishedAt: publishedAt) => {
  let publishedDateFormatted = RescriptCore.Intl.DateTimeFormat.makeWithLocaleAndOptions("pt-BR", {
      "day": "2-digit",
      "month": "long",
      "hour": "2-digit",
      "minute": "2-digit"
    } )->RescriptCore.Intl.DateTimeFormat.format(publishedAt)
  <article className={styles["post"]}>
    <header>
      <div className={styles["author"]}>
        <Avatar src={author.avatarUrl} />
        <div className={styles["authorInfo"]}>
          <strong> {author.name->React.string} </strong>
          <span> {author.role->React.string} </span>
        </div>
      </div>
      <time title="27 de abril de 2023 às 18:18h" dateTime={"2023-04-27 18:18:00"}>
        {publishedDateFormatted->React.string}
      </time>
    </header>
    <div className={styles["content"]}>
      {content->Belt.Array.map(c => {
          switch c {
          | {type_: "link", content: value} => <a href="">{value->React.string}</a>;
          | _ => <p>{c.content->React.string}</p>
          }
        })->React.array}
    </div>
    <form className={styles["commentForm"]}>
      <strong> {"Deixe seu feedback"->React.string} </strong>
      <textarea placeholder="Deixe um comentário" />
      <footer>
        <button type_="submit"> {"Publicar"->React.string} </button>
      </footer>
    </form>
    <div className={styles["commentList"]}>
      <Comment />
      <Comment />
      <Comment />
    </div>
  </article>
}
