import React, { useState } from 'react';
import { Navbar } from './src/components/Navbar';
import { Footer } from './src/components/Footer';
import { Home } from './src/pages/Home';
import { Product } from './src/pages/Product';
import { Monitoring } from './src/pages/Monitoring';
import { About } from './src/pages/About';

export type Page = 'inicio' | 'producto' | 'monitoreo' | 'nosotros';

export default function App() {
  const [currentPage, setCurrentPage] = useState<Page>('inicio');

  const renderPage = () => {
    switch (currentPage) {
      case 'inicio':
        return <Home onNavigate={setCurrentPage} />;
      case 'producto':
        return <Product />;
      case 'monitoreo':
        return <Monitoring />;
      case 'nosotros':
        return <About />;
      default:
        return <Home onNavigate={setCurrentPage} />;
    }
  };

  return (
    <div className="min-h-screen flex flex-col bg-aurix-light text-slate-800 font-sans selection:bg-aurix-green selection:text-white">
      <Navbar currentPage={currentPage} onNavigate={setCurrentPage} />
      <main className="flex-grow">
        {renderPage()}
      </main>
      <Footer onNavigate={setCurrentPage} />
    </div>
  );
}