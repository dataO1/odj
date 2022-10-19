project('odj', 'cpp', version: '0.0.1')

project_source_files = [
  'src/main.cpp'
]

### Usually dependencies, that are installed as system packages are found via
#the dependency() method, which uses pkgs-config. But when using a local
#installation of a library we need to use find_library(), which searches
#locally.
project_dependencies = [
  # dependency('libavformat'),
  meson.get_compiler('cpp').find_library('audiorw')
]

project_target = executable(
  meson.project_name(),
  project_source_files,
  dependencies: project_dependencies,
  install : true,
)
