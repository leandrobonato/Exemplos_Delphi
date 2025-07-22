import './App.css';
import dados from "./dados.json";
import DataTable from 'react-data-table-component';
import { useEffect, useState } from "react";
import axios from "axios";

function App() {

  const [toggledClearRows, setToggledClearRows] = useState(false);
  const [selectedRows, setSelectedRows] = useState([]);
  const [data, setData] = useState([]);
  const [totalRows, setTotalRows] = useState(0);
  const [loading, setLoading] = useState(false);

  const columns = [
    {
        name: 'Avatar',
        selector: row => <>
          <img src={row.avatar} className="img-avatar" />        
        </>,
    },
    {
        name: 'Código',
        selector: row => row.id,
        sortable: true
    },
    {
      name: 'Nome',
      selector: row => row.first_name + ' ' + row.last_name,
      sortable: true
    },
    {
      name: 'E-mail',
      selector: row => row.email,
   },
   {
    cell: (row) => <>
      <button onClick={() => clickEditar(row.id)} className="btn-editar">Editar</button>
      <button onClick={() => clickExcluir(row.id)} className="btn-excluir m-left">Excluir</button>
    </>,    
    width: "200px",
    right: true
   }
];

const paginationOptions = {
  rowsPerPageText: 'Registros por página',
  rangeSeparatorText: 'de',
  selectAllRowsItem: true,
  selectAllRowsItemText: 'Todos',
};


  function handleClearRows(){
    setToggledClearRows(!toggledClearRows);
  }

  function handleSelectedChange(selectedRows){
    setSelectedRows(selectedRows.selectedRows);
    //console.log(selectedRows.selectedRows);
  }

  function clickEditar(id){ 
    alert('Editar...' + id);
  }

  function clickExcluir(id){
    alert('Excluir...' + id);
  }

  function ListarUsuariosLocal(){
    setData(dados);
  }

  async function ListarUsuariosAPI(page){
    
    setLoading(true);
    setData(dados);

    const response = await axios.get("https://reqres.in/api/users?page=" + page + "&per_page=10&delay=2");

    /*
    const timeout = setTimeout(() => {
      setData(response.data.data);
      setTotalRows(response.data.total);
      setLoading(false);		
		}, 5000);
    */
   
    setData(response.data.data);
    setTotalRows(response.data.total);
    setLoading(false);		
    
  }

  async function handlePerRowsChange(newQtd, page){
    setLoading(true);
    setData(dados);

    const response = await axios.get("https://reqres.in/api/users?page=" + page + "&per_page=" + newQtd + "&delay=2");

    setData(response.data.data);
    setLoading(false);
  }

  useEffect(() => {

    //ListarUsuariosLocal();
    ListarUsuariosAPI(1);

    }, []);


/*
  // Arrow Function
  const handleClearRows = () => setToggledClearRows(!toggledClearRows);

  const handleClearRows = () => {
    setToggledClearRows(!toggledClearRows);
    alert('OK');
  }
*/  

  function handleExcluir(){
    
    selectedRows.map(selecao => {
      return console.log('Excluir o registro: ' + selecao.id);
    });    
    
  }

  function rowDisabled(row){
    return row.id == 3
  }

  function handlePageChange(page){  
    ListarUsuariosAPI(page);
  }

  return (
    <>
      <h1>Consulta de Usuários</h1>
      <button onClick={handleClearRows}>Limpar Seleção</button>
      <button onClick={handleExcluir} className="btn-excluir">Excluir</button>
      <DataTable columns={columns}
                 data={data}
                 selectableRows={true}
                 clearSelectedRows={toggledClearRows}
                 pagination={true}
                 paginationComponentOptions={paginationOptions}
                 onSelectedRowsChange={handleSelectedChange}
                 selectableRowDisabled={rowDisabled}
                 noDataComponent={"Nenhum registro encontrado"}
                 onChangeRowsPerPage={handlePerRowsChange}
                 onChangePage={handlePageChange}
                 paginationTotalRows={totalRows}
                 paginationServer={true}
                 fixedHeader={true}
                 progressPending={loading}
        />

    </>
  );
}

export default App;
