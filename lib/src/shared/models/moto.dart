class Moto {
 dynamic buzinaStatus;
 dynamic retroDireitoEsquerdoStatus;
 dynamic farolBaixoStatus;
 dynamic farolAltoStatus;
 dynamic luzFreioStatus;
 dynamic luzPainelStatus;
 dynamic setasDianStatus;
 dynamic setasTraStatus;
 dynamic velTacoStatus;
 dynamic freiosStatus;
 dynamic pneusCalibragemStatus;
 dynamic nivelCombStatus;

  Moto(
      {this.buzinaStatus,
      this.retroDireitoEsquerdoStatus,
      this.farolBaixoStatus,
      this.farolAltoStatus,
      this.luzFreioStatus,
      this.luzPainelStatus,
      this.setasDianStatus,
      this.setasTraStatus,
      this.velTacoStatus,
      this.freiosStatus,
      this.pneusCalibragemStatus,
      this.nivelCombStatus});

  Moto.fromJson(Map<String, dynamic> json) {
    buzinaStatus = json['buzinaStatus'].cast<String>();
    retroDireitoEsquerdoStatus =
        json['retroDireitoEsquerdoStatus'].cast<String>();
    farolBaixoStatus = json['farolBaixoStatus'].cast<String>();
    farolAltoStatus = json['farolAltoStatus'].cast<String>();
    luzFreioStatus = json['luzFreioStatus'].cast<String>();
    luzPainelStatus = json['luzPainelStatus'].cast<String>();
    setasDianStatus = json['setasDianStatus'].cast<String>();
    setasTraStatus = json['setasTraStatus'].cast<String>();
    velTacoStatus = json['velTacoStatus'].cast<String>();
    freiosStatus = json['freiosStatus'].cast<String>();
    pneusCalibragemStatus = json['pneusCalibragemStatus'].cast<String>();
    nivelCombStatus = json['nivelCombStatus'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['buzinaStatus'] = buzinaStatus;
    data['retroDireitoEsquerdoStatus'] = retroDireitoEsquerdoStatus;
    data['farolBaixoStatus'] = farolBaixoStatus;
    data['farolAltoStatus'] = farolAltoStatus;
    data['luzFreioStatus'] = luzFreioStatus;
    data['luzPainelStatus'] = luzPainelStatus;
    data['setasDianStatus'] = setasDianStatus;
    data['setasTraStatus'] = setasTraStatus;
    data['velTacoStatus'] = velTacoStatus;
    data['freiosStatus'] = freiosStatus;
    data['pneusCalibragemStatus'] = pneusCalibragemStatus;
    data['nivelCombStatus'] = nivelCombStatus;
    return data;
  }
}