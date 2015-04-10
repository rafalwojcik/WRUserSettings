#import "TestUserSettings.h"

@implementation TestUserSettings

-(void)setDefaultsValues {
    self.stringSetting = @"TestString";
    self.integerSetting = 66;
    self.enumSetting = NSDeveloperDirectory;
    self.rectSetting = CGRectMake(2, 4, 8, 16);
    self.pointSetting = CGPointMake(32, 64);
    self.boolSetting = YES;
}

@end
