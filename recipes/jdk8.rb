cookbook_file "#{Chef::Config[:file_cache_path]}/jdk-8u211-windows-x64.exe" do
  source "jdk-8u211-windows-x64.exe"
end

env 'JAVA_HOME' do
  value 'C:\\Program Files\\Java'
end

java_home_win = 'C:\\Program Files\\Java'
additional_options = "INSTALLDIR=\"#{java_home_win}\""

windows_path "#{java_home_win}\\bin" do
  action :add
end

windows_package "jdk8" do
  source "#{Chef::Config[:file_cache_path]}/jdk-8u211-windows-x64.exe"
  action :install
  installer_type :custom
  options "/s #{additional_options}"
end
