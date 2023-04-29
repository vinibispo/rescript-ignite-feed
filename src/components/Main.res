type post = {
  id: int,
  author: Post.author,
  content: Post.contents,
  publishedAt: string,
}
type posts = array<post>
let fetchPosts = (_): Js.Promise.t<posts> =>
  Fetch.fetch("http://localhost:3333/posts", {})->Js.Promise2.then(Fetch.json)

@react.component
let make = () => {
  let queryResult = ReactQuery.useQuery({
    queryKey: ["posts"],
    queryFn: fetchPosts,
    refetchOnWindowFocus: ReactQuery.refetchOnWindowFocus(#bool(false)),
  })
  <main>
    {switch queryResult {
    | {isLoading: true} => <div> {"Loading..."->React.string} </div>
    | {data: Some(posts), isLoading: false, isError: false} =>
      posts->Render.map((post, _) =>
        <Post
          key={post.id->Belt.Int.toString}
          author={post.author}
          content={post.content}
          publishedAt={post.publishedAt}
        />
      )
    | _ => <div> {"Error"->React.string} </div>
    }}
  </main>
}
