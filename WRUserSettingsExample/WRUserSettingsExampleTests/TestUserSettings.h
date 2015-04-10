#import "WRUserSettings.h"
#include <CoreGraphics/CoreGraphics.h>

@interface TestUserSettings : WRUserSettings <WRUserSettingsDefaultsProtocol>

@property (nonatomic, strong) NSString *stringSetting;
@property (nonatomic, assign) NSInteger integerSetting;
@property (nonatomic, assign) NSSearchPathDirectory enumSetting;
@property (nonatomic, assign) CGRect rectSetting;
@property (nonatomic, assign) CGPoint pointSetting;
@property (nonatomic, assign) BOOL boolSetting;

@end
