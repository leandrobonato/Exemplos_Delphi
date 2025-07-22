import { BrowserRouter, Route, Routes } from "react-router-dom";
import Home from "./pages/home/home.jsx";
import Clientes from "./pages/clientes/clientes.jsx";
import Cidades from "./pages/cidades/cidades.jsx";

function Rotas(){
    return <BrowserRouter>
        <Routes>
            <Route path="/" element={<Home />} />
            <Route path="/clientes" element={<Clientes />} />
            <Route path="/cidades" element={<Cidades />} />
        </Routes>
    </BrowserRouter>
}

export default Rotas;