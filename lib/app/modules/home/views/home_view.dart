import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/values/app_colors.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isDesktop = size.width >= 1100;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: isDesktop
          ? null
          : AppBar(
              title: Text('Painel Administrativo',
                  style: GoogleFonts.outfit(fontWeight: FontWeight.w700)),
              elevation: 0,
              backgroundColor: Colors.white,
              foregroundColor: AppColors.textPrimary,
            ),
      drawer: isDesktop ? null : _buildSidebar(context),
      body: Row(
        children: [
          if (isDesktop) _buildSidebar(context),
          Expanded(
            child: Column(
              children: [
                if (isDesktop) _buildTopBar(context),
                Expanded(
                  child:
                      Obx(() => _buildContent(controller.selectedIndex.value)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar(BuildContext context) {
    return Container(
      width: 280,
      height: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.primary,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          _buildSidebarHeader(),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _buildMenuItem(0, 'Dashboard', Icons.dashboard_rounded),
                  _buildMenuItem(1, 'Usuários', Icons.people_alt_rounded),
                  _buildMenuItem(2, 'Relatórios', Icons.analytics_rounded),
                  _buildMenuItem(
                      3, 'Financeiro', Icons.account_balance_wallet_rounded),
                  _buildMenuItem(
                      4, 'Configurações', Icons.settings_suggest_rounded),
                  _buildMenuItem(5, 'Suporte', Icons.headset_mic_rounded),
                ],
              ),
            ),
          ),
          _buildSidebarFooter(),
        ],
      ),
    );
  }

  Widget _buildSidebarHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.auto_awesome_mosaic_rounded,
                color: Colors.white, size: 28),
          ),
          const SizedBox(width: 12),
          Text(
            'MODELO',
            style: GoogleFonts.outfit(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(int index, String title, IconData icon) {
    return Obx(() {
      final isSelected = controller.selectedIndex.value == index;
      return Container(
        margin: const EdgeInsets.only(bottom: 8),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => controller.changePage(index),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.accent.withOpacity(0.15)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(
                    icon,
                    color: isSelected
                        ? AppColors.accentLight
                        : AppColors.textMuted,
                    size: 22,
                  ),
                  const SizedBox(width: 16),
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      color: isSelected ? Colors.white : AppColors.textMuted,
                      fontWeight:
                          isSelected ? FontWeight.w700 : FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                  if (isSelected) const Spacer() else const SizedBox.shrink(),
                  if (isSelected)
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: AppColors.accentLight,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildSidebarFooter() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.white.withOpacity(0.05))),
      ),
      child: InkWell(
        onTap: controller.logout,
        child: Row(
          children: [
            const Icon(Icons.logout_rounded, color: AppColors.error, size: 22),
            const SizedBox(width: 16),
            Text(
              'Sair da Conta',
              style: GoogleFonts.inter(
                color: AppColors.error,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 32),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          Obx(() {
            final titles = [
              'Dashboard',
              'Usuários',
              'Relatórios',
              'Financeiro',
              'Configurações',
              'Suporte'
            ];
            return Text(
              titles[controller.selectedIndex.value],
              style: GoogleFonts.outfit(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            );
          }),
          const Spacer(),
          // Profile Widget
          Row(
            children: [
              const Icon(Icons.notifications_none_rounded,
                  color: AppColors.textSecondary),
              const SizedBox(width: 24),
              const VerticalDivider(indent: 25, endIndent: 25),
              const SizedBox(width: 24),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('Administrador',
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary)),
                  Text('admin@admin.com',
                      style: GoogleFonts.inter(
                          fontSize: 12, color: AppColors.textSecondary)),
                ],
              ),
              const SizedBox(width: 16),
              CircleAvatar(
                backgroundColor: AppColors.accent.withOpacity(0.1),
                child: const Text('AD',
                    style: TextStyle(
                        color: AppColors.accent, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContent(int index) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildStatCard('Total de Usuários', '1,280',
                  Icons.people_alt_rounded, Colors.blue),
              const SizedBox(width: 24),
              _buildStatCard('Vendas do Mês', 'R\$ 45.200',
                  Icons.shopping_bag_rounded, Colors.green),
              const SizedBox(width: 24),
              _buildStatCard(
                  'Novos Chamados', '12', Icons.message_rounded, Colors.orange),
            ],
          ),
          const SizedBox(height: 32),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Atividades Recentes',
                  style: GoogleFonts.outfit(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary),
                ),
                const SizedBox(height: 24),
                _buildActivityItem(
                    'Novo usuário registrado', 'Admin', 'Há 2 minutos'),
                const Divider(),
                _buildActivityItem(
                    'Pagamento confirmado', 'Financeiro', 'Há 15 minutos'),
                const Divider(),
                _buildActivityItem(
                    'Backup concluído com sucesso', 'Sistema', 'Há 1 hora'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
      String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: GoogleFonts.inter(
                        color: AppColors.textSecondary, fontSize: 14)),
                const SizedBox(height: 4),
                Text(value,
                    style: GoogleFonts.outfit(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem(String activity, String category, String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          CircleAvatar(radius: 4, backgroundColor: AppColors.accent),
          const SizedBox(width: 16),
          Expanded(
            child: Text(activity,
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500, color: AppColors.textPrimary)),
          ),
          Text(category,
              style: GoogleFonts.inter(
                  color: AppColors.accent,
                  fontSize: 12,
                  fontWeight: FontWeight.bold)),
          const SizedBox(width: 16),
          Text(time,
              style:
                  GoogleFonts.inter(color: AppColors.textMuted, fontSize: 12)),
        ],
      ),
    );
  }
}
