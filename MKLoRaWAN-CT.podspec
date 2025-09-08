#
# Be sure to run `pod lib lint MKLoRaWAN-CT.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MKLoRaWAN-CT'
  s.version          = '0.1.0'
  s.summary          = 'A short description of MKLoRaWAN-CT.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/lovexiaoxia/MKLoRaWAN-CT'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'lovexiaoxia' => 'aadyx2007@163.com' }
  s.source           = { :git => 'https://github.com/lovexiaoxia/MKLoRaWAN-CT.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '14.0'
  
  s.resource_bundles = {
    'MKLoRaWAN-CT' => ['MKLoRaWAN-CT/Assets/*.png']
  }
  
  s.subspec 'CTMediator' do |ss|
    ss.source_files = 'MKLoRaWAN-CT/Classes/CTMediator/**'
    
    ss.dependency 'MKBaseModuleLibrary'
    
    ss.dependency 'CTMediator'
  end
  
  s.subspec 'DatabaseManager' do |ss|
    
    ss.subspec 'SyncDatabase' do |sss|
      sss.source_files = 'MKLoRaWAN-CT/Classes/DatabaseManager/SyncDatabase/**'
    end
    
    ss.subspec 'LogDatabase' do |sss|
      sss.source_files = 'MKLoRaWAN-CT/Classes/DatabaseManager/LogDatabase/**'
    end
    
    ss.dependency 'MKBaseModuleLibrary'
    
    ss.dependency 'FMDB'
  end
  
  s.subspec 'SDK' do |ss|
    ss.source_files = 'MKLoRaWAN-CT/Classes/SDK/**'
    
    ss.dependency 'MKBaseBleModule'
  end
  
  s.subspec 'Target' do |ss|
    ss.source_files = 'MKLoRaWAN-CT/Classes/Target/**'
    
    ss.dependency 'MKLoRaWAN-CT/Functions'
  end
  
  s.subspec 'ConnectModule' do |ss|
    ss.source_files = 'MKLoRaWAN-CT/Classes/ConnectModule/**'
    
    ss.dependency 'MKLoRaWAN-CT/SDK'
    
    ss.dependency 'MKBaseModuleLibrary'
  end
  
  s.subspec 'Expand' do |ss|
    
    ss.subspec 'TextButtonCell' do |sss|
      sss.source_files = 'MKLoRaWAN-CT/Classes/Expand/TextButtonCell/**'
    end
    
    ss.dependency 'MKBaseModuleLibrary'
    ss.dependency 'MKCustomUIModule'
  end
  
  s.subspec 'Functions' do |ss|
    
    ss.subspec 'AboutPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/AboutPage/Controller/**'
      end
    end
    
    ss.subspec 'AlertAlarmSettingsPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/AlertAlarmSettingsPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-CT/Functions/AlertAlarmSettingsPage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/AlertAlarmSettingsPage/Model/**'
      end
    end
    
    ss.subspec 'AlarmFunctionPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/AlarmFunctionPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-CT/Functions/AlarmFunctionPage/Model'
        ssss.dependency 'MKLoRaWAN-CT/Functions/AlarmFunctionPage/View'
        
        ssss.dependency 'MKLoRaWAN-CT/Functions/AlertAlarmSettingsPage/Controller'
        ssss.dependency 'MKLoRaWAN-CT/Functions/SosAlarmSettingsPage/Controller'
      end
      
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/AlarmFunctionPage/View/**'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/AlarmFunctionPage/Model/**'
      end
    end
    
    ss.subspec 'AuxiliaryPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/AuxiliaryPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-CT/Functions/DownlinkPage/Controller'
        ssss.dependency 'MKLoRaWAN-CT/Functions/VibrationPage/Controller'
        ssss.dependency 'MKLoRaWAN-CT/Functions/ManDownPage/Controller'
        ssss.dependency 'MKLoRaWAN-CT/Functions/AlarmFunctionPage/Controller'
        ssss.dependency 'MKLoRaWAN-CT/Functions/TempMonitorSettingsPage/Controller'
        ssss.dependency 'MKLoRaWAN-CT/Functions/LightMonitorSettingsPage/Controller'
      end
    end
    
    ss.subspec 'AxisSettingPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/AxisSettingPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-CT/Functions/AxisSettingPage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/AxisSettingPage/Model/**'
      end
    end
    
    ss.subspec 'BleFixPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/BleFixPage/Controller/**'
      
        ssss.dependency 'MKLoRaWAN-CT/Functions/BleFixPage/Model'
        ssss.dependency 'MKLoRaWAN-CT/Functions/BleFixPage/View'
      
        ssss.dependency 'MKLoRaWAN-CT/Functions/FilterByRawDataPage/Controller'
      end
    
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/BleFixPage/Model/**'
      end
    
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/BleFixPage/View/**'
      end
    end
    
    ss.subspec 'BleSettingsPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/BleSettingsPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-CT/Functions/BleSettingsPage/Model'
        ssss.dependency 'MKLoRaWAN-CT/Functions/BleSettingsPage/View'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/BleSettingsPage/Model/**'
      end
      
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/BleSettingsPage/View/**'
      end
      
    end
    
    ss.subspec 'DebuggerPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/DebuggerPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-CT/Functions/DebuggerPage/View'
      end
      
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/DebuggerPage/View/**'
      end
      
    end
    
    ss.subspec 'DeviceInfoPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/DeviceInfoPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-CT/Functions/DeviceInfoPage/Model'
        
        ssss.dependency 'MKLoRaWAN-CT/Functions/UpdatePage/Controller'
        ssss.dependency 'MKLoRaWAN-CT/Functions/SelftestPage/Controller'
        ssss.dependency 'MKLoRaWAN-CT/Functions/DebuggerPage/Controller'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/DeviceInfoPage/Model/**'
      end
      
    end
    
    ss.subspec 'DeviceModePage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/DeviceModePage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-CT/Functions/StandbyModePage/Controller'
        ssss.dependency 'MKLoRaWAN-CT/Functions/TimingModePage/Controller'
        ssss.dependency 'MKLoRaWAN-CT/Functions/PeriodicModePage/Controller'
        ssss.dependency 'MKLoRaWAN-CT/Functions/MotionModePage/Controller'
        ssss.dependency 'MKLoRaWAN-CT/Functions/TimeSegmentedModePage/Controller'
      end
    end
    
    ss.subspec 'DeviceSettingPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/DeviceSettingPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-CT/Functions/DeviceSettingPage/Model'
        
        ssss.dependency 'MKLoRaWAN-CT/Functions/IndicatorSettingsPage/Controller'
        ssss.dependency 'MKLoRaWAN-CT/Functions/DeviceInfoPage/Controller'
        ssss.dependency 'MKLoRaWAN-CT/Functions/OnOffSettingsPage/Controller'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/DeviceSettingPage/Model/**'
      end
      
    end
    
    ss.subspec 'DownlinkPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/DownlinkPage/Controller/**'
      end
    end
    
    ss.subspec 'FilterByRawDataPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/FilterByRawDataPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-CT/Functions/FilterByRawDataPage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/FilterByRawDataPage/Model/**'
      end
      
    end
    
    ss.subspec 'GeneralPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/GeneralPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-CT/Functions/GeneralPage/Model'
        
        ssss.dependency 'MKLoRaWAN-CT/Functions/DeviceModePage/Controller'
        ssss.dependency 'MKLoRaWAN-CT/Functions/AuxiliaryPage/Controller'
        ssss.dependency 'MKLoRaWAN-CT/Functions/BleSettingsPage/Controller'
        ssss.dependency 'MKLoRaWAN-CT/Functions/AxisSettingPage/Controller'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/GeneralPage/Model/**'
      end
      
    end
    
    ss.subspec 'IndicatorSettingsPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/IndicatorSettingsPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-CT/Functions/IndicatorSettingsPage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/IndicatorSettingsPage/Model/**'
      end
      
    end
    
    ss.subspec 'LCGpsFixPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/LCGpsFixPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-CT/Functions/LCGpsFixPage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/LCGpsFixPage/Model/**'
      end
      
    end
    
    ss.subspec 'LightMonitorSettingsPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/LightMonitorSettingsPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-CT/Functions/LightMonitorSettingsPage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/LightMonitorSettingsPage/Model/**'
      end
      
    end
    
    ss.subspec 'LoRaApplicationPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/LoRaApplicationPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-CT/Functions/LoRaApplicationPage/Model'
        
        ssss.dependency 'MKLoRaWAN-CT/Functions/MessageTypePage/Controller'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/LoRaApplicationPage/Model/**'
      end
      
    end
    
    ss.subspec 'LoRaPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/LoRaPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-CT/Functions/LoRaPage/Model'
        
        ssss.dependency 'MKLoRaWAN-CT/Functions/LoRaSettingPage/Controller'
        ssss.dependency 'MKLoRaWAN-CT/Functions/LoRaApplicationPage/Controller'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/LoRaPage/Model/**'
      end
      
    end
    
    ss.subspec 'LoRaSettingPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/LoRaSettingPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-CT/Functions/LoRaSettingPage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/LoRaSettingPage/Model/**'
      end
      
    end
    
    ss.subspec 'ManDownPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/ManDownPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-CT/Functions/ManDownPage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/ManDownPage/Model/**'
      end
    end
    
    ss.subspec 'MessageTypePage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/MessageTypePage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-CT/Functions/MessageTypePage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/MessageTypePage/Model/**'
      end
    end
    
    ss.subspec 'MotionModePage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/MotionModePage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-CT/Functions/MotionModePage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/MotionModePage/Model/**'
      end
      
    end
    
    ss.subspec 'OnOffSettingsPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/OnOffSettingsPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-CT/Functions/OnOffSettingsPage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/OnOffSettingsPage/Model/**'
      end
      
    end
    
    ss.subspec 'OutdoorFixPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/OutdoorFixPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-CT/Functions/OutdoorFixPage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/OutdoorFixPage/Model/**'
      end
      
    end
    
    ss.subspec 'PeriodicModePage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/PeriodicModePage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-CT/Functions/PeriodicModePage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/PeriodicModePage/Model/**'
      end
      
    end
    
    ss.subspec 'PositionPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/PositionPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-CT/Functions/PositionPage/Model'
                        
        ssss.dependency 'MKLoRaWAN-CT/Functions/BleFixPage/Controller'
        ssss.dependency 'MKLoRaWAN-CT/Functions/LCGpsFixPage/Controller'
        ssss.dependency 'MKLoRaWAN-CT/Functions/OutdoorFixPage/Controller'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/PositionPage/Model/**'
      end
      
    end
    
    ss.subspec 'ScanPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/ScanPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-CT/Functions/ScanPage/Model'
        ssss.dependency 'MKLoRaWAN-CT/Functions/ScanPage/View'
        
        ssss.dependency 'MKLoRaWAN-CT/Functions/TabBarPage/Controller'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/ScanPage/Model/**'
      end
      
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/ScanPage/View/**'
        ssss.dependency 'MKLoRaWAN-CT/Functions/ScanPage/Model'
      end
    end
    
    ss.subspec 'SelftestPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/SelftestPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-CT/Functions/SelftestPage/View'
        ssss.dependency 'MKLoRaWAN-CT/Functions/SelftestPage/Model'
      end
      
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/SelftestPage/View/**'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/SelftestPage/Model/**'
      end
    end
    
    ss.subspec 'SosAlarmSettingsPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/SosAlarmSettingsPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-CT/Functions/SosAlarmSettingsPage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/SosAlarmSettingsPage/Model/**'
      end
    end
    
    ss.subspec 'StandbyModePage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/StandbyModePage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-CT/Functions/StandbyModePage/Model'
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/StandbyModePage/Model/**'
      end
    end
    
    ss.subspec 'TabBarPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/TabBarPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-CT/Functions/LoRaPage/Controller'
        ssss.dependency 'MKLoRaWAN-CT/Functions/PositionPage/Controller'
        ssss.dependency 'MKLoRaWAN-CT/Functions/GeneralPage/Controller'
        ssss.dependency 'MKLoRaWAN-CT/Functions/DeviceSettingPage/Controller'
      end
    end
    
    ss.subspec 'TempMonitorSettingsPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/TempMonitorSettingsPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-CT/Functions/TempMonitorSettingsPage/Model'
        ssss.dependency 'MKLoRaWAN-CT/Functions/TempMonitorSettingsPage/View'
        
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/TempMonitorSettingsPage/Model/**'
      end
      
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/TempMonitorSettingsPage/View/**'
      end
    end
    
    ss.subspec 'TimeSegmentedModePage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/TimeSegmentedModePage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-CT/Functions/TimeSegmentedModePage/Model'
        ssss.dependency 'MKLoRaWAN-CT/Functions/TimeSegmentedModePage/View'
        
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/TimeSegmentedModePage/Model/**'
      end
      
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/TimeSegmentedModePage/View/**'
      end
    end
    
    ss.subspec 'TimingModePage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/TimingModePage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-CT/Functions/TimingModePage/Model'
        ssss.dependency 'MKLoRaWAN-CT/Functions/TimingModePage/View'
        
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/TimingModePage/Model/**'
      end
      
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/TimingModePage/View/**'
      end
    end
    
    ss.subspec 'UpdatePage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/UpdatePage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-CT/Functions/UpdatePage/Model'
        
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/UpdatePage/Model/**'
      end
    end
    
    ss.subspec 'VibrationPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/VibrationPage/Controller/**'
        
        ssss.dependency 'MKLoRaWAN-CT/Functions/VibrationPage/Model'
        
      end
      
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKLoRaWAN-CT/Classes/Functions/VibrationPage/Model/**'
      end
    end
    
    ss.dependency 'MKLoRaWAN-CT/SDK'
    ss.dependency 'MKLoRaWAN-CT/DatabaseManager'
    ss.dependency 'MKLoRaWAN-CT/CTMediator'
    ss.dependency 'MKLoRaWAN-CT/ConnectModule'
    ss.dependency 'MKLoRaWAN-CT/Expand'
    
    ss.dependency 'MKBaseModuleLibrary'
    ss.dependency 'MKCustomUIModule'
    ss.dependency 'MKFilterPagesModule'
    
    ss.dependency 'HHTransition'
    ss.dependency 'MLInputDodger'
    ss.dependency 'iOSDFULibrary',   '4.13.0'
    
  end
  
end
