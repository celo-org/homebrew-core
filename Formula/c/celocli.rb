class Celocli < Formula
  desc "CLI Tool for transacting with the Celo protocol"
  homepage "https://docs.celo.org/cli"
  url "https://github.com/celo-org/developer-tooling/releases/download/%40celo%2Fcelocli%406.1.0/celocli-v6.1.0-ffdb836-darwin-x64.tar.xz"
  sha256 "b86b72f0d64920d55e3780153e99372685df84d7a6b85a124469b77f099651b6"
  version "6.1.0"
  version_scheme 1

  on_macos do
    on_arm do
      url "https://github.com/celo-org/developer-tooling/releases/download/%40celo%2Fcelocli%406.1.0/celocli-v6.1.0-ffdb836-darwin-arm64.tar.xz"
      sha256 "788eae0411a95523b12ee55b6d4aeb550eba75f8802d97109c04d991334aa0f7"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/celo-org/developer-tooling/releases/download/%40celo%2Fcelocli%406.1.0/celocli-v6.1.0-ffdb836-linux-x64.tar.xz"
      sha256 "a3a93689dce15f1e52b9696295a53baaf5ac0cad98b40ea1c2aa5bc4095b8cfe"
    end
    on_arm do
      url "https://github.com/celo-org/developer-tooling/releases/download/%40celo%2Fcelocli%406.1.0/celocli-v6.1.0-ffdb836-linux-arm.tar.xz"
      sha256 "407673a14764c3e39c78b1f103409dcc5b83e7500da1985dbcc7c49a88dfe161"
    end
  end

  def install
    inreplace "bin/celocli", /^CLIENT_HOME=/, "export CELOCLI_OCLIF_CLIENT_HOME=#{lib/"client"}\nCLIENT_HOME="
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/celocli"

    # bash_completion.install libexec/"autocomplete-scripts/brew/bash" => "celocli"
    # zsh_completion.install libexec/"autocomplete-scripts/brew/zsh/_celocli"
  end

  # def caveats; <<~EOS
  #   To use the Celo CLI's autocomplete --
  #     Via homebrew's shell completion:
  #       1) Follow homebrew's install instructions https://docs.brew.sh/Shell-Completion
  #           NOTE: For zsh, as the instructions mention, be sure compinit is autoloaded
  #                 and called, either explicitly or via a framework like oh-my-zsh.
  #       2) Then run
  #         $ celocli autocomplete --refresh-cache
  #     OR
  #     Use our standalone setup:
  #       1) Run and follow the install steps:
  #         $ celocli autocomplete
  # EOS
  # end

  test do
    system bin/"celocli", "--version"
  end
end