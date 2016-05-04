#[BASIC]
#Version installation required for msoffice.
#Accepted values: any valid version from: 'http://myftp:8080/Microsoft/Office'
#The default value is: ['OFFICE2013_X64']
default['msoffice']['version'] = ['OFFICE2013_X64']

#Source installation required for msoffice.
#The default value is: "#{ENV['HOME']}\\Download"
default['msoffice']['source'] = "#{ENV['HOME']}\\Downloads"

#[ADVANCED]
#Installation volume.
#The default value is: nil (in this case Office will be installed to default destination)
default['msoffice']['volume'] = nil






         
