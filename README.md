# vagrant-networkadapter

A Vagrant plugin to add a network adapter in HyperV


## Installation


```shell
vagrant plugin install vagrant-networkadapter
```

## Usage

Set the size you want for your disk in your Vagrantfile. For example

```ruby
Vagrant.configure('2') do |config|
  config.vm.box = 'ubuntu/xenial64'
  config.networkadapter.size = 10 * 1024 # size in megabytes
  config.networkadapter.path = "/tmp/your-file.vdi"
end
```

## Contributing

1. Fork it
2. Create your feature branch (`$ git checkout -b my-new-feature`)
3. Commit your changes (`$ git commit -am 'Add some feature'`)
4. Push to the branch (`$ git push origin my-new-feature`)
5. Create new Pull Request

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

