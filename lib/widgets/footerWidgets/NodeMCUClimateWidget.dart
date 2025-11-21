import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/GlobalProvider.dart';

class NodeMCUClimateWidget extends StatelessWidget {
  const NodeMCUClimateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalProvider>(
      builder: (context, provider, child) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Sıcaklık
            _buildDataItem(
              icon: Icons.thermostat_rounded,
              value: provider.isNodeMCUConnected
                  ? '${provider.sicaklik.toStringAsFixed(1)}°C'
                  : '--°C',
              color: _getTemperatureColor(provider.sicaklik),
            ),

            const SizedBox(width: 20),

            // Ayırıcı çizgi
            Container(
              height: 30,
              width: 1,
              color: Colors.grey.withOpacity(0.5),
            ),

            const SizedBox(width: 20),

            // Nem
            _buildDataItem(
              icon: Icons.water_drop_rounded,
              value: provider.isNodeMCUConnected
                  ? '${provider.nem.toStringAsFixed(0)}%'
                  : '--%',
              color: _getHumidityColor(provider.nem),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDataItem({
    required IconData icon,
    required String value,
    required Color color,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(width: 6),
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Color _getTemperatureColor(double temperature) {
    if (temperature < 20) {
      return Colors.blue;
    } else if (temperature < 28) {
      return Colors.white;
    } else {
      return Colors.red;
    }
  }

  Color _getHumidityColor(double humidity) {
    if (humidity < 40) {
      return Colors.red;
    } else if (humidity < 55) {
      return Colors.white;
    } else {
      return Colors.blue;
    }
  }
}
