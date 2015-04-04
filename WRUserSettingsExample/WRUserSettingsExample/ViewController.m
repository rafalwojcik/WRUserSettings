//
//  ViewController.m
//  WRUserSettingsExample
//
//  Created by Rafał Wójcik on 01/04/15.
//  Copyright (c) 2015 Rafał Wójcik. All rights reserved.
//

#import "ViewController.h"
#import "MyUserSetting.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UISwitch *yesOrNoSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *noOrYesSwitch;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.yesOrNoSwitch.on = [MyUserSetting shared].yesOrNo;
    self.noOrYesSwitch.on = [MyUserSetting shared].noOrYes;
}

- (IBAction)yesOrNoChange:(UISwitch *)sender {
    [MyUserSetting shared].yesOrNo = sender.on;
}

- (IBAction)noOrYesChange:(UISwitch *)sender {
    [MyUserSetting shared].noOrYes = sender.on;
}


@end
