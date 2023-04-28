type size = [#string(string) | #number(int)]
type weight = [
  | #thin
  | #light
  | #regular
  | #bold
  | #fill
  | #duotone
]
type props = {
  color?: string,
  size?: size,
  weight?: weight,
  mirrored?: bool,
  alt?: string,
}
let size = s =>
  switch s {
  | #string(value) => Obj.magic(value)
  | #number(value) => Obj.magic(value)
  }
module PencilLine = {
  @module("@phosphor-icons/react") external make: React.component<props> = "PencilLine"
}

module Trash = {
  @module("@phosphor-icons/react") external make: React.component<props> = "Trash"
}

module ThumbsUp = {
  @module("@phosphor-icons/react") external make: React.component<props> = "ThumbsUp"
}
