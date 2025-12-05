import React from 'react';

export const AurixLogo = ({ className = "h-10" }: { className?: string }) => (
  <svg viewBox="0 0 200 60" className={className} fill="none" xmlns="http://www.w3.org/2000/svg">
    {/* Stylized Drop */}
    <path d="M30 10C30 10 10 35 10 45C10 53.2843 16.7157 60 25 60C33.2843 60 40 53.2843 40 45C40 35 30 10 30 10Z" fill="#0ea5e9" />
    <path d="M25 60C16.7157 60 10 53.2843 10 45C10 35 30 10 30 10C30 10 23 45 25 60Z" fill="#38bdf8" />
    
    {/* Stylized Leaf */}
    <path d="M45 60C45 60 65 50 65 35C65 20 45 20 45 20C45 20 25 30 25 45C25 60 45 60 45 60Z" fill="#84cc16" transform="translate(10, -5)" />
    <path d="M45 20C45 20 25 30 25 45C25 60 45 60 45 60C45 60 40 40 45 20Z" fill="#bef264" transform="translate(10, -5)" />

    {/* Text */}
    <text x="80" y="45" fontFamily="sans-serif" fontWeight="bold" fontSize="36" fill="#051e34">Aurix</text>
  </svg>
);

export const CheckIcon = () => (
  <svg className="w-6 h-6 text-aurix-green flex-shrink-0" fill="currentColor" viewBox="0 0 20 20">
    <path fillRule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clipRule="evenodd" />
  </svg>
);

export const AlertIcon = () => (
  <svg className="w-16 h-16 text-red-500 mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z" />
  </svg>
);

export const MoneyIcon = () => (
  <svg className="w-16 h-16 text-yellow-400 mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
  </svg>
);

export const GavelIcon = () => (
  <svg className="w-16 h-16 text-amber-700 mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15 15l-2 5L9 9l11 4-5 2zm0 0l5 5M7.188 2.239l.777 2.897M5.136 7.965l-2.898-.777M13.95 4.05l-2.122 2.122m-5.657 5.656l-2.12 2.122" />
  </svg>
);