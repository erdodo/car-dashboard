import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/GlobalProvider.dart';

class NodeMCUDataTable extends StatelessWidget {
  const NodeMCUDataTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalProvider>(
      builder: (context, provider, child) {
        if (!provider.isNodeMCUConnected) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.cloud_off_rounded, size: 48, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  'NodeMCU Bagli Degil',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),
          );
        }

        return Container(
          constraints: BoxConstraints(
            maxWidth: (MediaQuery.of(context).size.width / 2) - 16,
            maxHeight: MediaQuery.of(context).size.height - 180,
          ),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.cyan.withOpacity(0.5), width: 1),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.cyan.withOpacity(0.2),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'NodeMCU Sensor Verileri',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Icon(Icons.circle, color: Colors.green, size: 12),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        _buildDataRow('Bagli Ag', provider.bagliAg),
                        _buildDivider(),
                        _buildDataRow(
                          'Hareket',
                          provider.hareketAlgilandi ? 'ON' : 'OFF',
                          valueColor: provider.hareketAlgilandi
                              ? Colors.green
                              : Colors.red,
                        ),
                        _buildDivider(),
                        _buildDataRow('IP Adresi', provider.ipAdresi),
                        _buildDivider(),
                        _buildDataRow(
                          'Nem',
                          '${provider.nem.toStringAsFixed(0)} %',
                        ),
                        _buildDivider(),
                        _buildDataRow(
                          'Isik',
                          provider.ortamIsikDurumu ? 'ON' : 'OFF',
                          valueColor: provider.ortamIsikDurumu
                              ? Colors.green
                              : Colors.grey,
                        ),
                        _buildDivider(),
                        _buildDataRow(
                          'Sicaklik',
                          '${provider.sicaklik.toStringAsFixed(1)} C',
                        ),
                        _buildDivider(),
                        _buildDataRow('WiFi', '${provider.wifiCekimGucu} dBm'),
                        _buildDivider(),
                        _buildDataRow('Versiyon', provider.yazilimVersionu),
                        _buildDivider(),
                        _buildDataRow(
                          'Calisma Suresi',
                          '${provider.calismaSuresi.toStringAsFixed(0)} s',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDataRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white70,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 14,
                color: valueColor ?? Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(color: Colors.grey.withOpacity(0.3), height: 1);
  }
}
