type locale
type options = {locale: locale, addSuffix?: bool}
@module("date-fns/format")
external format: (~date: Js.Date.t, ~patterns: string, ~options: options) => string = "default"

@module("date-fns/formatDistanceToNow")
external formatDistanceToNow: (Js.Date.t, options) => string = "default"

@module("date-fns/locale/pt-BR") external ptBR: locale = "default"
