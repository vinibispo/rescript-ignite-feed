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
  let publishedDateFormatted = DateFns.format(~date=publishedAt, ~patterns="d 'de' LLLL 'às' HH:mm'h'", ~options={locale: DateFns.ptBR})

  let publishedDateRelativeToNow = DateFns.formatDistanceToNow(publishedAt, {
      locale: DateFns.ptBR,
      addSuffix: true
    })

  <article className={styles["post"]}>
    <header>
      <div className={styles["author"]}>
        <Avatar src={author.avatarUrl} />
        <div className={styles["authorInfo"]}>
          <strong> {author.name->React.string} </strong>
          <span> {author.role->React.string} </span>
        </div>
      </div>
      <time title={publishedDateFormatted} dateTime={publishedAt->Js.Date.toISOString}>
        {publishedDateRelativeToNow->React.string}
      </time>
    </header>
    <div className={styles["content"]}>
      {content->Belt.Array.mapWithIndex((i, c) => {
          <React.Fragment key={i->Belt.Int.toString}>
            {
              switch c {
              | {type_: "link", content: value} => <p><a href="">{value->React.string}</a></p>;
              | _ => <p>{c.content->React.string}</p>
              }
            }
          </React.Fragment>
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
