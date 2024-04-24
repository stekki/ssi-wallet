class Config {
  final int salt;
  final String certFile;
  final String keyFile;
  final bool? debug;

  Config(this.salt, this.certFile, this.keyFile, {this.debug});

  factory Config.loadMap(Map<String, dynamic> m) =>
      Config(m['salt'], m['certFile'], m['keyFile'], debug: m['debug']);
}
