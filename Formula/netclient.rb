class Netclient < Formula
  desc "A platform for modern, blazing fast virtual networks"
  homepage "https://github.com/gravitl/netmaker"
  version "0.14.3"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/gravitl/netmaker/releases/download/v0.14.3/netclient-darwin"
      sha256 "42d3ad9ee44e4b748becacb0d77e4f162f4d9a189f1c1ddc378f101dea437b9f"
    end
    if Hardware::CPU.arm?
      url "https://github.com/gravitl/netmaker/releases/download/v0.14.3/netclient-darwin-arm64"
      sha256 "42d3ad9ee44e4b748becacb0d77e4f162f4d9a189f1c1ddc378f101dea437b9f"
    end
  end

  depends_on "wireguard-tools"

  def install
    if Hardware::CPU.intel?
      bin.install "netclient-darwin" => "netclient"
    end
    if Hardware::CPU.arm?
      bin.install "netclient-darwin-arm64" => "netclient"
    end
  end

  service do
    run [opt_bin/"netclient", "daemon"]
    keep_alive true
    run_type :immediate
    environment_variables PATH: std_service_path_env
    log_path "/var/log/netclient.log"
    error_log_path "/var/log/netclient.log"
  end
end
