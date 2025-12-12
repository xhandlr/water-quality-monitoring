import 'package:flutter/material.dart';

class AddDeviceDialog extends StatelessWidget {
  const AddDeviceDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Row(
        children: [
          Icon(Icons.add_circle_outline),
          SizedBox(width: 12),
          Text('Agregar Dispositivo'),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Para agregar un nuevo dispositivo Aurix, escanea el código QR que se encuentra en el dispositivo o ingresa el código manualmente.',
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              labelText: 'Código del dispositivo',
              border: const OutlineInputBorder(),
              prefixIcon: const Icon(Icons.qr_code),
              hintText: 'AURIX-XXXX-XXXX',
              suffixIcon: IconButton(
                icon: const Icon(Icons.qr_code_scanner),
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Escáner QR no disponible en modo demo'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Dispositivo agregado correctamente'),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
          child: const Text('Agregar'),
        ),
      ],
    );
  }
}
