import React from 'react';
import { Linkedin } from 'lucide-react';
import members_template from '../assets/members.png';

export const About: React.FC = () => {
  const team = [
    { name: "Maira Huaiquiñir", role: "CEO", area: "Termo Fluidos", title: "Ing. Civil Mecánica", img: members_template },
    { name: "Camille Elgueta", role: "CPO & CTO", area: "Producto & Tec", title: "Ing. Civil Informática", img: members_template },
    { name: "Felipe Rios", role: "COO", area: "Hidráulica", title: "Ingeniería Civil", img: members_template },
    { name: "Isidora Sierra", role: "CSO", area: "Ciencia Materiales", title: "Ing. Civil Química", img: members_template },
    { name: "Nicolas Muñoz", role: "CIO", area: "Manejo IoT", title: "Ing. Civil Telemática", img: members_template },
    { name: "Evelyn Stuardo", role: "Inv. Ambiental", area: "Área Ambiental", title: "Ing. Civil Ambiental", img: members_template },
  ];

  return (
    <div className="w-full bg-slate-50 pt-32 pb-20">
      
      {/* Header */}
      <div className="max-w-4xl mx-auto px-4 text-center mb-20">
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