import React from 'react';
import { AurixLogo } from '../components/Icons';
import { Linkedin } from 'lucide-react';

export const About: React.FC = () => {
  const team = [
    { name: "Maira Huaiquiñir", role: "CEO", area: "Termo Fluidos", title: "Ing. Civil Mecánica", img: "https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?q=80&w=400&h=400&auto=format&fit=crop" },
    { name: "Camille Elgueta", role: "CPO & CTO", area: "Producto & Tec", title: "Ing. Civil Informática", img: "https://images.unsplash.com/photo-1580489944761-15a19d654956?q=80&w=400&h=400&auto=format&fit=crop" },
    { name: "Felipe Rios", role: "COO", area: "Hidráulica", title: "Ingeniería Civil", img: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=400&h=400&auto=format&fit=crop" },
    { name: "Isidora Sierra", role: "CSO", area: "Ciencia Materiales", title: "Ing. Civil Química", img: "https://images.unsplash.com/photo-1544005313-94ddf0286df2?q=80&w=400&h=400&auto=format&fit=crop" },
    { name: "Nicolas Muñoz", role: "CIO", area: "Manejo IoT", title: "Ing. Civil Telemática", img: "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?q=80&w=400&h=400&auto=format&fit=crop" },
    { name: "Evelyn Stuardo", role: "Inv. Ambiental", area: "Área Ambiental", title: "Ing. Civil Ambiental", img: "https://images.unsplash.com/photo-1598550874175-4d7112ee750c?q=80&w=400&h=400&auto=format&fit=crop" },
  ];

  return (
    <div className="w-full bg-slate-50 pt-32 pb-20">
      
      {/* Header */}
      <div className="max-w-4xl mx-auto px-4 text-center mb-20">
        <div className="flex justify-center mb-6">
           <AurixLogo className="h-16 opacity-90" />
        </div>
        <h1 className="text-4xl md:text-5xl font-heading font-bold text-aurix-dark mb-8">
            Ingeniería Chilena al servicio del agro
        </h1>
        
        <div className="bg-white p-8 rounded-3xl shadow-soft text-left md:text-center">
            <p className="text-slate-600 mb-6 text-lg leading-relaxed">
            Somos <strong>Aurix</strong>, un equipo interdisciplinario de ingeniería de la <strong>Universidad de La Frontera</strong>. Investigamos la contaminación del agua de riego en ríos del sur de Chile, detectando niveles críticos de contaminantes que amenazan la agricultura de exportación.
            </p>
            <p className="font-semibold text-aurix-blue italic">
            Proyecto consultado con expertos en química agrícola y agrónomos de la UFRO.
            </p>
        </div>
      </div>

      {/* Team Grid */}
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <h2 className="text-3xl font-heading font-bold text-center text-slate-800 mb-12">Nuestro Equipo</h2>
        
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
          {team.map((member, index) => (
            <div key={index} className="bg-white rounded-3xl overflow-hidden shadow-sm hover:shadow-xl transition duration-300 group border border-slate-100">
              <div className="p-6 flex items-center gap-4">
                <img 
                  src={member.img} 
                  alt={member.name} 
                  className="w-20 h-20 rounded-full object-cover shadow-md group-hover:scale-110 transition duration-300"
                />
                <div>
                    <h3 className="text-lg font-bold text-slate-800 leading-tight">{member.name}</h3>
                    <p className="text-sm font-bold text-aurix-blue uppercase tracking-wide mt-1">{member.role}</p>
                </div>
              </div>
              
              <div className="bg-slate-50 px-6 py-4 border-t border-slate-100 flex justify-between items-center">
                <div>
                    <p className="text-xs text-slate-500 font-bold uppercase mb-0.5">{member.area}</p>
                    <p className="text-sm text-slate-700 font-medium">{member.title}</p>
                </div>
                <button className="text-slate-400 hover:text-blue-700 transition">
                    <Linkedin size={20} />
                </button>
              </div>
            </div>
          ))}
        </div>
      </div>

    </div>
  );
};