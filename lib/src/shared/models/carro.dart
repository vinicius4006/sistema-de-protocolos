class Carro {
  List<String>? buzinaStatus;
  List<String>? cintoSegurancaStatus;
  List<String>? quebraSol;
  List<String>? retroInternoStatus;
  List<String>? retroDireitoEsquerdoStatus;
  List<String>? limpParaBrisaStatus;
  List<String>? limpParaBrisaTrStatus;
  List<String>? farolBaixoStatus;
  List<String>? farolAltoStatus;
  List<String>? meiaLuzStatus;
  List<String>? luzFreioStatus;
  List<String>? luzReStatus;
  List<String>? luzPlacaStatus;
  List<String>? luzPainelStatus;
  List<String>? setasDianStatus;
  List<String>? setasTraStatus;
  List<String>? piscaAlertaStatus;
  List<String>? luzInternaStatus;
  List<String>? velTacoStatus;
  List<String>? freiosStatus;
  List<String>? macacoStatus;
  List<String>? chaveRodaStatus;
  List<String>? trianguloStatus;
  List<String>? extintorStatus;
  List<String>? portasTravasStatus;
  List<String>? alarmeStatus;
  List<String>? fechaJanelasStatus;
  List<String>? paraBrisaStatus;
  List<String>? pneusEstadoStatus;
  List<String>? pneusReservaStatus;
  List<String>? pneusCalibragemStatus;
  List<String>? bancosEncostoStatus;
  List<String>? paraChoqueDianStatus;
  List<String>? paraChoqueTraStatus;
  List<String>? latariaStatus;
  List<String>? nivelCombStatus;
  List<String>? longarinaStatus;

  Carro(
      {this.buzinaStatus,
      this.cintoSegurancaStatus,
      this.quebraSol,
      this.retroInternoStatus,
      this.retroDireitoEsquerdoStatus,
      this.limpParaBrisaStatus,
      this.limpParaBrisaTrStatus,
      this.farolBaixoStatus,
      this.farolAltoStatus,
      this.meiaLuzStatus,
      this.luzFreioStatus,
      this.luzReStatus,
      this.luzPlacaStatus,
      this.luzPainelStatus,
      this.setasDianStatus,
      this.setasTraStatus,
      this.piscaAlertaStatus,
      this.luzInternaStatus,
      this.velTacoStatus,
      this.freiosStatus,
      this.macacoStatus,
      this.chaveRodaStatus,
      this.trianguloStatus,
      this.extintorStatus,
      this.portasTravasStatus,
      this.alarmeStatus,
      this.fechaJanelasStatus,
      this.paraBrisaStatus,
      this.pneusEstadoStatus,
      this.pneusReservaStatus,
      this.pneusCalibragemStatus,
      this.bancosEncostoStatus,
      this.paraChoqueDianStatus,
      this.paraChoqueTraStatus,
      this.latariaStatus,
      this.nivelCombStatus,
      this.longarinaStatus});

  Carro.fromJson(Map<String, dynamic> json) {
    buzinaStatus = json['buzinaStatus'].cast<String>();
    cintoSegurancaStatus = json['cintoSegurancaStatus'].cast<String>();
    quebraSol = json['quebraSol'].cast<String>();
    retroInternoStatus = json['retroInternoStatus'].cast<String>();
    retroDireitoEsquerdoStatus =
        json['retroDireitoEsquerdoStatus'].cast<String>();
    limpParaBrisaStatus = json['limpParaBrisaStatus'].cast<String>();
    limpParaBrisaTrStatus = json['limpParaBrisaTrStatus'].cast<String>();
    farolBaixoStatus = json['farolBaixoStatus'].cast<String>();
    farolAltoStatus = json['farolAltoStatus'].cast<String>();
    meiaLuzStatus = json['meiaLuzStatus'].cast<String>();
    luzFreioStatus = json['luzFreioStatus'].cast<String>();
    luzReStatus = json['luzReStatus'].cast<String>();
    luzPlacaStatus = json['luzPlacaStatus'].cast<String>();
    luzPainelStatus = json['luzPainelStatus'].cast<String>();
    setasDianStatus = json['setasDianStatus'].cast<String>();
    setasTraStatus = json['setasTraStatus'].cast<String>();
    piscaAlertaStatus = json['piscaAlertaStatus'].cast<String>();
    luzInternaStatus = json['luzInternaStatus'].cast<String>();
    velTacoStatus = json['velTacoStatus'].cast<String>();
    freiosStatus = json['freiosStatus'].cast<String>();
    macacoStatus = json['macacoStatus'].cast<String>();
    chaveRodaStatus = json['chaveRodaStatus'].cast<String>();
    trianguloStatus = json['trianguloStatus'].cast<String>();
    extintorStatus = json['extintorStatus'].cast<String>();
    portasTravasStatus = json['portasTravasStatus'].cast<String>();
    alarmeStatus = json['alarmeStatus'].cast<String>();
    fechaJanelasStatus = json['fechaJanelasStatus'].cast<String>();
    paraBrisaStatus = json['paraBrisaStatus'].cast<String>();
    pneusEstadoStatus = json['pneusEstadoStatus'].cast<String>();
    pneusReservaStatus = json['pneusReservaStatus'].cast<String>();
    pneusCalibragemStatus = json['pneusCalibragemStatus'].cast<String>();
    bancosEncostoStatus = json['bancosEncostoStatus'].cast<String>();
    paraChoqueDianStatus = json['paraChoqueDianStatus'].cast<String>();
    paraChoqueTraStatus = json['paraChoqueTraStatus'].cast<String>();
    latariaStatus = json['latariaStatus'].cast<String>();
    nivelCombStatus = json['nivelCombStatus'].cast<String>();
    longarinaStatus = json['longarinaStatus'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['buzinaStatus'] = buzinaStatus;
    data['cintoSegurancaStatus'] = cintoSegurancaStatus;
    data['quebraSol'] = quebraSol;
    data['retroInternoStatus'] = retroInternoStatus;
    data['retroDireitoEsquerdoStatus'] = retroDireitoEsquerdoStatus;
    data['limpParaBrisaStatus'] = limpParaBrisaStatus;
    data['limpParaBrisaTrStatus'] = limpParaBrisaTrStatus;
    data['farolBaixoStatus'] = farolBaixoStatus;
    data['farolAltoStatus'] = farolAltoStatus;
    data['meiaLuzStatus'] = meiaLuzStatus;
    data['luzFreioStatus'] = luzFreioStatus;
    data['luzReStatus'] = luzReStatus;
    data['luzPlacaStatus'] = luzPlacaStatus;
    data['luzPainelStatus'] = luzPainelStatus;
    data['setasDianStatus'] = setasDianStatus;
    data['setasTraStatus'] = setasTraStatus;
    data['piscaAlertaStatus'] = piscaAlertaStatus;
    data['luzInternaStatus'] = luzInternaStatus;
    data['velTacoStatus'] = velTacoStatus;
    data['freiosStatus'] = freiosStatus;
    data['macacoStatus'] = macacoStatus;
    data['chaveRodaStatus'] = chaveRodaStatus;
    data['trianguloStatus'] = trianguloStatus;
    data['extintorStatus'] = extintorStatus;
    data['portasTravasStatus'] = portasTravasStatus;
    data['alarmeStatus'] = alarmeStatus;
    data['fechaJanelasStatus'] = fechaJanelasStatus;
    data['paraBrisaStatus'] = paraBrisaStatus;
    data['pneusEstadoStatus'] = pneusEstadoStatus;
    data['pneusReservaStatus'] = pneusReservaStatus;
    data['pneusCalibragemStatus'] = pneusCalibragemStatus;
    data['bancosEncostoStatus'] = bancosEncostoStatus;
    data['paraChoqueDianStatus'] = paraChoqueDianStatus;
    data['paraChoqueTraStatus'] = paraChoqueTraStatus;
    data['latariaStatus'] = latariaStatus;
    data['nivelCombStatus'] = nivelCombStatus;
    data['longarinaStatus'] = longarinaStatus;
    return data;
  }
}