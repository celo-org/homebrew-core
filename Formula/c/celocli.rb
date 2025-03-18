class Celocli < Formula
  desc "CLI Tool for transacting with the Celo protocol"
  homepage "https://docs.celo.org/cli"
  url "https://github.com/celo-org/developer-tooling/releases/download/%40celo%2Fcelocli%406.1.0/celocli-v6.1.0-8a5df10-darwin-x64.tar.xz"
  sha256 "e05714f26069ed518f6dd3b2a4ee5365c63a8a1a1774a04066afef7839b3e724"
  version "6.1.0"
  version_scheme 1

  on_macos do
    on_arm do
      url "https://github.com/celo-org/developer-tooling/releases/download/%40celo%2Fcelocli%406.1.0/celocli-v6.1.0-8a5df10-darwin-arm64.tar.xz"
      sha256 "07b8eaa6f8c68ab12705758f5fe6e12099b243349b6148535e727f56f3d0cc17"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/celo-org/developer-tooling/releases/download/%40celo%2Fcelocli%406.1.0/celocli-v6.1.0-8a5df10-linux-x64.tar.xz"
      sha256 "56703e9408ab99e30eb3ee1ddcdd234185799adee6cb816acd57565239f29d37"
    end
    on_arm do
      url "https://github.com/celo-org/developer-tooling/releases/download/%40celo%2Fcelocli%406.1.0/celocli-v6.1.0-8a5df10-linux-arm.tar.xz"
      sha256 "c30ce495bbc1639f447e8f7541dffdeac573afed55da61b1dc81996ac5ebf6bf"
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