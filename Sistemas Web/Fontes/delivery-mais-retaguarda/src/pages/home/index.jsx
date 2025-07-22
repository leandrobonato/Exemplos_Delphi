import Navbar from "../../components/navbar/index.jsx";

function Home(){

    const pedidos = [
        {id_pedido: 5420}, 
        {id_pedido: 5421}, 
        {id_pedido: 5422}, 
        {id_pedido: 5423}, 
        {id_pedido: 5424}, 
        {id_pedido: 5425},
        {id_pedido: 5426},
        {id_pedido: 5427},
        {id_pedido: 5428},
        {id_pedido: 5429},
        {id_pedido: 5430},
        {id_pedido: 5431}
    ];

    return <>
        <Navbar />
        
        <div className="container-fluid mt-page justify-content-between">
            <div className="m-2 mt-4">
                <h2>Dashboard</h2>            
            </div> 

            <div className="row">
                <div className="col-md-3">
                    <div className="card">
                        <div className="card-header">
                            Pedidos do Dia
                        </div>
                        <div className="card-body text-center">
                            <h2 className="card-title">27</h2>
                            <p className="card-text">R$ 650,00</p>
                        </div>
                    </div>
                </div>

                <div className="col-md-3">
                    <div className="card">
                        <div className="card-header">
                            Clientes Novos
                        </div>
                        <div className="card-body text-center">
                            <h2 className="card-title">03</h2>
                            <p className="card-text">(mês atual)</p>
                        </div>
                    </div>
                </div>
            </div>

            <div className="m-2 mt-5">
                <h2>Últimos Pedidos</h2>            
            </div> 

            <div className="row ms-3 me-3">
            <table className="table">
                <thead>
                    <tr>
                    <th scope="col">Pedido</th>
                    <th scope="col">Cliente</th>
                    <th scope="col">Status</th>
                    <th scope="col">Bairro</th>
                    <th scope="col">Valor Total</th>
                    </tr>
                </thead>
                <tbody>
                    {
                        pedidos.map(function (pedido){
                            return <tr>
                            <th scope="row">{pedido.id_pedido}</th>
                            <td>Heber Stein Mazutti</td>
                            <td>Aguardando</td>
                            <td>Bela Vista</td>
                            <td>R$ 112,00</td>
                            </tr>
                        })
                    }
                    
                </tbody>
            </table>
        </div>
        </div>
    </>
}

export default Home;