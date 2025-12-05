import React from 'react';
import { Page } from '../../App';
import { AlertIcon, MoneyIcon, GavelIcon } from '../components/Icons';
import { ArrowRight, ShieldCheck } from 'lucide-react';
import diagram from '../assets/aurix_hero.png';

interface HomeProps {
  onNavigate: (page: Page) => void;
}

export const Home: React.FC<HomeProps> = ({ onNavigate }) => {
  return (
    <div className="w-full">
      {/* Hero Section */}
      <section className="relative overflow-hidden bg-gradient-to-br from-slate-50 via-blue-50 to-green-50 pt-32 pb-48">
        
        {/* Background decorative blobs */}
        <div className="absolute top-0 right-0 w-[800px] h-[800px] bg-blue-200/20 rounded-full blur-3xl -translate-y-1/2 translate-x-1/3"></div>
        <div className="absolute bottom-0 left-0 w-[600px] h-[600px] bg-green-200/20 rounded-full blur-3xl translate-y-1/3 -translate-x-1/4"></div>

        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 relative z-10">
          <div className="flex flex-col lg:flex-row items-center gap-12 lg:gap-20">
            
            <div className="w-full lg:w-1/2 text-center lg:text-left">
              <div className="inline-flex items-center gap-2 bg-white px-4 py-2 rounded-full shadow-sm mb-6 border border-blue-100">
                <span className="flex h-2 w-2 rounded-full bg-aurix-green"></span>
                <span className="text-sm font-semibold text-aurix-dark tracking-wide">Tecnología Agrícola Chilena</span>
              </div>
              
              <h1 className="text-5xl lg:text-7xl font-heading font-extrabold text-aurix-dark mb-6 leading-[1.1]">
                Cultivos sanos,<br/>
                <span className="text-transparent bg-clip-text bg-gradient-to-r from-aurix-blue to-aurix-green">
                  Futuro seguro
                </span>
              </h1>
              
              <p className="text-lg lg:text-xl text-slate-600 mb-8 leading-relaxed max-w-lg mx-auto lg:mx-0">
                Protege tu inversión agrícola removiendo pesticidas y nitratos del agua de riego con nuestra tecnología de filtración inteligente.
              </p>

              <div className="flex flex-col sm:flex-row items-center justify-center lg:justify-start gap-4">
                <button 
                  onClick={() => onNavigate('producto')}
                  className="w-full sm:w-auto bg-aurix-dark hover:bg-slate-800 text-white font-bold py-4 px-8 rounded-full shadow-soft hover:shadow-lg transform transition hover:-translate-y-1 flex items-center justify-center gap-2 group"
                >
                  Ver Soluciones
                  <ArrowRight size={20} className="group-hover:translate-x-1 transition-transform" />
                </button>
                <button 
                  onClick={() => onNavigate('monitoreo')}
                  className="w-full sm:w-auto bg-white hover:bg-gray-50 text-aurix-dark border-2 border-slate-200 font-bold py-3.5 px-8 rounded-full transition"
                >
                  Ver Demo App
                </button>
              </div>

              <div className="mt-10 grid grid-cols-3 gap-4 border-t border-slate-200 pt-8">
                <div>
                  <p className="font-heading font-bold text-3xl text-aurix-blue">Mejora</p>
                  <p className="text-xs text-slate-500 font-bold uppercase mt-1">Firmeza del fruto</p>
                </div>
                <div>
                  <p className="font-heading font-bold text-3xl text-aurix-green">24/7</p>
                  <p className="text-xs text-slate-500 font-bold uppercase mt-1">Monitoreo IoT</p>
                </div>
                <div>
                  <p className="font-heading font-bold text-3xl text-aurix-dark">Previene</p>
                  <p className="text-xs text-slate-500 font-bold uppercase mt-1">Futuros Incidentes</p>
                </div>
              </div>
            </div>

             <div className="w-full lg:w-1/2 relative">
               <div className="relative z-10 rounded-[3rem] overflow-hidden shadow-2xl border-8 border-white transform rotate-2 hover:rotate-0 transition duration-500">
                 <img 
                   src={diagram}
                   alt="Campo chileno limpio" 
                   className="w-full h-[500px] object-cover"
                 />
                 <div className="absolute inset-0 bg-gradient-to-t from-aurix-dark/80 via-transparent to-transparent"></div>
                 
                 <div className="absolute bottom-8 left-8 right-8 text-white">
                    <div className="flex items-center gap-3 mb-2">
                        <div className="bg-aurix-green p-2 rounded-lg">
                            <ShieldCheck size={24} className="text-white" />
                        </div>
                        <span className="font-heading font-bold text-lg">Protección Activa</span>
                    </div>
                    <p className="text-sm text-slate-200">Sistema Aurix operando en tiempo real.</p>
                 </div>
               </div>

               {/* Decorative floating elements */}
               <div className="absolute -top-10 -right-10 bg-white p-4 rounded-2xl shadow-xl">
                  <span className="text-4xl">🌱</span>
               </div>
            </div>
          </div>
        </div>
        
        {/* Organic Wave Divider */}
        <div className="absolute bottom-0 w-full leading-none">
          <svg className="w-full h-24 lg:h-48 text-white" viewBox="0 0 1440 320" preserveAspectRatio="none" fill="currentColor">
            <path d="M0,96L48,112C96,128,192,160,288,160C384,160,480,128,576,112C672,96,768,96,864,112C960,128,1056,160,1152,165.3C1248,171,1344,149,1392,138.7L1440,128L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z"></path>
          </svg>
        </div>
      </section>

      {/* Problem Section*/}
      <section className="bg-white py-20 lg:py-32">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="text-center mb-20">
            <span className="text-aurix-blue font-bold tracking-wider uppercase text-sm">La realidad del agro</span>
            <h2 className="text-4xl md:text-5xl font-heading font-bold mt-2 text-slate-900">
              Un problema silencioso en Chile
            </h2>
            <div className="w-24 h-1 bg-aurix-green mx-auto mt-6 rounded-full"></div>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-3 gap-10">
            {/* Card 1 */}
            <div className="group bg-slate-50 p-10 rounded-[2.5rem] hover:bg-white hover:shadow-2xl transition duration-500 border border-slate-100 hover:border-aurix-blue/20">
              <div className="mb-6 transform group-hover:scale-110 transition duration-300">
                <MoneyIcon />
              </div>
              <h3 className="text-2xl font-heading font-bold text-slate-800 mb-4 leading-tight">Pérdida de <br/><span className="text-aurix-blue">Inversión</span></h3>
              <p className="text-slate-600 leading-relaxed">
                Cada año, <strong>más del 40%</strong> del fertilizante que compras se escapa por escorrentía. Estás tirando dinero al agua.
              </p>
            </div>

            {/* Card 2 */}
            <div className="group bg-slate-50 p-10 rounded-[2.5rem] hover:bg-white hover:shadow-2xl transition duration-500 border border-slate-100 hover:border-red-200 relative overflow-hidden">
              <div className="absolute top-0 right-0 w-24 h-24 bg-red-100 rounded-bl-[4rem] -mr-4 -mt-4 z-0"></div>
              <div className="relative z-10">
                <div className="mb-6 transform group-hover:scale-110 transition duration-300">
                    <AlertIcon />
                </div>
                <h3 className="text-2xl font-heading font-bold text-slate-800 mb-4 leading-tight">Riesgo <br/><span className="text-red-500">Crítico</span></h3>
                <p className="text-slate-600 leading-relaxed">
                    El agua contaminada con glifosato daña irreversiblemente cerezas, paltas y avellanos. Una cosecha perdida cuesta millones.
                </p>
              </div>
            </div>

            {/* Card 3 */}
            <div className="group bg-slate-50 p-10 rounded-[2.5rem] hover:bg-white hover:shadow-2xl transition duration-500 border border-slate-100 hover:border-aurix-green/20">
              <div className="mb-6 transform group-hover:scale-110 transition duration-300">
                <GavelIcon />
              </div>
              <h3 className="text-2xl font-heading font-bold text-slate-800 mb-4 leading-tight">Multas <br/><span className="text-aurix-green">Millonarias</span></h3>
              <p className="text-slate-600 leading-relaxed">
                La SMA está sancionando fuertemente. Una multa puede alcanzar los <strong>$150 millones</strong> por contaminación de canales.
              </p>
            </div>
          </div>
        </div>
      </section>
    </div>
  );
};