function Navbar() {

    return (
        <nav className="w-full fixed top-0 left-0 bg-white bg-opacity-95 backdrop-blur-sm text-gray-800 border-b border-gray-200 shadow-lg z-50">
            <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div className="flex items-center h-16">
                    {/* Logo and title - left side */}
                    <div className="flex-shrink-0">
                        <a href="/" className="text-xl font-bold text-blue-600">
                            MyApp
                        </a>
                    </div>
                    {/* Navigation links - center */}
                    <div className="hidden md:block ml-10">
                        <div className="flex space-x-4">
                            <a href="/features" className="px-3 py-2 rounded-md text-sm font-medium hover:bg-gray-200">Features</a>
                            <a href="/pricing" className="px-3 py-2 rounded-md text-sm font-medium hover:bg-gray-200">Pricing</a>
                            <a href="/about" className="px-3 py-2 rounded-md text-sm font-medium hover:bg-gray-200">About</a>
                            <a href="/contact" className="px-3 py-2 rounded-md text-sm font-medium hover:bg-gray-200">Contact</a>
                        </div>
                    </div>
                    {/* Mobile menu button */}
                    <div className="md:hidden">
                        <button className="inline-flex items-center justify-center p-2 rounded-md text-gray-800 hover:bg-gray-200 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                            <span className="sr-only">Open main menu</span>
                            <svg className="h-6 w-6" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4 6h16M4 12h16m-7 6h7" />
                            </svg>
                        </button>
                    </div>
                </div>
            </div>
        </nav>
    );
}

export default Navbar;