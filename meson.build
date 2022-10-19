project('odj', 'cpp', version: '0.0.1')

project_source_files = [
  'src/main.cpp'
]

project_dependencies = [
  dependency('libpulse')
]

project_target = executable(
  meson.project_name(),
  project_source_files,
  dependencies: project_dependencies,
  install : true,
)
