{ stdenv, fetchgit }:

let version = "1.0"; in
stdenv.mkDerivation {
  version = "${version}";
  name = "feather-font-${version}"; 

  src = fetchgit {
	url = "https://github.com/dustinlyons/feather-font.git";
	rev = "refs/tags/${version}";
	sparseCheckout = [
		"feather.ttf"
	];
	hash = "sha256-Zsz8/qn7XAG6BVp4XdqooEqioFRV7bLH0bQkHZvFbsg=";
  };

  installPhase = ''
    mkdir -p $out/usr/local/share/fonts
    install -m444 ./feather.ttf $out/usr/local/share/fonts
  '';
}
