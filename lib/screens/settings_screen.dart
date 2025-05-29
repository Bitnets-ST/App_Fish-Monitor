import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A2342),
        title: const Text(
          'Configuración',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildSettingsSection(
              'Preferencias',
              [
                _buildSettingsTile(
                  context,
                  'Tema',
                  'Cambiar entre tema claro y oscuro',
                  Icons.palette,
                  () {
                    // TODO: Implementar cambio de tema
                  },
                ),
                _buildSettingsTile(
                  context,
                  'Idioma',
                  'Español',
                  Icons.language,
                  () {
                    // TODO: Implementar cambio de idioma
                  },
                ),
              ],
            ),
            _buildSettingsSection(
              'Notificaciones',
              [
                _buildSettingsTile(
                  context,
                  'Alertas',
                  'Configurar notificaciones de alertas',
                  Icons.notifications,
                  () {
                    // TODO: Implementar configuración de alertas
                  },
                ),
                _buildSettingsTile(
                  context,
                  'Sonidos',
                  'Activar/desactivar sonidos',
                  Icons.volume_up,
                  () {
                    // TODO: Implementar configuración de sonidos
                  },
                ),
              ],
            ),
            _buildSettingsSection(
              'Cuenta',
              [
                _buildSettingsTile(
                  context,
                  'Perfil',
                  'Editar información personal',
                  Icons.person,
                  () {
                    // TODO: Implementar edición de perfil
                  },
                ),
                _buildSettingsTile(
                  context,
                  'Seguridad',
                  'Cambiar contraseña y configuración de seguridad',
                  Icons.security,
                  () {
                    // TODO: Implementar configuración de seguridad
                  },
                ),
                _buildSettingsTile(
                  context,
                  'Cerrar Sesión',
                  'Salir de la aplicación',
                  Icons.logout,
                  () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  isDestructive: true,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Versión 1.0.0',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0A2342),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsTile(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap, {
    bool isDestructive = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey.withOpacity(0.1),
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isDestructive
                    ? Colors.red.withOpacity(0.1)
                    : const Color(0xFF0A2342).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: isDestructive ? Colors.red : const Color(0xFF0A2342),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: isDestructive ? Colors.red : Colors.black87,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: isDestructive
                          ? Colors.red.withOpacity(0.7)
                          : Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: isDestructive ? Colors.red : Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }
} 