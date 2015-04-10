//
//  WRUserSettings.h
//  WRUserSettingsExample
//
//  Created by Rafał Wójcik on 01/04/15.
//  Copyright (c) 2015 Rafał Wójcik. All rights reserved.
//

#import <Foundation/Foundation.h>

// implement this protocol in subclass if you want set own default values
@protocol WRUserSettingsDefaultsProtocol <NSObject>
- (void)setDefaultsValues;
@end

@interface WRUserSettings : NSObject
+ (instancetype)shared;
- (void)resetSettings;
@end
