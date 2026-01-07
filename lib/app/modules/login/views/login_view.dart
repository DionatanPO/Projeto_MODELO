import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/values/app_colors.dart';
import '../../../routes/app_routes.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isDesktop = size.width >= 1024;
    final bool isTablet = size.width >= 600 && size.width < 1024;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          if (isDesktop)
            Expanded(
              flex: 1,
              child: _buildBrandingSide(context),
            ),
          Expanded(
            child: Container(
              color: isDesktop ? Colors.white : AppColors.background,
              child: SafeArea(
                child: Center(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: isDesktop ? 80 : (isTablet ? 60 : 24),
                      vertical: 40,
                    ),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 450),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (!isDesktop) _buildMobileHeader(context),
                          const SizedBox(height: 48),
                          _buildFormHeader(context),
                          const SizedBox(height: 40),
                          _buildLoginForm(context),
                          const SizedBox(height: 32),
                          _buildFooter(context),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBrandingSide(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: AppColors.primaryGradient,
      ),
      child: Stack(
        children: [
          Positioned(
            top: -100,
            left: -100,
            child: CircleAvatar(
              radius: 200,
              backgroundColor: Colors.white.withOpacity(0.05),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(60.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.auto_awesome_mosaic_rounded,
                      color: Colors.white,
                      size: 48,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    'Infraestrutura Digital\npara o Futuro.',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          fontSize: 48,
                          color: AppColors.textLight,
                          height: 1.1,
                        ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Gerencie seu Projeto MODELO com a melhor experiência de usuário e as tecnologias mais recentes.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.textLight.withOpacity(0.7),
                          height: 1.5,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileHeader(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.auto_awesome_mosaic_rounded,
              color: Colors.white,
              size: 32,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'MODELO',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  letterSpacing: 2,
                  color: AppColors.textPrimary,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Acesse sua conta',
          style: Theme.of(context).textTheme.displaySmall,
        ),
        const SizedBox(height: 12),
        Text(
          'Entre com suas credenciais para gerenciar seus dados.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.textSecondary,
              ),
        ),
      ],
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        children: [
          _buildTextField(
            context,
            label: 'E-mail Institucional',
            hint: 'exemplo@projeto.com',
            icon: Icons.mail_outline_rounded,
            controller: controller.emailController,
            validator: (val) =>
                GetUtils.isEmail(val ?? '') ? null : 'E-mail inválido',
          ),
          const SizedBox(height: 24),
          _buildPasswordField(context),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: const Text('Esqueceu sua senha?'),
            ),
          ),
          const SizedBox(height: 32),
          _buildSubmitButton(),
        ],
      ),
    );
  }

  Widget _buildTextField(
    BuildContext context, {
    required String label,
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, size: 20),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Senha de Acesso',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
        ),
        const SizedBox(height: 8),
        Obx(() => TextFormField(
              controller: controller.passwordController,
              obscureText: !controller.showPassword.value,
              decoration: InputDecoration(
                hintText: '••••••••',
                prefixIcon: const Icon(Icons.lock_outline_rounded, size: 20),
                suffixIcon: IconButton(
                  icon: Icon(
                    controller.showPassword.value
                        ? Icons.visibility_off_rounded
                        : Icons.visibility_rounded,
                    color: AppColors.textMuted,
                    size: 20,
                  ),
                  onPressed: controller.toggleShowPassword,
                ),
              ),
              validator: (val) =>
                  (val?.length ?? 0) >= 6 ? null : 'Mínimo 6 caracteres',
            )),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return Obx(() => Container(
          decoration: BoxDecoration(
            boxShadow: [
              if (!controller.isLoading.value)
                BoxShadow(
                  color: AppColors.accent.withOpacity(0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
            ],
          ),
          child: ElevatedButton(
            onPressed: controller.isLoading.value ? null : controller.login,
            child: controller.isLoading.value
                ? const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                        color: Colors.white, strokeWidth: 3),
                  )
                : const Text('Entrar no Sistema'),
          ),
        ));
  }

  Widget _buildFooter(BuildContext context) {
    return Column(
      children: [
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              "Precisa de acesso? ",
              style: TextStyle(color: AppColors.textSecondary),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Fale com o Administrador'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        TextButton.icon(
          onPressed: () => Get.offAllNamed(Routes.landing),
          icon: const Icon(Icons.arrow_back_rounded, size: 18),
          label: const Text('Voltar para o site público'),
        ),
      ],
    );
  }
}
