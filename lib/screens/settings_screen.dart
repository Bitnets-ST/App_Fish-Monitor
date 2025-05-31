import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 360;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0F4C75),
              Color(0xFF2E86AB),
              Color(0xFF85C1E9),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Configuración',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // Settings Content
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionTitle('Cuenta'),
                        _buildSettingItem(
                          icon: Icons.person_outline,
                          title: 'Perfil',
                          subtitle: 'Información personal y preferencias',
                          onTap: () {},
                        ),
                        _buildSettingItem(
                          icon: Icons.notifications_outlined,
                          title: 'Notificaciones',
                          subtitle: 'Configurar alertas y recordatorios',
                          onTap: () {},
                        ),
                        _buildSettingItem(
                          icon: Icons.security_outlined,
                          title: 'Seguridad',
                          subtitle: 'Contraseña y autenticación',
                          onTap: () {},
                        ),
                        const SizedBox(height: 20),
                        _buildSectionTitle('Preferencias'),
                        _buildSettingItem(
                          icon: Icons.language_outlined,
                          title: 'Idioma',
                          subtitle: 'Español',
                          onTap: () {},
                        ),
                        _buildSettingItem(
                          icon: Icons.dark_mode_outlined,
                          title: 'Tema',
                          subtitle: 'Claro',
                          onTap: () {},
                        ),
                        _buildSettingItem(
                          icon: Icons.speed_outlined,
                          title: 'Unidades',
                          subtitle: 'Métrico',
                          onTap: () {},
                        ),
                        const SizedBox(height: 20),
                        _buildSectionTitle('Sistema'),
                        _buildSettingItem(
                          icon: Icons.update_outlined,
                          title: 'Actualizaciones',
                          subtitle: 'Versión 1.0.0',
                          onTap: () {},
                        ),
                        _buildSettingItem(
                          icon: Icons.help_outline,
                          title: 'Ayuda y Soporte',
                          subtitle: 'FAQ y contacto',
                          onTap: () {},
                        ),
                        _buildSettingItem(
                          icon: Icons.info_outline,
                          title: 'Acerca de',
                          subtitle: 'Información de la aplicación',
                          onTap: () {},
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              // TODO: Implementar cierre de sesión
                            },
                            child: const Text(
                              'Cerrar Sesión',
                              style: TextStyle(
                                color: Color(0xFFE74C3C),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF0F4C75),
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(15),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F4C75).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: const Color(0xFF0F4C75),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF2C3E50),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: Color(0xFF0F4C75),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 