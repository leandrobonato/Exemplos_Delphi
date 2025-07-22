import './style.css';

function Pedido(props){
    return <div className="d-flex justify-content-between shadow-sm pedido">
            <div>
                <span><b>Pedido #{props.id_pedido}</b></span>
                <span className="badge rounded-pill bg-secondary ms-3">{props.dt_pedido}</span>
                <span className="badge rounded-pill bg-danger ms-3">Aguardando</span>

                <small className="d-block mt-1 text-secondary">Heber Mazutti - Av. Paulista, 1520 - 
                    {new Intl.NumberFormat('pt-BR', {style: 'currency', currency: 'BRL'}).format(props.vl_total)}
                </small>

                {
                    props.itens.map(function (item){
                        return <div key={item.id_item} className="d-inline-block text-center me-4 mt-2">
                                <img src={item.url_foto} className="foto-item" alt={item.nome} />
                                <small className="d-block text-secondary">{item.qtd.toLocaleString('pt-BR', {minimumIntegerDigits: 2})} x</small>
                                <small className="d-block text-secondary">{item.nome}</small>
                            </div>  
                    })
                }
            </div>

            <div className="d-flex align-items-center me-4">
                <div className="dropdown">
                    <a className="btn btn-secondary dropdown-toggle" href="#" role="button" id={`dropdownMenuLink${props.id_pedido}`} 
                        data-bs-toggle="dropdown" aria-expanded="false">                    
                        Status
                    </a>                
                    <ul className="dropdown-menu" aria-labelledby={`dropdownMenuLink${props.id_pedido}`}>
                        <li><a className="dropdown-item" >Aguardando</a></li>
                        <li><hr className="dropdown-divider" /></li>
                        <li><a className="dropdown-item" >Em produção</a></li>
                        <li><a className="dropdown-item" >Saiu entrega</a></li>
                        <li><hr className="dropdown-divider" /></li>
                        <li><a className="dropdown-item" >Finalizar</a></li>
                    </ul>
                </div>            
            </div>
        </div>
}

export default Pedido;