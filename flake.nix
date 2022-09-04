{
  description = "A very basic flake";

  outputs = { self, nixpkgs }: {

    packages.x86_64-linux.download_zeal_user_docsets = (with nixpkgs.legacyPackages.x86_64-linux; let 
      pythonWithPackages = (python3.withPackages (p: [ p.easygui ]));
    in stdenv.mkDerivation {
      name = "download_zeal_user_docsets";
      src = fetchzip {
        url = "https://gist.github.com/crmne/3fe84c05013fa87d74a8/archive/62c687a7fa7ea1f405e8a10d3e7bb57962cd747f.zip";
        sha256 = "sha256-Hsgx8kqNHEd+FKdwST5l5zbnsDsjF/IUH73LnT7bPqg=";
        
      };
      buildInputs = [
        pythonWithPackages
      ];
      installPhase = ''
        mkdir -p $out/bin
        echo '#!${pythonWithPackages}/bin/python3' > $out/bin/download_zeal_user_docsets 
        cat download_zeal_user_docsets.py >> $out/bin/download_zeal_user_docsets 
        chmod +x $out/bin/download_zeal_user_docsets
      '';
    });

    defaultPackage.x86_64-linux = self.packages.x86_64-linux.download_zeal_user_docsets;

  };
}
