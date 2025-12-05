import React from 'react';
import { CheckIcon } from '../components/Icons';
import { ShieldCheck, Filter, Activity, Check } from 'lucide-react';
import agriculture from '../assets/agriculture.avif';

export const Product: React.FC = () => {
  return (
    <div className="w-full bg-slate-50">
      
      {/* Intro Section */}
      <section className="pt-32 pb-20 max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex flex-col lg:flex-row items-center gap-16">
          <div className="w-full lg:w-1/2">
             <div className="relative">
                <div className="absolute -inset-4 bg-gradient-to-r from-aurix-blue to-aurix-green rounded-[3rem] opacity-30 blur-lg"></div>
                <img 
                 src={agriculture}
                 className="relative rounded-[2.5rem] w-full shadow-2xl z-10 border-4 border-white"
                 alt="Agricultura"
               />
               <div className="absolute -bottom-6 -right-6 z-20 bg-white p-6 rounded-3xl shadow-xl">
                  <div className="flex items-center gap-3">
                    <span className="text-4xl">💧</span>
                    <div>
                        <p className="font-bold text-aurix-dark">Agua Pura</p>
                        <p className="text-xs text-slate-500">Garantizada</p>
                    </div>
                  </div>
               </div>
             </div>
          </div>
          
          <div className="w-full lg:w-1/2">
            <span className="text-aurix-green font-bold tracking-wider uppercase text-sm mb-2 block">Nuestra Tecnología</span>
            <h2 className="text-4xl md:text-5xl font-heading font-bold text-aurix-dark mb-6">La protección total a tus cultivos</h2>
            
            <p className="text-slate-600 text-lg mb-6 leading-relaxed">
              Aurix no es solo un filtro; es un sistema integral de defensa para la agricultura de exportación. Diseñado por ingenieros chilenos para la realidad de nuestros campos.
            </p>
            <p className="text-slate-600 text-lg mb-8 leading-relaxed">
              Nuestra tecnología se acopla a tu infraestructura actual, removiendo contaminantes críticos (glifosato, nitratos) antes de que toquen tus raíces.
            </p>

            <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
                <div className="flex items-center gap-3 bg-white p-4 rounded-xl shadow-sm border border-slate-100">
                    <ShieldCheck className="text-aurix-blue" size={24} />
                    <span className="font-bold text-slate-700">Filtración Certificada</span>
                </div>
                <div className="flex items-center gap-3 bg-white p-4 rounded-xl shadow-sm border border-slate-100">
                    <Activity className="text-aurix-green" size={24} />
                    <span className="font-bold text-slate-700">Monitoreo IoT 24/7</span>
                </div>
            </div>
          </div>
        </div>
      </section>

      {/* Features Grid */}
      <section className="py-20 bg-white relative">
         <div className="absolute top-0 left-0 w-full h-full bg-[radial-gradient(#e5e7eb_1px,transparent_1px)] [background-size:16px_16px] opacity-30"></div>
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 relative z-10">
          <div className="text-center max-w-3xl mx-auto mb-16">
            <h2 className="text-3xl font-heading font-bold text-aurix-dark mb-4">Características Principales</h2>
            <p className="text-slate-500">Todo lo que necesitas para asegurar tu producción.</p>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
            {/* Feature 1 */}
            <div className="bg-slate-50 p-8 rounded-3xl transition-all duration-300 hover:shadow-soft hover:-translate-y-1 group">
              <div className="w-14 h-14 bg-blue-100 rounded-2xl flex items-center justify-center mb-6 group-hover:bg-aurix-blue transition-colors">
                 <Filter className="text-aurix-blue group-hover:text-white transition-colors" size={28} />
              </div>
              <h3 className="text-xl font-heading font-bold text-slate-800 mb-3">Filtración Avanzada</h3>
              <p className="text-slate-600 leading-relaxed">
                Remueve glifosato, herbicidas y nitratos. Protege cerezas, paltas y avellanos de contaminantes peligrosos.
              </p>
            </div>

            {/* Feature 2 */}
            <div className="bg-slate-50 p-8 rounded-3xl transition-all duration-300 hover:shadow-soft hover:-translate-y-1 group">
              <div className="w-14 h-14 bg-green-100 rounded-2xl flex items-center justify-center mb-6 group-hover:bg-aurix-green transition-colors">
                 <CheckIcon className="text-aurix-green group-hover:text-white transition-colors" />
              </div>
              <h3 className="text-xl font-heading font-bold text-slate-800 mb-3">Fácil Instalación</h3>
              <p className="text-slate-600 leading-relaxed">
                Se acopla a tus filtros existentes. Sin obras civiles complejas, sin detener tu producción agrícola.
              </p>
            </div>

            {/* Feature 3 */}
            <div className="bg-slate-50 p-8 rounded-3xl transition-all duration-300 hover:shadow-soft hover:-translate-y-1 group">
               <div className="w-14 h-14 bg-indigo-100 rounded-2xl flex items-center justify-center mb-6 group-hover:bg-indigo-500 transition-colors">
                 <Activity className="text-indigo-600 group-hover:text-white transition-colors" size={28} />
              </div>
              <h3 className="text-xl font-heading font-bold text-slate-800 mb-3">Control Total</h3>
              <p className="text-slate-600 leading-relaxed">
                Monitoreo en tiempo real con alertas a tu celular. Reportes listos para exportadoras y auditorías.
              </p>
            </div>
          </div>
        </div>
      </section>

      {/* Plans Section - Two Plans */}
      <section className="py-24 bg-aurix-dark relative overflow-hidden">
         {/* Background Decoration */}
         <div className="absolute -top-40 -right-40 w-96 h-96 bg-aurix-blue/20 rounded-full blur-[100px]"></div>
         <div className="absolute -bottom-40 -left-40 w-96 h-96 bg-aurix-green/20 rounded-full blur-[100px]"></div>

        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 relative z-10">
          <div className="text-center mb-16">
            <h2 className="text-4xl md:text-5xl font-heading font-bold text-white mb-4">Planes Simples</h2>
            <p className="text-slate-300 max-w-2xl mx-auto">Elige la protección adecuada para el tamaño de tu producción.</p>
          </div>
          
          <div className="grid grid-cols-1 md:grid-cols-2 gap-8 max-w-4xl mx-auto">
             
             {/* Plan Básico */}
             <div className="bg-white rounded-3xl p-8 lg:p-12 border border-slate-200 flex flex-col relative overflow-hidden group">
                <div className="mb-6">
                   <h3 className="text-slate-500 font-bold tracking-widest uppercase text-sm mb-2">Plan Inicial</h3>
                   <div className="text-4xl font-heading font-bold text-slate-900 mb-4">Básico</div>
                   <p className="text-slate-600">Ideal para comenzar a proteger tu inversión y evitar pérdidas de fertilizante.</p>
                </div>
                
                <ul className="space-y-4 mb-8 flex-grow">
                   {['Filtración de partículas mayores', 'Reducción de Nitratos', 'Soporte técnico 8/5'].map((feature, i) => (
                      <li key={i} className="flex items-center gap-3">
                         <div className="bg-slate-100 rounded-full p-1"><Check size={14} className="text-slate-600" /></div>
                         <span className="text-slate-700 font-medium">{feature}</span>
                      </li>
                   ))}
                </ul>

                <button className="w-full bg-slate-100 hover:bg-slate-200 text-slate-800 font-bold py-4 rounded-xl transition duration-200">
                  Cotizar Básico
                </button>
             </div>

             {/* Plan Premium */}
             <div className="bg-gradient-to-b from-aurix-blue to-blue-600 rounded-3xl p-8 lg:p-12 text-white shadow-2xl shadow-blue-900/50 flex flex-col relative transform md:-translate-y-4 md:scale-105 z-10">
                <div className="absolute top-0 right-0 bg-aurix-green text-aurix-dark text-xs font-bold px-4 py-2 rounded-bl-2xl">MÁS POPULAR</div>
                
                <div className="mb-6">
                   <h3 className="text-blue-100 font-bold tracking-widest uppercase text-sm mb-2">Protección Total</h3>
                   <div className="text-4xl font-heading font-bold text-white mb-4">Premium</div>
                   <p className="text-blue-100">Protección completa contra glifosato y monitoreo avanzado para cultivos de alto valor.</p>
                </div>
                
                <ul className="space-y-4 mb-8 flex-grow">
                   {['Todo lo del plan Básico', 'Remoción de Glifosato y Herbicidas', 'Monitoreo IoT en tiempo real', 'Reportes para auditorías (SMA)', 'Soporte Prioritario 24/7'].map((feature, i) => (
                      <li key={i} className="flex items-center gap-3">
                         <div className="bg-white/20 rounded-full p-1"><Check size={14} className="text-white" /></div>
                         <span className="text-white font-medium">{feature}</span>
                      </li>
                   ))}
                </ul>

                <button className="w-full bg-white text-aurix-blue hover:bg-blue-50 font-bold py-4 rounded-xl transition duration-200 shadow-lg">
                  Cotizar Premium
                </button>
             </div>

          </div>
        </div>
      </section>
    </div>
  );
};