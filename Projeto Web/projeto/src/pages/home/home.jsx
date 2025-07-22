import React, {useState} from 'react';
import Teste from "../../components/teste/teste.jsx";

function Home(){
    
    const [valor, FuncAlteraValor] = useState(100);
    const [pedidos, FuncAlteraPedidos] = useState([]);
    const [texto, setTexto] = useState("");


    function Somar(){    

    /*
    const valores = [1, 5, 7];
    var v1 = valores[0];
    var v2 = valores[1];
    var v3 = valores[2];
    */

    //const [v1, v2, v3] = [1, 5, 7];

    FuncAlteraValor(valor + 1);
        //console.log(valor);  
    }

    function Subtrair(){            
        FuncAlteraValor(valor - 1);            
    }

    function ConsultarPedidos(){
        
        // Get no servidor...
        FuncAlteraPedidos([
            {id_pedido: 1000, cliente: "Heber"},
            {id_pedido: 5200, cliente: "João"},
            {id_pedido: 7400, cliente: "Maria"}
        ]);
    }

    function ConsultarMaisPedidos(){
        
        // Get no servidor...
        FuncAlteraPedidos([
            {id_pedido: 2000, cliente: "Ana"},
            {id_pedido: 3000, cliente: "Joana"},
            {id_pedido: 4000, cliente: "Alberto"}
        ]);
    }

   

/*    const multiplar = function (valor){        
        alert('OK');
        return valor * 2;        
    }
    */

    const multiplicar = (vl) => FuncAlteraValor(vl * 2);


/*    function Multiplar(valor){        
        return valor * 2;        
    }
    */
    


    return <>    
    <span>Instagram: @99coders</span>
    <h1>{valor}</h1>    
    <input type="text" onChange={(e) => setTexto(e.target.value)} />
    <Teste texto="Testando..." />
    <button type="button" onClick={Somar}>+</button>  
    <button type="button" onClick={Subtrair}>-</button>  
    <button type="button" onClick={(e) => multiplicar(texto)}>X</button>  
    <button type="button" onClick={ConsultarPedidos}>Consultar</button>      
    <br /><br />
    <span><b>Pedidos</b></span><br />

        {
            pedidos.map(function(ped){
                return <>
                    <small>Pedido: {ped.id_pedido} - Cliente: {ped.cliente}</small><br />
                </>
            })
        }        
    
    </>
}

export default Home;