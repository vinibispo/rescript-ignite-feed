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

type comment = {
  body: string,
  id: int,
  postId: int,
}

type contents = array<content>

type commentData = {
  text: string,
  id: int,
}

let fetchComments = (id): Js.Promise.t<array<comment>> => {
  let headers = Js.Dict.fromList(list{("Content-Type", "application/json")})

  Fetch.fetch(`http://localhost:3333/comments?postId=${id}`, { headers: headers })->Js.Promise2.then(Fetch.json)
}

let addComments = (~id, ~text) => {
  let headers = Js.Dict.fromList(list{("Content-Type", "application/json")})
  let body = {"body": text, "postId": id}->Js.Json.stringifyAny
  switch body {
  | Some(body) =>
    Fetch.fetch(
      `http://localhost:3333/comments`,
      {
        method: #POST,
        body,
        headers,
      },
    )->Js.Promise2.then(Fetch.json)
  | None => Js.Promise2.reject(Js.Exn.raiseError("Error converting json"))
  }
}

let removeComment = id => {
  Fetch.fetch(
    `http://localhost:3333/comments/${id->string_of_int}`,
    {
      method: #DELETE,
    },
  )->Js.Promise2.then(Fetch.json)
}

@react.component
let make = (~author, ~content, ~publishedAt, ~id) => {
  let publishedAtDate = publishedAt->Js.Date.fromString
  let publishedDateFormatted = DateFns.format(
    ~date=publishedAtDate,
    ~patterns="d 'de' LLLL 'às' HH:mm'h'",
    ~options={locale: DateFns.ptBR},
  )

  let publishedDateRelativeToNow = DateFns.formatDistanceToNow(
    publishedAtDate,
    {
      locale: DateFns.ptBR,
      addSuffix: true,
    },
  )

  let queryResult = ReactQuery.useQuery({
    queryKey: ["comments", id->string_of_int],
    queryFn: _ => fetchComments(id->string_of_int),
    refetchOnWindowFocus: ReactQuery.refetchOnWindowFocus(#bool(false)),
  })

  let (newCommentText, setNewCommentText) = React.useState(_ => "")

  let {mutate: mutateAdd} = ReactQuery.useMutation(
    ReactQuery.mutationOptions(
      ~mutationKey=["comments", id->string_of_int],
      ~mutationFn=mutateData => {
        let {id, text} = mutateData
        addComments(~id, ~text)
      },
      ~onSuccess=(_, _variables, _context) => {
        queryResult.refetch({
          throwOnError: true,
          cancelRefetch: false,
        })
      },
      (),
    ),
  )

  let {mutate: mutateRemove} = ReactQuery.useMutation(
    ReactQuery.mutationOptions(
      ~mutationKey=["comments", id->string_of_int],
      ~mutationFn=id => {
        removeComment(id)
      },
      ~onSuccess=(_, _variables, _context) => {
        queryResult.refetch({
          throwOnError: true,
          cancelRefetch: false,
        })
      },
      (),
    ),
  )

  let handleCreateNewComment = e => {
    ReactEvent.Synthetic.preventDefault(e)
    mutateAdd(. {id, text: newCommentText}, None)

    setNewCommentText(_ => "")
  }

  let handleChangeNewTextAreaText = e => {
    let targetElement = e->ReactEvent.Synthetic.target
    targetElement["setCustomValidity"](. "")->ignore
    let value = targetElement["value"]
    setNewCommentText(_ => value)
  }

  let handleNewCommentInvalid = e => {
    let targetElement = e->ReactEvent.Synthetic.target
    targetElement["setCustomValidity"](. "Esse campo é obrigatório")
  }

  let deleteComment = id => {
    mutateRemove(. id, None)
  }

  let isNewCommentEmpty = newCommentText->String.length == 0

  <article className={styles["post"]}>
    <header>
      <div className={styles["author"]}>
        <Avatar src={author.avatarUrl} />
        <div className={styles["authorInfo"]}>
          <strong> {author.name->React.string} </strong>
          <span> {author.role->React.string} </span>
        </div>
      </div>
      <time title={publishedDateFormatted} dateTime={publishedAtDate->Js.Date.toISOString}>
        {publishedDateRelativeToNow->React.string}
      </time>
    </header>
    <div className={styles["content"]}>
      {content->Render.map((c, _) => {
        switch c {
        | {type_: "link", content: value} =>
          <p key={value}>
            <a href=""> {value->React.string} </a>
          </p>
        | {type_: _, content: value} => <p key={value}> {value->React.string} </p>
        }
      })}
    </div>
    <form className={styles["commentForm"]} onSubmit={handleCreateNewComment}>
      <strong> {"Deixe seu feedback"->React.string} </strong>
      <textarea
        name="comment"
        placeholder="Deixe um comentário"
        value={newCommentText}
        onChange={handleChangeNewTextAreaText}
        onInvalid={handleNewCommentInvalid}
        required={true}
      />
      <footer>
        <button type_="submit" disabled={isNewCommentEmpty}> {"Publicar"->React.string} </button>
      </footer>
    </form>
    <div className={styles["commentList"]}>
      {switch queryResult {
      | {isLoading: true} => "Loading"->React.string
      | {isLoading: false, isError: false, data: Some(comments)} =>
        comments->Render.map(({id, body}, _) =>
          <Comment
            onDeleteComment={deleteComment}
            key={id->Belt.Int.toString}
            content={body}
            id={id}
          />
        )
      | _ => "Error"->React.string
      }}
    </div>
  </article>
}
