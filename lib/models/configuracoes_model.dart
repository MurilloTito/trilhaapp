class ConfiguracoesModel {
  String nomeUsuario = '';
  double altura = 0;
  bool receberPushNotification = false;
  bool temaEscuro = false;

  ConfiguracoesModel(this.nomeUsuario, this.altura, this.receberPushNotification, this.temaEscuro);

  ConfiguracoesModel.vazio() {
    nomeUsuario = '';
    altura = 0;
    receberPushNotification = false;
    temaEscuro = false;
  }
}