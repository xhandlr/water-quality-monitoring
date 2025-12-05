import React from 'react';
import logo_dark from '../assets/logo_dark.png';
import { Page } from '../../App';
import { Mail, Phone } from 'lucide-react';

interface FooterProps {
  onNavigate: (page: Page) => void;
}

export const Footer: React.FC<FooterProps> = ({ onNavigate }) => {
  return (
    <footer className="bg-aurix-dark text-white pt-12 pb-8">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="grid grid-cols-1 md:grid-cols-4 gap-8">
          
          {/* Brand */}
          <div className="col-span-1">
            <div className="flex items-center gap-2 mb-4">
              <img src={logo_dark} alt="Aurix Logo" className="h-10 w-auto" />
            </div>
          </div>

          {/* Navigation */}
          <div>
            <h3 className="font-bold text-lg mb-4">Navegación</h3>
            <ul className="space-y-2 text-sm text-gray-400">
              <li><button onClick={() => onNavigate('inicio')} className="hover:text-aurix-blue">Inicio</button></li>
              <li><button onClick={() => onNavigate('producto')} className="hover:text-aurix-blue">Nuestra solución</button></li>
              <li><button onClick={() => onNavigate('monitoreo')} className="hover:text-aurix-blue">Monitoreo</button></li>
              <li><button onClick={() => onNavigate('nosotros')} className="hover:text-aurix-blue">Sobre Nosotros</button></li>
            </ul>
          </div>

          {/* Contact */}
          <div>
            <h3 className="font-bold text-lg mb-4">Contacto</h3>
            <ul className="space-y-3 text-sm text-gray-400">
              <li className="flex items-center gap-2">
                <Mail size={16} />
                <a href="mailto:aurix.startup@gmail.com" className="hover:text-white">aurix.startup@gmail.com</a>
              </li>
              <li className="flex items-center gap-2">
                <Phone size={16} />
                <span>(+569) 1234 5678</span>
              </li>
            </ul>
          </div>

          {/* Legal */}
          <div>
            <h3 className="font-bold text-lg mb-4">Legal</h3>
            <ul className="space-y-2 text-sm text-gray-400">
              <li><a href="#" className="hover:text-white">Políticas de privacidad</a></li>
              <li><a href="#" className="hover:text-white">Términos y condiciones</a></li>
            </ul>
          </div>
        </div>

        <div className="mt-12 pt-8 border-t border-gray-800 text-center text-sm text-gray-500">
          &copy; {new Date().getFullYear()} Aurix. Todos los derechos reservados.
        </div>
      </div>
    </footer>
  );
};