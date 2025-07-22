import Logo from '../../assets/logo2.png';

function Navbar(){
    return <nav className="navbar fixed-top navbar-expand-lg navbar-dark bg-danger ps-3 pe-3">
    <div className="container-fluid">
        <a className="navbar-brand" href="/"><img className="mt-1" src={Logo} /></a>
        
        <button className="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span className="navbar-toggler-icon"></span>
        </button>

        <div className="collapse navbar-collapse" id="navbarSupportedContent">
                                        
            <ul className="navbar-nav me-auto mb-2 mb-lg-0">
                <li className="nav-item">
                <a className="btn btn-outline-light me-3" aria-current="page" href="/"><i className="fas fa-home"></i>Início</a>
                </li>
                <li className="nav-item">
                <a className="btn btn-outline-light me-3" href="/pedidos"><i className="fas fa-utensils"></i>Acompanhar Pedidos</a>
                </li>
                <li className="nav-item">
                <a className="btn btn-outline-light me-3" href="/cardapio"><i className="fas fa-bars"></i>Cardápio</a>
                </li>
            </ul>

            <div className="btn-group">
                <button type="button" className="btn btn-outline-light me-3 dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
                    <i className="fas fa-user"></i>Heber Mazutti
                </button>
                <ul className="dropdown-menu dropdown-menu-end">                    
                    <li><a href="/#" className="dropdown-item">Meus Perfil</a></li>
                    <li><a href="/#" className="dropdown-item">Estabelecimento</a></li>
                    <li><hr className="dropdown-divider" /></li>
                    <li><a href="/login" className="dropdown-item">Sair</a></li>
                </ul>
            </div>

            

        </div>
    </div>
</nav>
}

export default Navbar;