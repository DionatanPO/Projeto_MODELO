import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/values/app_colors.dart';
import '../widgets/web_nav_bar.dart';
import '../widgets/web_footer.dart';
import '../widgets/web_drawer.dart';

class LandingView extends StatelessWidget {
  const LandingView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 900;

    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: isMobile ? const WebDrawer() : null,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 80), // Space for fixed navbar
                _buildHero(context),
                _buildStats(context),
                _buildFeatures(context),
                _buildCTA(context),
                const WebFooter(),
              ],
            ),
          ),
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: WebNavBar(),
          ),
        ],
      ),
    );
  }

  Widget _buildHero(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 900;

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: AppColors.primaryGradient,
      ),
      child: Stack(
        children: [
          // Background abstract elements
          Positioned(
            right: -100,
            top: -100,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.05),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 20 : size.width * 0.1,
              vertical: isMobile ? 40 : 120,
            ),
            child: Flex(
              direction: isMobile ? Axis.vertical : Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: isMobile ? 0 : 1,
                  child: Column(
                    crossAxisAlignment: isMobile
                        ? CrossAxisAlignment.center
                        : CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.accent.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.flash_on,
                                color: AppColors.accent, size: 16),
                            const SizedBox(width: 8),
                            Text(
                              'NOVIDADE: VERSÃO 2.0 LANÇADA',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      Text(
                        'A evolução da\ngestão inteligente.',
                        textAlign:
                            isMobile ? TextAlign.center : TextAlign.start,
                        style: GoogleFonts.outfit(
                          fontSize:
                              isMobile ? (size.width < 360 ? 32 : 42) : 72,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          height: 1.1,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Simplifique processos, escale sua operação e tome decisões baseadas em dados com a plataforma mais robusta do mercado.',
                        textAlign:
                            isMobile ? TextAlign.center : TextAlign.start,
                        style: GoogleFonts.inter(
                          fontSize: isMobile ? 18 : 22,
                          color: Colors.white.withOpacity(0.7),
                          height: 1.6,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 48),
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 20,
                        runSpacing: 20,
                        children: [
                          _buildPrimaryButton('Começar Agora', () {}),
                          _buildSecondaryButton('Ver Demonstração', () {}),
                        ],
                      ),
                    ],
                  ),
                ),
                if (!isMobile) const SizedBox(width: 60),
                if (!isMobile)
                  Expanded(
                    flex: 1,
                    child: _buildHeroImage(),
                  ),
                if (isMobile) const SizedBox(height: 60),
                if (isMobile) _buildHeroImage(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroImage() {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 40,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: Stack(
          children: [
            Center(
              child: Icon(
                Icons.dashboard_customize_rounded,
                size: 160,
                color: Colors.white.withOpacity(0.8),
              ),
            ),
            Positioned(
              bottom: 40,
              right: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white.withOpacity(0.1)),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.check_circle, color: AppColors.success),
                        SizedBox(width: 8),
                        Text('Sistema Ativo',
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStats(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 900;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 40 : 80,
        horizontal: isMobile ? 20 : size.width * 0.1,
      ),
      color: Colors.white,
      child: Wrap(
        spacing: 40,
        runSpacing: 40,
        alignment: WrapAlignment.center,
        children: [
          _buildStatItem('10k+', 'Usuários Ativos'),
          _buildStatItem('99.9%', 'Uptime Garantido'),
          _buildStatItem('24/7', 'Suporte Técnico'),
          _buildStatItem('150+', 'Integrações'),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.outfit(
            fontSize: 40,
            fontWeight: FontWeight.w900,
            color: AppColors.primary,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 16,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildFeatures(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 900;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 60 : 120,
        horizontal: isMobile ? 20 : size.width * 0.1,
      ),
      child: Column(
        children: [
          Text(
            'Recursos poderosos',
            style: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.accent,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Feito para profissionais\nque buscam excelência.',
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(
              fontSize: isMobile ? 32 : 48,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 40),
          LayoutBuilder(
            builder: (context, constraints) {
              return Wrap(
                spacing: 30,
                runSpacing: 30,
                alignment: WrapAlignment.center,
                children: [
                  _buildFeatureCard(
                    context,
                    Icons.auto_graph_rounded,
                    'Analytics em Tempo Real',
                    'Acompanhe o crescimento do seu negócio com dashboards interativos e insights automáticos.',
                  ),
                  _buildFeatureCard(
                    context,
                    Icons.security_rounded,
                    'Segurança Nível Bancário',
                    'Seus dados protegidos com criptografia AES-256 e backups automáticos a cada 1 hora.',
                  ),
                  _buildFeatureCard(
                    context,
                    Icons.cloud_sync_rounded,
                    'Sincronização Multi-plataforma',
                    'Acesse de qualquer lugar, seja no desktop, web ou mobile, com experiência nativa.',
                  ),
                  _buildFeatureCard(
                    context,
                    Icons.hub_rounded,
                    'Automação de Workflow',
                    'Elimine tarefas repetitivas com nosso motor de automação inteligente e integrável.',
                  ),
                  _buildFeatureCard(
                    context,
                    Icons.people_alt_rounded,
                    'Gestão de Equipes',
                    'Controle de permissões granular e ferramentas de colaboração para times de alta performance.',
                  ),
                  _buildFeatureCard(
                    context,
                    Icons.support_agent_rounded,
                    'Suporte Prioritário',
                    'Time de especialistas pronto para ajudar você em qualquer desafio, via chat ou call.',
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(
      BuildContext context, IconData icon, String title, String description) {
    final isMobile = MediaQuery.of(context).size.width < 900;
    return Container(
      width: isMobile ? double.infinity : 380,
      padding: EdgeInsets.all(isMobile ? 24 : 40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: AppColors.border.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.accent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.accent, size: 28),
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: GoogleFonts.outfit(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: GoogleFonts.inter(
              fontSize: 16,
              color: AppColors.textSecondary,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCTA(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 900;

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: isMobile ? 40 : 80,
        horizontal: isMobile ? 20 : size.width * 0.1,
      ),
      padding: EdgeInsets.all(isMobile ? 24 : 80),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(40),
        boxShadow: AppColors.glow,
      ),
      child: Column(
        children: [
          Text(
            'Pronto para transformar seu negócio?',
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(
              fontSize: isMobile ? 32 : 48,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Junte-se a milhares de empresas que já estão crescendo com o MODELO.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 20,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 48),
          _buildPrimaryButton('Começar Grátis agora', () {}),
        ],
      ),
    );
  }

  Widget _buildPrimaryButton(String text, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.accent.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accent,
          foregroundColor: Colors.white,
          minimumSize: const Size(220, 64),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 0,
        ),
        child: Text(
          text,
          style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildSecondaryButton(String text, VoidCallback onPressed) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        side: const BorderSide(color: Colors.white24, width: 2),
        minimumSize: const Size(220, 64),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: Text(
        text,
        style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
