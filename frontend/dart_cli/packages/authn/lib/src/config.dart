class Config {
  final int salt;
  final String certFile;
  final String keyFile;

  Config(this.salt, this.certFile, this.keyFile);

  factory Config.loadMap(Map<String, dynamic> m) =>
      Config(m['salt'], m['certFile'], m['keyFile']);
}
