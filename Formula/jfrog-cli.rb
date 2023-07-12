class JfrogCli < Formula
  desc "Command-line interface for JFrog products"
  homepage "https://www.jfrog.com/confluence/display/CLI/JFrog+CLI"
  url "https://github.com/jfrog/jfrog-cli/archive/refs/tags/v2.43.1.tar.gz"
  sha256 "30fef29caf9677d1e764a2bd88e3fb2d033f0f58eb575f1d2a4b7360bf5b9c5d"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "112e85209576821537fd0789391ad57a9a0e21583f8b996a0432c62eb7dc039f"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "112e85209576821537fd0789391ad57a9a0e21583f8b996a0432c62eb7dc039f"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "112e85209576821537fd0789391ad57a9a0e21583f8b996a0432c62eb7dc039f"
    sha256 cellar: :any_skip_relocation, ventura:        "66e581e50e7b3138cd53e1bd57da360ab7a78f6fd0a25f759f4d4f667001b0bf"
    sha256 cellar: :any_skip_relocation, monterey:       "66e581e50e7b3138cd53e1bd57da360ab7a78f6fd0a25f759f4d4f667001b0bf"
    sha256 cellar: :any_skip_relocation, big_sur:        "66e581e50e7b3138cd53e1bd57da360ab7a78f6fd0a25f759f4d4f667001b0bf"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d4d679329b33ff242f8e4865376908e3f7a5371f232b4c4356fd9d588ae21f6a"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w", output: bin/"jf")
    bin.install_symlink "jf" => "jfrog"

    generate_completions_from_executable(bin/"jf", "completion", base_name: "jf")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/jf -v")
    assert_match version.to_s, shell_output("#{bin}/jfrog -v")
    with_env(JFROG_CLI_REPORT_USAGE: "false", CI: "true") do
      assert_match "build name must be provided in order to generate build-info",
        shell_output("#{bin}/jf rt bp --dry-run --url=http://127.0.0.1 2>&1", 1)
    end
  end
end
