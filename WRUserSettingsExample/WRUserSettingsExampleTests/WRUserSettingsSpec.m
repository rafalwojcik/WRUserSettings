#import <Specta/Specta.h>

#define EXP_SHORTHAND

#import <Expecta/Expecta.h>
#import <XCTest/XCTest.h>

#import "TestUserSettings.h"

SpecBegin(WRUserSettingsSpec)

describe(@"Test save of class properties", ^{
    beforeEach(^{
        [[TestUserSettings shared] resetSettings];
    });
    
    it(@"should save NSString", ^{
        NSString *stringToSave = @"TestString1";
        [TestUserSettings shared].stringSetting = stringToSave;
        expect([TestUserSettings shared].stringSetting).to.equal(stringToSave);
    });
    
    it(@"should save NSInteger", ^{
        NSInteger integerToSave = 99;
        [TestUserSettings shared].integerSetting = integerToSave;
        expect([TestUserSettings shared].integerSetting).to.equal(integerToSave);
    });
    
    it(@"should save enum", ^{
        NSSearchPathDirectory enumToSave = NSUserDirectory;
        [TestUserSettings shared].enumSetting = enumToSave;
        expect([TestUserSettings shared].enumSetting).to.equal(enumToSave);
    });
    
    it(@"should save CGRect", ^{
        CGRect rectToSave = CGRectMake(128, 256, 512, 1024);
        [TestUserSettings shared].rectSetting = rectToSave;
        expect([TestUserSettings shared].rectSetting.origin.x).to.equal(rectToSave.origin.x);
        expect([TestUserSettings shared].rectSetting.origin.y).to.equal(rectToSave.origin.y);
        expect([TestUserSettings shared].rectSetting.size.width).to.equal(rectToSave.size.width);
        expect([TestUserSettings shared].rectSetting.size.height).to.equal(rectToSave.size.height);
    });
    
    it(@"should save CGPoint", ^{
        CGPoint pointToSave = CGPointMake(2048, 4096);
        [TestUserSettings shared].pointSetting = pointToSave;
        expect([TestUserSettings shared].pointSetting.x).to.equal(pointToSave.x);
        expect([TestUserSettings shared].pointSetting.y).to.equal(pointToSave.y);
    });
    
    it(@"should save BOOL", ^{
        BOOL boolToSave = NO;
        [TestUserSettings shared].boolSetting = boolToSave;
        expect([TestUserSettings shared].boolSetting).to.equal(boolToSave);
    });
    
});

describe(@"Test defaults", ^{
    beforeEach(^{
        [[TestUserSettings shared] resetSettings];
    });
    
    it(@"should contains NSString default", ^{
        NSString *defaultString = [TestUserSettings shared].stringSetting;
        NSString *testString = @"TestString";
        expect(defaultString).to.equal(testString);
    });
    
    it(@"should contains NSInteger default", ^{
        NSInteger defaultInteger = [TestUserSettings shared].integerSetting;
        NSInteger testInteger = 66;
        expect(defaultInteger).to.equal(testInteger);
    });
    
    it(@"should contains NSSearchPathDirectory default", ^{
        NSSearchPathDirectory defaultEnum = [TestUserSettings shared].enumSetting;
        NSSearchPathDirectory testEnum = NSDeveloperDirectory;
        expect(defaultEnum).to.equal(testEnum);
    });
    
    it(@"should contains CGRect default", ^{
        CGRect defaultRect = [TestUserSettings shared].rectSetting;
        CGRect testRect = CGRectMake(2, 4, 8, 16);
        expect(defaultRect.origin.x).to.equal(testRect.origin.x);
        expect(defaultRect.origin.y).to.equal(testRect.origin.y);
        expect(defaultRect.size.width).to.equal(testRect.size.width);
        expect(defaultRect.size.height).to.equal(testRect.size.height);
    });
    
    it(@"should contains CGPoint default", ^{
        CGPoint defaultPoint = [TestUserSettings shared].pointSetting;
        CGPoint testPoint = CGPointMake(32, 64);
        expect(defaultPoint.x).to.equal(testPoint.x);
        expect(defaultPoint.y).to.equal(testPoint.y);
    });
    
    it(@"should contains BOOL default", ^{
        BOOL defaultBool = [TestUserSettings shared].boolSetting;
        BOOL testBool = YES;
        expect(defaultBool).to.equal(testBool);
    });
});

SpecEnd