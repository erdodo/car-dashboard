import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/GlobalProvider.dart';

class NodeMCUDataWidget extends StatelessWidget {
  const NodeMCUDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalProvider>(
      builder: (context, provider, child) {
        return Card(
          margin: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'NodeMCU Sensör Verileri',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          provider.isNodeMCUConnected
                              ? Icons.circle
                              : Icons.circle_outlined,
                          color: provider.isNodeMCUConnected
                              ? Colors.green
                              : Colors.red,
                          size: 12,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          provider.isNodeMCUConnected
                              ? 'Bağlı'
                              : 'Bağlantı Yok',
                          style: TextStyle(
                            fontSize: 12,
                            color: provider.isNodeMCUConnected
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            if (provider.isNodeMCUConnected) {
                              provider.disconnectFromNodeMCU();
                            } else {
                              provider.connectToNodeMCU();
                            }
                          },
                          child: Text(
                            provider.isNodeMCUConnected
                                ? 'Bağlantıyı Kes'
                                : 'Bağlan',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Divider(height: 32),
                _buildDataRow('Bağlı Ağ', provider.bagliAg),
                _buildDataRow(
                  'Hareket Algılandı',
                  provider.hareketAlgilandi ? 'ON' : 'OFF',
                  color: provider.hareketAlgilandi ? Colors.green : Colors.red,
                ),
                _buildDataRow('IP Adresi', provider.ipAdresi),
                _buildDataRow('Nem', '${provider.nem.toStringAsFixed(0)} %'),
                _buildDataRow(
                  'Ortam Işık Durumu',
                  provider.ortamIsikDurumu ? 'ON' : 'OFF',
                  color: provider.ortamIsikDurumu ? Colors.green : Colors.grey,
                ),
                _buildDataRow(
                  'Sıcaklık',
                  '${provider.sicaklik.toStringAsFixed(1)} °C',
                ),
                _buildDataRow(
                  'WiFi Çekim Gücü',
                  '${provider.wifiCekimGucu} dBm',
                ),
                _buildDataRow('Yazılım Versiyonu', provider.yazilimVersionu),
                _buildDataRow(
                  'Çalışma Süresi',
                  '${provider.calismaSuresi.toStringAsFixed(0)} s',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDataRow(String label, String value, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: color ?? Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
