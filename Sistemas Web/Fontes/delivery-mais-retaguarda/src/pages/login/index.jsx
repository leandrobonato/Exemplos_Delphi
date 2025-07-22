import {useNavigate} from 'react-router-dom';
import './style.css';
import Logo from '../../assets/logo.png';
import Fundo from '../../assets/fundo-login.jpg';

function Login(props){

    const navigate = useNavigate();

    function ProcessaLogin(){        
       navigate('/');
    }

    return <div className="row">
        <div className="col-sm-6 d-flex justify-content-center align-items-center text-center">
            <form className="form-login">
                <h3 className="mb-4">Administre seu delivery agora mesmo.</h3>
                <h6 className="mb-3">Acesse sua conta</h6>

                <div className="form-floating">
                    <input type="email" className="form-control" id="floatingInput" 
                            placeholder="E-mail" />
                    <label htmlFor="floatingInput">E-mail</label>
                </div>

                <div className="form-floating">
                    <input type="password" className="form-control" id="floatingInput" 
                            placeholder="Senha" />
                    <label htmlFor="floatingInput">Senha</label>
                </div>

                <button className="w-100 btn btn-lg btn-danger" onClick={ProcessaLogin}>
                    <span className="ms-2">Acessar</span>
                </button>

                <img className="mt-5" src={Logo} alt="Delivery Mais" />
            </form>
        </div>

        <div className="col-sm-6 px-0 d-none d-sm-block">
            <img className="background-login" src={Fundo} alt="Delivery Mais" />
        </div>
    </div>
    
}

export default Login;