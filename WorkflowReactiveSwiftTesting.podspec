load('.workflow-version')

Pod::Spec.new do |s|
  s.name         = 'WorkflowReactiveSwiftTesting'
  s.version      = $workflow_version
  s.summary      = 'Infrastructure for Workflow-powered Swift'
  s.homepage     = 'https://www.github.com/square/workflow-swift'
  s.license      = 'Apache License, Version 2.0'
  s.author       = 'Square'
  s.source       = { :git => 'https://github.com/square/workflow-swift.git', :tag => "v#{s.version}" }

  # 1.7 is needed for `swift_versions` support
  s.cocoapods_version = '>= 1.7.0'

  s.swift_versions = ['5.0']
  s.ios.deployment_target = '10.0'
  s.osx.deployment_target = '10.12'

  s.source_files = 'WorkflowReactiveSwift/Testing/**/*.swift'

  s.dependency 'Workflow', "#{s.version}"
  s.dependency 'WorkflowReactiveSwift', "#{s.version}"
  s.dependency 'WorkflowTesting', "#{s.version}"
  s.dependency 'ReactiveSwift'

  s.framework = 'XCTest'

  s.test_spec 'WorkflowReactiveSwiftTestingTests' do |test_spec|
    test_spec.requires_app_host = true
    test_spec.source_files = 'WorkflowReactiveSwift/TestingTests/**/*.swift'
    test_spec.framework = 'XCTest'
    test_spec.dependency 'WorkflowTesting'
  end
end
