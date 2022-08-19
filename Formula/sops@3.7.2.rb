class SopsAT372 < Formula
  desc "Editor of encrypted files"
  homepage "https://github.com/mozilla/sops"
  url "https://github.com/mozilla/sops/archive/v3.7.2.tar.gz"
  sha256 "905d0d85e6f3a36eb0586bae5c1bf501445841303e597136f69a33040f5123b2"
  license "MPL-2.0"
  head "https://github.com/mozilla/sops.git", branch: "master"

  bottle do
    root_url "https://github.com/RebelMouseTeam/homebrew-local/releases/download/sops@3.7.2-3.7.2"
    sha256 cellar: :any_skip_relocation, big_sur:      "39344c043367a596cb985005a7f2e7387c3d3d23a85a3366ce025394876cc8c4"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9a46a3a274592be105d7ae34a2f2a4c7d483f811833638f86cca578c43da0d73"
  end

  depends_on "go" => :build

  def install
    system "go", "build", "-o", bin/"sops", "go.mozilla.org/sops/v3/cmd/sops"
    pkgshare.install "example.yaml"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sops --version")

    assert_match "Recovery failed because no master key was able to decrypt the file.",
      shell_output("#{bin}/sops #{pkgshare}/example.yaml 2>&1", 128)
  end
end
