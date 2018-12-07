# vagrant-networkadapter

A Vagrant plugin to add a network adapter in HyperV


## Installation


```shell
vagrant plugin install vagrant-networkadapter
```

## Usage

Adds a new adapter to the VM. For example

```ruby
Vagrant.configure('2') do |config|
  config.vm.box = 'hashicorp/precise64'
  # Add a first adapter
  config.networkadapter.add name: "adap1", switchname: "internal"
  # Add a second adapter
  config.networkadapter.add name: "adap2", switchname: "WAN"
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

