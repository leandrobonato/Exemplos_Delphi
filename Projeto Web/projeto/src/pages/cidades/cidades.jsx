import { useState } from "react";
import api from "../../services/api.js";

function Cidades(){

    const [cidades, setCidades] = useState([]);
    
    function ListarCidades(){
        api.get("/v1/cidades")
        .then((response) => {
            //console.log(response.data);
            setCidades(response.data);
        })
        .catch(err => console.log(err))
    }

    return <>
    <h1>Cidades...</h1>
    <button type="button" onClick={ListarCidades}>Consultar Cidades</button>

    <ul>
    {        
        cidades.map((cidade) => {            
            return <li>{cidade.cidade} - {cidade.uf}</li>
        })        
    }
    </ul>

    </>    
}

export default Cidades;