import React from 'react';
import { Smartphone, CheckCircle, Wifi } from 'lucide-react';

export const Monitoring: React.FC = () => {
  return (
    <div className="w-full min-h-screen bg-slate-900 text-white pt-24 pb-20 relative overflow-hidden">
      {/* Background elements */}
      <div className="absolute top-0 right-0 w-[600px] h-[600px] bg-blue-600/10 rounded-full blur-[120px]"></div>
      <div className="absolute bottom-0 left-0 w-[500px] h-[500px] bg-green-500/10 rounded-full blur-[100px]"></div>

      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 flex flex-col lg:flex-row items-center justify-between gap-16 relative z-10">
        
        <div className="w-full lg:w-1/2">
          <div className="inline-flex items-center gap-2 bg-aurix-blue/20 text-aurix-blue px-4 py-1.5 rounded-full mb-6 border border-aurix-blue/30">
             <Wifi size={16} />
             <span className="text-sm font-bold tracking-wide">IoT Conectado</span>
          </div>
          
          <h2 className="text-5xl font-heading font-bold mb-6 leading-tight">
            El control de tu campo,<br/> 
            <span className="text-aurix-blue">en tu bolsillo.</span>
          </h2>
          
          <p className="text-slate-300 text-lg mb-10 leading-relaxed">
            No necesitas estar en el predio para saber qué está pasando. Descarga la aplicación y visualiza el estado de tus cultivos en tiempo real.
          </p>

          <div className="space-y-6 bg-white/5 p-8 rounded-3xl border border-white/10 backdrop-blur-sm">
            {[
              "Estudio de PH y Turbidez en vivo",
              "Alertas predictivas según tu cultivo",
              "Reportes PDF automáticos para auditorías",
              "Verificación de remoción de pesticidas"
            ].map((item, index) => (
              <div key={index} className="flex items-start gap-4">
                <div className="mt-1 bg-aurix-green rounded-full p-1 shadow-[0_0_10px_rgba(132,204,22,0.5)]">
                  <CheckCircle size={16} className="text-aurix-dark" />
                </div>
                <p className="text-slate-200 font-medium text-lg">{item}</p>
              </div>
            ))}
          </div>

          <div className="mt-10 flex flex-col sm:flex-row gap-4">
            <button className="bg-aurix-blue hover:bg-blue-600 text-white font-bold py-4 px-10 rounded-full shadow-lg shadow-blue-500/30 transition transform hover:-translate-y-1">
              Descargar App
            </button>
          </div>
        </div>

        <div className="w-full lg:w-1/2 flex justify-center py-10 relative perspective-1000">
           {/* Mockup Phone */}
           <div className="relative border-slate-800 bg-slate-800 border-[12px] rounded-[3rem] h-[650px] w-[340px] shadow-2xl transform rotate-[-5deg] hover:rotate-0 transition duration-700">
                <div className="h-[32px] w-[3px] bg-slate-800 absolute -left-[15px] top-[72px] rounded-l-lg"></div>
                <div className="h-[46px] w-[3px] bg-slate-800 absolute -left-[15px] top-[124px] rounded-l-lg"></div>
                <div className="h-[46px] w-[3px] bg-slate-800 absolute -left-[15px] top-[178px] rounded-l-lg"></div>
                <div className="h-[64px] w-[3px] bg-slate-800 absolute -right-[15px] top-[142px] rounded-r-lg"></div>
                <div className="rounded-[2.2rem] overflow-hidden w-full h-full bg-slate-900 flex flex-col items-center justify-center relative">
                    
                    {/* App UI Simulation */}
                    <div className="absolute top-0 w-full h-full bg-slate-900">
                        {/* Header App */}
                        <div className="bg-aurix-dark p-6 pt-12 pb-8 rounded-b-3xl shadow-lg">
                           <div className="flex justify-between items-center text-white mb-4">
                              <span className="font-heading font-bold">Aurix Mobile</span>
                              <div className="w-8 h-8 rounded-full bg-aurix-blue/50"></div>
                           </div>
                           <h2 className="text-2xl font-bold text-white">¡Hola!</h2>
                           <p className="text-blue-200 text-sm">Tu campo está protegido.</p>
                        </div>

                        {/* Status Card */}
                        <div className="p-6">
                            <div className="bg-gradient-to-r from-aurix-blue to-blue-500 p-6 rounded-2xl shadow-lg shadow-blue-500/20 text-white mb-6">
                                <p className="text-sm opacity-80 mb-1">Calidad del Agua</p>
                                <h3 className="text-3xl font-bold mb-2">98% Pura</h3>
                                <div className="h-1 bg-white/30 rounded-full w-full">
                                   <div className="h-1 bg-white rounded-full w-[98%]"></div>
                                </div>
                            </div>

                            <div className="grid grid-cols-2 gap-4">
                               <div className="bg-slate-800 p-4 rounded-2xl border border-slate-700">
                                  <p className="text-slate-400 text-xs uppercase mb-2">Nitratos</p>
                                  <p className="text-xl font-bold text-green-400">0.02 ppm</p>
                               </div>
                               <div className="bg-slate-800 p-4 rounded-2xl border border-slate-700">
                                  <p className="text-slate-400 text-xs uppercase mb-2">Caudal</p>
                                  <p className="text-xl font-bold text-blue-400">45 L/m</p>
                               </div>
                            </div>
                            
                            <div className="mt-6 bg-slate-800 p-4 rounded-2xl border border-slate-700 flex flex-col items-center justify-center h-48">
                                <div className="p-2 bg-white rounded-lg mb-2">
                                     <div className="w-24 h-24 bg-white flex items-center justify-center">
                                         <span className="font-mono text-[10px] text-black">QR SCAN</span>
                                     </div>
                                </div>
                                <p className="text-xs text-slate-400">Escanear Filtro</p>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>

      </div>
    </div>
  );
};