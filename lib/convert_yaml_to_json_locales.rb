# Transform a YAML i18n local files into JSON object.
# suitable when using Rails YAML for javascript UI translations.
#
# This takes files DIR_ROOT/locale and outputs DIR_ROOT/js/locale
# filenames are determined by YAML filename.  
#
# Mark Young @zarzax Nov 2010
#
# Transforms YAML en.yml:
# en:
#   home:
#     link_name: 'testing'
# Into compressed JSON en.js:
# Ext.locale = {'home': {'home': {'link_name': 'testing'}}

# require 'rubygems'
# require 'json'
# require 'yaml'

DIR_ROOT = File.expand_path(File.dirname(__FILE__))
puts DIR_ROOT
YAML_ROOT = File.join(DIR_ROOT, 'locales')
JS_ROOT = File.join(DIR_ROOT, 'js', 'locales')

# locale javascript namespace
JS_NAMESPACE = 'Ext.locale = '

Dir[File.join(YAML_ROOT, '*.yml')].sort.each { |locale| 
  locale_yml = YAML::load(IO.read(locale))
  puts 'Filename: ' + locale
  puts 'Filename JSON: ' + locale_yml.to_json
  File.open(
    File.join(JS_ROOT, File.basename(locale, '.*') + '.js'), 'w') {
      |f| f.write(JS_NAMESPACE + locale_yml[File.basename(locale, '.*')].to_json)
  }
}
