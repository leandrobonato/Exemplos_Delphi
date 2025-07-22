import {Link} from "react-router-dom";
import "./clientes.css";

function Clientes(){
    return <>
        <h1>Listagem dos clientes...</h1>
        <Link to="/" className="btn-voltar">Voltar</Link>
    </>
}

export default Clientes;