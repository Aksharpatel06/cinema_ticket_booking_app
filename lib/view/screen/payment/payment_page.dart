import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.chevron_left, size: 35),
        title: const Text("Pay for Tickets"),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: 812,
        decoration: const BoxDecoration(color: Color(0xFF1A2232)),
        child: Column(
          children: [
            Container(
              height: 488,
              decoration: const BoxDecoration(
                color: Color(0xFF1E283D),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'The Batman',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildInfoRow('Cinema', 'Eurasia Cinema7'),
                        const SizedBox(height: 4),
                        _buildInfoRow('Address', 'ул. Петрова, д.24, ТЦ "Евразия"'),
                        const SizedBox(height: 8),
                        _buildInfoRow('Date', '6 April 2022, 14:40'),
                        const SizedBox(height: 8),
                        _buildInfoRow('Hall', '6th'),
                        const SizedBox(height: 8),
                        _buildInfoRow('Seats', '7 row (7, 8)'),
                        const SizedBox(height: 16),
                        const Divider(thickness: 1, color: Color(0x196D9DFF)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildDotRow(),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        _buildInputBox('Phone number'),
                        const SizedBox(height: 16),
                        _buildGradientButton('Continue'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      children: [
        SizedBox(
          width: 74,
          child: Text(
            label,
            style: const TextStyle(
              color: Color(0xFF637393),
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildDotRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(16, (index) => const Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: CircleAvatar(
          radius: 6,
          backgroundColor: Color(0xFF1A2232),
        ),
      )),
    );
  }

  Widget _buildInputBox(String label) {
    return Container(
      width: double.infinity,
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0x196D9DFF)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          label,
          style: const TextStyle(
            color: Color(0xFF637393),
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildGradientButton(String label) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFF8036), Color(0xFFFC6C19)],
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: const Color(0x3FFF8036),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}