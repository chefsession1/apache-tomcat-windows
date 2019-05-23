cookbook_file "#{Chef::Config[:file_cache_path]}/apache-tomcat-8.5.41-windows-x64.zip" do
  source "apache-tomcat-8.5.41-windows-x64.zip"
end

#unzip tomcat installer
windows_zipfile 'c:/tomcat' do
  source "#{Chef::Config[:file_cache_path]}/apache-tomcat-8.5.41-windows-x64.zip"
  action :unzip
end

#Install Tomcat as service named tomcat8 by calling service.bat install
batch "install tomcat as service" do
  cwd "C:\\tomcat\\apache-tomcat-8.5.41\\bin"
  code "service.bat install tomcat8"
end

batch "configure tomcat service" do
 cwd "C:\\tomcat\\apache-tomcat-8.5.41\\bin"
 code "tomcat8.exe //US//tomcat8 --Startup=auto --JavaHome=\"C:\\Program Files\\Java\\jre1.8.0_211\" --JvmMs=2048 --JvmMx=4096 ++JvmOptions=-Dkey=value"
end

service 'tomcat8' do
  action :start
end

#--JvmMs=2048 --JvmMx=4096 ++JvmOptions=-Dkey=value
