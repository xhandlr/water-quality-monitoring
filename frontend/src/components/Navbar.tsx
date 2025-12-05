import React, { useState, useEffect } from 'react';
import { Page } from '../../App';
import { Menu, X } from 'lucide-react';
import logo from '../assets/logo.png';
import logoDark from '../assets/logo_dark.png';

interface NavbarProps {
  currentPage: Page;
  onNavigate: (page: Page) => void;
}

export const Navbar: React.FC<NavbarProps> = ({ currentPage, onNavigate }) => {
  const [isOpen, setIsOpen] = useState(false);
  const [scrolled, setScrolled] = useState(false);

  useEffect(() => {
    const handleScroll = () => {
      setScrolled(window.scrollY > 20);
    };
    window.addEventListener('scroll', handleScroll);
    return () => window.removeEventListener('scroll', handleScroll);
  }, []);

  const navItems: { id: Page; label: string }[] = [
    { id: 'inicio', label: 'Inicio' },
    { id: 'producto', label: 'Producto' },
    { id: 'monitoreo', label: 'Monitoreo' },
    { id: 'nosotros', label: 'Sobre Nosotros' },
  ];

  const handleNav = (page: Page) => {
    onNavigate(page);
    setIsOpen(false);
    window.scrollTo(0, 0);
  };

  return (
    <nav 
      className={`fixed w-full z-50 transition-all duration-300 ${
        scrolled ? 'bg-white/90 backdrop-blur-md shadow-md py-2' : 'bg-transparent py-4'
      }`}
    >
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex items-center justify-between">
          {/* Logo */}
          <div className="flex-shrink-0 cursor-pointer group" onClick={() => handleNav('inicio')}>
            <div className="flex items-center gap-2">
              <img 
                src={currentPage === 'monitoreo' && !scrolled ? logoDark : logo} 
                alt="Aurix Logo" 
                className="h-12 w-auto transition-transform duration-300 group-hover:scale-105" 
              />
            </div>
          </div>
          
          {/* Desktop Nav */}
          <div className="hidden md:block">
            <div className="ml-10 flex items-center space-x-8">
              {navItems.map((item) => (
                <button
                  key={item.id}
                  onClick={() => handleNav(item.id)}
                  className={`px-4 py-2 rounded-full text-sm font-bold transition-all duration-200 ${
                    currentPage === item.id
                      ? 'bg-aurix-blue text-white shadow-lg shadow-blue-200'
                      : 'text-slate-600 hover:text-aurix-blue hover:bg-blue-50'
                  }`}
                >
                  {item.label}
                </button>
              ))}
            </div>
          </div>

          {/* Mobile Button */}
          <div className="md:hidden">
            <button
              onClick={() => setIsOpen(!isOpen)}
              className="inline-flex items-center justify-center p-2 rounded-md text-aurix-dark hover:bg-gray-100 focus:outline-none"
            >
              {isOpen ? <X size={28} /> : <Menu size={28} />}
            </button>
          </div>
        </div>
      </div>

      {/* Mobile menu */}
      {isOpen && (
        <div className="md:hidden bg-white absolute top-full left-0 w-full shadow-xl border-t border-gray-100">
          <div className="px-4 py-4 space-y-2">
            {navItems.map((item) => (
              <button
                key={item.id}
                onClick={() => handleNav(item.id)}
                className={`block w-full text-left px-4 py-3 rounded-lg text-base font-bold ${
                  currentPage === item.id
                    ? 'text-aurix-blue bg-blue-50'
                    : 'text-slate-600 hover:text-aurix-blue hover:bg-gray-50'
                }`}
              >
                {item.label}
              </button>
            ))}
          </div>
        </div>
      )}
    </nav>
  );
};