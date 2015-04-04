//
//  MyUserSetting.h
//  WRUserSettingsExample
//
//  Created by Rafał Wójcik on 04/04/15.
//  Copyright (c) 2015 Rafał Wójcik. All rights reserved.
//

#import "WRUserSettings.h"
#import <CoreGraphics/CoreGraphics.h>

@interface MyUserSetting : WRUserSettings <WRUserSettingsDefaultsProtocol>

@property (nonatomic, assign) BOOL yesOrNo;
@property (nonatomic, assign) BOOL noOrYes;
@property (nonatomic, assign) CGFloat viewPositionX;
@property (nonatomic, assign) CGFloat viewPositionY;

@end
