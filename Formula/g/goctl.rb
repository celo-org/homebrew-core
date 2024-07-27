class Goctl < Formula
  desc "Generates server-side and client-side code for web and RPC services"
  homepage "https://go-zero.dev"
  url "https://github.com/zeromicro/go-zero/archive/refs/tags/tools/goctl/v1.7.0.tar.gz"
  sha256 "ec494c7527a9805a5d330df212b2e38b9389c81e9dcb48089c3e6a0ba10beef2"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "9ff7f0ccb6ce4139d3d313dcc5583edfb17f437e57a06bbbbf41aecc4123a484"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "3aacb67ebb74852141bf5520518818075fcabfee3250fda7914f51780ca2a936"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "c856e386f3988a63f86dabcce99cf6aa9b24dd2e193728c829902dd635cdb1a5"
    sha256 cellar: :any_skip_relocation, sonoma:         "834725c1d093c849852ef3a0a470a2d7aa2c8a5d176699d29de142bfbf95f18d"
    sha256 cellar: :any_skip_relocation, ventura:        "61db7787885f0e7ffab4ca2bcaaa480c7d2aa7e6289204f538a5af5b56340a67"
    sha256 cellar: :any_skip_relocation, monterey:       "a3e7d510c4188da7313ea0e13d987962c7185079988ff9dcbe0b3339b1838a60"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "dec21f4b52ddebd61a69fb30846534d5dad860abb55dc1403ef1636b7472b8af"
  end

  depends_on "go" => :build

  # patch go.mod/go.sum, upstream patch PR, https://github.com/zeromicro/go-zero/pull/4279
  patch do
    url "https://github.com/zeromicro/go-zero/commit/481c9e6a604da0bdfaf1a8f383a897ef4b3b7ef2.patch?full_index=1"
    sha256 "8c34eba9e5f423f6c9da9fbe180867b9d71cdf214984c475ab53581d487c901c"
  end

  def install
    chdir "tools/goctl" do
      system "go", "build", *std_go_args(ldflags: "-s -w"), "goctl.go"
    end

    generate_completions_from_executable(bin/"goctl", "completion")
  end

  test do
    assert_match "goctl version #{version}", shell_output("#{bin}/goctl --version")
    # configure project path
    %w[api model rpc docker kube mongo newapi gateway].each do |f|
      mkdir_p testpath/"#{version}/#{f}"
    end
    system bin/"goctl", "template", "init", "--home=#{testpath}"
    assert_predicate testpath/"api/main.tpl", :exist?, "goctl install fail"
  end
end
