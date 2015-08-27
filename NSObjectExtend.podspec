Pod::Spec.new do |s|
  s.name     = 'NSObjectExtend'
  s.version  = '1.7.2'
  s.license  = { :type => 'MIT' }
  s.summary  = 'NS系列库扩充方法.'
  s.homepage = 'http://blog.isteven.cn'
  s.authors  = { 'Steven' => 'qzs21@qq.com' }
  s.source   = {
    :git => 'https://github.com/qzs21/NSObjectExtend.git',
    :tag => s.version
  }
  s.ios.deployment_target = '6.0'
  
  s.default_subspec = 'All'
  s.subspec 'All' do |spec|
    spec.source_files = 'Classes/NSObjectExtend.h'  
    spec.ios.dependency 'NSObjectExtend/Core'
    spec.ios.dependency 'NSObjectExtend/UIKit'
    spec.ios.dependency 'NSObjectExtend/CoreLocation'
  end

  s.subspec 'Core' do |spec|
    spec.libraries = 'z'
    spec.resources = 'Classes/Core/Resource/*.lproj'
    spec.requires_arc = true
    spec.source_files = [
      'Classes/Core/*.{h,m}',
    ]
  end

  s.subspec 'UIKit' do |spec|
    spec.requires_arc = true
    spec.frameworks = [
      'UIKit',
      'QuartzCore'
    ]
    spec.ios.dependency 'NSObjectExtend/Core'
    spec.source_files = [
      'Classes/UIKit/*.{h,m}',
    ]
  end

  s.subspec 'CoreLocation' do |spec|
    spec.requires_arc = true
    spec.frameworks = 'CoreLocation'
    spec.ios.dependency 'NSObjectExtend/Core'
    spec.source_files = [
      'Classes/CoreLocation/*.{h,m}',
    ]
  end

end
