class OnboardingModel {
  final String lottieFile;
  final String title;
  final String subtitle;

  OnboardingModel(this.lottieFile, this.title, this.subtitle);
}

List<OnboardingModel> tabs = [
  OnboardingModel(
    'lib/assets/order.json',
    'Escolha um sabor',
    'Quando você fizer um pedido no \n  Eat Street, nós lhe ofereceremos \ncupons exclusivos.',
  ),
  OnboardingModel(
    'lib/assets/interaction.json',
    'Descubra lugares',
    'Nós fazemos isso simples \npara encontrar a comida que você deseja. Insira seu endereço \ne nós fazemos o resto!',
  ),
  OnboardingModel(
    'lib/assets/delivery.json',
    'Entrega rápida',
    'Tornamos os pedidos de comida \n rápidos,  simples e gratuitos - não importa da onde você faz o pedido.',
  ),
];
