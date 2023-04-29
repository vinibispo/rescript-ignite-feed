let str = React.string
%%raw("import './global.css'")
@module("./App.module.css") external styles: {..} = "default"

let client = ReactQuery.Provider.createClient()

@react.component
let make = () => {
  <ReactQuery.Provider client>
    <Header />
    <div className={styles["wrapper"]}>
      <Sidebar />
      <Main />
    </div>
  </ReactQuery.Provider>
}
