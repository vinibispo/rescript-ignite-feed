type response
type fetchOptions = {
  method?: [
    | #GET
    | #POST
    | #PUT
    | #DELETE
    | #HEAD
    | #OPTIONS
    | #PATCH
  ],
  headers?: Js.Dict.t<string>,
  body?: string,
  mode?: [
    | #cors
    | #"no-cors"
    | #"same-origin"
  ],
  credentials?: [
    | #omit
    | #"same-origin"
    | #"include"
  ],
  cache?: [
    | #default
    | #"no-store"
    | #reload
    | #"no-cache"
    | #"force-cache"
    | #"only-if-cached"
  ],
  redirect?: [
    | #follow
    | #error
    | #manual
  ],
  signal?: AbortSignal.t,
}

@send external json: response => Js.Promise.t<'a> = "json"
@val external fetch: (string, fetchOptions) => Js.Promise.t<response> = "fetch"
