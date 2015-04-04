//
//  WRUserSettings.m
//  WRUserSettingsExample
//
//  Created by Rafał Wójcik on 01/04/15.
//  Copyright (c) 2015 Rafał Wójcik. All rights reserved.
//

#import "WRUserSettings.h"
#import <objc/runtime.h>

static NSString * const kUserDefaultsUniqueIdentifierKey = @"kUserDefaultsUniqueIdentifierKeyForWRUserSettings";
static NSString * const singletonBaseClassName = @"WRUserSettings";
static NSMutableDictionary *singletonDictionary = nil;

@interface WRUserSettings()

@property (nonatomic, strong) NSString *uniqueIdentifier;

@end

@implementation WRUserSettings

- (instancetype)init {
    if (self = [super init]) {
        [self p_setupDefaultValues];
        id settingsClass = objc_getClass(class_getName([self class]));
        unsigned int outCount, i;
        objc_property_t *properties = class_copyPropertyList(settingsClass, &outCount);
        for (i = 0; i < outCount; i++) {
            objc_property_t property = properties[i];
            NSString *propertyName = [NSString stringWithFormat:@"%s", property_getName(property)];
            [self p_fillFromUserDefaultsPropertyForKeyPath:propertyName];
            [self p_addObserverForPropertyKeyPath:propertyName];
        }
    }
    return self;
}

- (void)p_setupDefaultValues {
    if ([self conformsToProtocol:@protocol(WRUserSettingsDefaultsProtocol)]) {
        [self performSelector:@selector(setDefaultsValues)];
    }
}

#pragma mark KVO

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    id obj = [self valueForKeyPath:keyPath];
    NSData *archivedObject = [NSKeyedArchiver archivedDataWithRootObject:obj];
    [[NSUserDefaults standardUserDefaults] setObject:archivedObject forKey:[self p_userDefaultsKeyForKeyPath:keyPath]];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)p_userDefaultsKeyForKeyPath:(NSString *)keyPath {
    return [NSString stringWithFormat:@"%@.%@", self.uniqueIdentifier, keyPath];
}

- (void)p_addObserverForPropertyKeyPath:(NSString *)propertyName {
    [self addObserver:self forKeyPath:propertyName options:NSKeyValueObservingOptionNew context:nil];
}

- (void)p_fillFromUserDefaultsPropertyForKeyPath:(NSString *)keyPath {
    NSData *archivedObject = [[NSUserDefaults standardUserDefaults] objectForKey:[self p_userDefaultsKeyForKeyPath:keyPath]];
    if (archivedObject) {
        id value = [NSKeyedUnarchiver unarchiveObjectWithData:archivedObject];
        [self setValue:value forKeyPath:keyPath];
    }
}

#pragma mark Unique Identifier

- (NSString *)uniqueIdentifier {
    if (!_uniqueIdentifier) {
        NSString *identifier = [[NSUserDefaults standardUserDefaults] stringForKey:kUserDefaultsUniqueIdentifierKey];
        if (!identifier) {
            identifier = [self p_uuid];
            [[NSUserDefaults standardUserDefaults] setObject:identifier forKey:kUserDefaultsUniqueIdentifierKey];
            
        }
        _uniqueIdentifier = identifier;
    }
    return _uniqueIdentifier;
}

- (NSString *)p_uuid {
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef uuidStringRef = CFUUIDCreateString(NULL, uuidRef);
    CFRelease(uuidRef);
    return (__bridge_transfer NSString *)uuidStringRef;
}

#pragma mark Singleton

+ (instancetype)shared {
    NSString *childClass = NSStringFromClass([self class]);
    NSAssert(![singletonBaseClassName isEqualToString:childClass], @"You can't use plain '%@', make subclass of it.", childClass);
    @synchronized(self) {
        if (!singletonDictionary) { singletonDictionary = [@{} mutableCopy]; }
        if (![singletonDictionary objectForKey:childClass]) {
            id singletonObject = [[self alloc] init];
            [singletonDictionary setObject:singletonObject forKey:childClass];
        }
    }
    return [singletonDictionary objectForKey:childClass];
}

+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        id sharedInstance = [singletonDictionary objectForKey:NSStringFromClass([self class])];
        if (sharedInstance == nil) {
            sharedInstance = [super allocWithZone:zone];
            return sharedInstance;
        }
    }
    return nil;
}

#pragma mark Description

- (NSString *)description {
    NSMutableDictionary *settingsDictionary = [@{} mutableCopy];
    [[[NSUserDefaults standardUserDefaults] dictionaryRepresentation] enumerateKeysAndObjectsUsingBlock:^(NSString *key, id obj, BOOL *stop) {
        NSString *settingsPrefix = [NSString stringWithFormat:@"%@.", self.uniqueIdentifier];
        if ([key hasPrefix:settingsPrefix]) {
            NSString *modifiedKey = [key stringByReplacingOccurrencesOfString:settingsPrefix withString:@""];
            id unarchivedObject = [NSKeyedUnarchiver unarchiveObjectWithData:obj];
            [settingsDictionary setObject:unarchivedObject forKey:modifiedKey];
        }
    }];
    return [settingsDictionary description];
}

@end
