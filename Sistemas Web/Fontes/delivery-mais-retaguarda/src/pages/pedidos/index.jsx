import Navbar from "../../components/navbar/index.jsx";
import Pedido from "../../components/pedido/index.jsx";

function Pedidos(){

    const pedidos = [{
        id_pedido: 524556,
        dt_pedido: "15/02/2021 19:00:01",
        status: "F",
        itens:[
            {id_item: 1, url_foto:"https://jornada-dev2.s3.amazonaws.com/xsalada.jpg", nome:"X-Salada", qtd: 2},
            {id_item: 2, url_foto:"https://jornada-dev2.s3.amazonaws.com/xtudo.png", nome:"X-Tudo", qtd: 1},
            {id_item: 3, url_foto:"https://jornada-dev2.s3.amazonaws.com/coca-cola.png", nome:"Coca-Cola", qtd: 3},
            {id_item: 4, url_foto:"https://jornada-dev2.s3.amazonaws.com/dog1.png", nome:"Hot-dog", qtd: 1},
            {id_item: 5, url_foto:"https://jornada-dev2.s3.amazonaws.com/xbacon.jpg", nome:"X-Bacon", qtd: 2},
            {id_item: 6, url_foto:"https://jornada-dev2.s3.amazonaws.com/xegg.jpg", nome:"X-Egg", qtd: 1}
            ]
    },
    {
        id_pedido: 52412,
        dt_pedido: "15/02/2021 19:10:30",
        status: "A",
        itens:[
            {id_item: 1, url_foto:"https://jornada-dev2.s3.amazonaws.com/xsalada.jpg", nome:"X-Salada", qtd: 2},
            {id_item: 2, url_foto:"https://jornada-dev2.s3.amazonaws.com/xtudo.png", nome:"X-Tudo", qtd: 1},
            {id_item: 3, url_foto:"https://jornada-dev2.s3.amazonaws.com/agua.png", nome:"Água", qtd: 3}
            ]
    },
    {
        id_pedido: 52455,
        dt_pedido: "15/02/2021 19:27:30",
        status: "P",
        itens:[
            {id_item: 1, url_foto:"https://jornada-dev2.s3.amazonaws.com/xsalada.jpg", nome:"X-Salada", qtd: 2},
            {id_item: 2, url_foto:"https://jornada-dev2.s3.amazonaws.com/xtudo.png", nome:"X-Tudo", qtd: 1}
            ]
    },
    {
        id_pedido: 52460,
        dt_pedido: "15/02/2021 19:29:55",
        status: "E",
        itens:[
            {id_item: 1, url_foto:"https://jornada-dev2.s3.amazonaws.com/xsalada.jpg", nome:"X-Salada", qtd: 2},
            {id_item: 2, url_foto:"https://jornada-dev2.s3.amazonaws.com/xtudo.png", nome:"X-Tudo", qtd: 1}
            ]
    }];

    return <>
        <Navbar />

        <div className="container-fluid mt-page">
            <div className="m-2 mt-4">
                <h2>Pedidos</h2>            
            </div> 

            <div className="row ms-0 me-1">

                {
                    pedidos.map(function (ped){
                        return <Pedido  key={ped.id_pedido}
                                        id_pedido={ped.id_pedido}
                                        dt_pedido="30/11/2022 17:30"
                                        vl_total="99"
                                        status="A"
                                        nome="Heber Mazutti"
                                        itens={ped.itens} 
                                        />
                    })
                    
                }
                
                

            </div>
        </div>
    </>
}

export default Pedidos;