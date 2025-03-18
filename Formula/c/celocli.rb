class Celocli < Formula
  desc "CLI Tool for interacting with the Celo protocol"
  homepage "https://docs.celo.org/cli"
  url "https://github.com/celo-org/developer-tooling/releases/download/%40celo%2Fcelocli%406.1.0/celocli-v6.1.0-8a5df10-darwin-x64.tar.xz"
  sha256 "6fb41ee26cee95b677d546620236a30c5f2ae95e2fa2afc2fb1e2d22243a6218"
  version "6.1.0"
  version_scheme 1

  on_macos do
    on_arm do
      url "https://github.com/celo-org/developer-tooling/releases/download/%40celo%2Fcelocli%406.1.0/celocli-v6.1.0-8a5df10-darwin-arm64.tar.xz"
      sha256 "fe3668d6b915d8b5d0caa8ff216e102037766087422dfac6b15f3e3fc454a6aa"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/celo-org/developer-tooling/releases/download/%40celo%2Fcelocli%406.1.0/celocli-v6.1.0-8a5df10-linux-x64.tar.xz"
      sha256 "31192542b5d10f8150056f1dea77201564796ede1e83a11d6cb2b52c574e445c"
    end
    on_arm do
      url "https://github.com/celo-org/developer-tooling/releases/download/%40celo%2Fcelocli%406.1.0/celocli-v6.1.0-8a5df10-linux-arm.tar.xz"
      sha256 "18d0bd65ce47db1475de89aa499c5134e11e42d1594bfcf81b52f5d9c856e330"
    end
  end

  def install
    inreplace "bin/celocli", /^CLIENT_HOME=/, "export CELOCLI_OCLIF_CLIENT_HOME=#{lib/"client"}\nCLIENT_HOME="
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/celocli"
  end

  test do
    system bin/"celocli", "--version"
  end
end