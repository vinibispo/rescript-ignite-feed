let _ = switch ReactDOM.querySelector("#root") {
| None => Js.log("Componente root não encontrado")
| Some(element) => {
    let root = ReactDOM.Client.createRoot(element)
    ReactDOM.Client.Root.render(
      root,
      <React.StrictMode>
        <App />
      </React.StrictMode>,
    )
  }
}
