let str = React.string
%%raw("import './global.css'")
@module("./App.module.css") external styles: {..} = "default"

type post = {
  id: int,
  author: Post.author,
  content: Post.contents,
  publishedAt: Post.publishedAt,
}
type posts = array<post>
let posts = [
  {
    id: 1,
    author: {
      avatarUrl: "https://github.com/vinibispo.png",
      name: "Vinícius Bispo",
      role: "Full Stack Engineer",
    },
    content: [
      {
        type_: "paragraph",
        content: "Fala galera 👋",
      },
      {
        type_: "paragraph",
        content: "Acabei de subir mais um projeto no meu portifa. É um projeto que fiz no NLW Return, evento da Rocketseat. O nome do projeto é DoctorCare 🚀",
      },
      {
        type_: "link",
        content: "jane.design/doctorcare",
      },
    ],
    publishedAt: Js.Date.fromString("2023-04-27 18:18:00"),
  },
  {
    id: 2,
    author: {
      avatarUrl: "https://github.com/artiumdominus.png",
      name: "Pedro Basilio",
      role: "CEO at Void Corp.",
    },
    content: [
      {
        type_: "paragraph",
        content: "Fala galera 👋",
      },
      {
        type_: "paragraph",
        content: "Acabei de subir mais um projeto no meu portifa. É um projeto que fiz no NLW Return, evento da Rocketseat. O nome do projeto é DoctorCare 🚀",
      },
      {
        type_: "link",
        content: "jane.design/doctorcare",
      },
    ],
    publishedAt: Js.Date.fromString("2023-05-23 20:00:00"),
  },
]

@react.component
let make = () => {
  <React.Fragment>
    <Header />
    <div className={styles["wrapper"]}>
      <Sidebar />
      <main>
        {posts
        ->Belt.Array.map(post =>
          <Post
            key={post.id->Belt.Int.toString}
            author={post.author}
            content={post.content}
            publishedAt={post.publishedAt}
          />
        )
        ->React.array}
      </main>
    </div>
  </React.Fragment>
}
