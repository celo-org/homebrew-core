class Celocli < Formula
  desc "CLI Tool for interacting with the Celo protocol"
  homepage "https://docs.celo.org/cli"
  url "https://registry.npmjs.org/@celo/celocli/-/celocli-6.1.0.tgz"
  sha256 "2fc966f2a1f8ed7a56cfe9b15d5a3a85d5b8668ea371c6179c56bf3f5b56e957"
  license "Apache-2.0"
  version_scheme 1

  # required by node-gyp
  depends_on "libusb" => :build
  depends_on "pkgconf" => :build
  depends_on "python@3.11" => :build
  depends_on "systemd" => :build
  depends_on "node@20"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]

    # Replace universal binaries with their native slices.
    deuniversalize_machos
  end

  test do
    system bin/"celocli", "account:new --language=french"
  end
end
