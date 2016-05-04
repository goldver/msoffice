msoffice Cookbook
==================

This cookbook installs MS Office. Default version installed is MS Office 2013 64 bit <br>

Platforms
------------
Supported platforms here:

* Windows 7
* Windows 8
* Windows 8.1
* Windows 10
* Windows Server 2008 R2
* Windows Server 2012 R2

Requirements
------------
This cookbook includes and supports 'windows' and 'autosetup' cookbooks

Attributes
----------
| Key | Type | Description | Default |
| --- | ---- | ----------- | ------- |
| ['msoffice']['version'] | Array | application version | ['OFFICE2013_X64'] |
| ['msoffice']['volume'] | String | application destination volume | nil |
| ['msoffice']['source'] | String | application source | "#{ENV['HOME']}\\Downloads" |

__Please note:__The attributes which have no default are handled within the cookbook's default recipe depending on the specified versions.
<br />Current supported versions:

* OFFICE2013\_X64
* OFFICE2013\_X86

Usage
-----
#### msoffice::default
Will install Microsoft Office 2013 x64

Just include `msoffice` in your node's `run_list`:

```json
	{
	  "run_list": [
		"recipe[msoffice]"
	  ]
	}
```

If you wish to install Microsoft Office from any source, for example:"#{ENV['HOME']}\\Download":

	{
	  "msoffice": {
	    "source": "#{ENV['HOME']}\\Download"
	  }    
	}
	
If you wish to install Microsoft Office 2013 x86 (32 bit):

	{
	  "msoffice": {
	    "version": "OFFICE2013_X86"
	  }    
	}

If you wish to change destination of installation, for example, to volume E: 

	{
	  "msoffice": {
	    "volume": "E"
	  }    
	}
	
Contributing
------------
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Michael Vershinin

Support
-------------------
goldver@gmail.com