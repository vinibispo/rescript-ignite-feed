let map = (elements, fn) => {
  elements->Js.Array2.mapi((item, index) => fn(item, index->Js.Int.toString))->React.array
}
