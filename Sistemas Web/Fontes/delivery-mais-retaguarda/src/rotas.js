import {BrowserRouter, Route, Routes} from 'react-router-dom';
import Home from './pages/home/index.jsx';
import Pedidos from './pages/pedidos/index.jsx';
import Login from './pages/login/index.jsx';

function Rotas(){
    return <BrowserRouter>
        <Routes>
            <Route path="/" element={<Home />} />
            <Route path="/login" element={<Login />} />
            <Route path="/pedidos" element={<Pedidos />} />
        </Routes>
    </BrowserRouter>    
}

export default Rotas;