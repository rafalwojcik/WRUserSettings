//
//  DragAndScaleView.m
//  WRUserSettingsExample
//
//  Created by Rafał Wójcik on 04/04/15.
//  Copyright (c) 2015 Rafał Wójcik. All rights reserved.
//

#import "DragAreaView.h"
#import "MyUserSetting.h"

@interface DragAreaView()

@property (nonatomic, strong) UIView *viewToChange;
@property (nonatomic, assign) CGPoint handlePoint;

@end

@implementation DragAreaView

- (void)awakeFromNib {
    CGPoint viewPosition = [MyUserSetting shared].viewPosition;
    self.viewToChange = [[UIView alloc] initWithFrame:CGRectMake(viewPosition.x, viewPosition.y, 100.0f, 100.0f)];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
    [self.viewToChange addGestureRecognizer:panGesture];
    
    self.viewToChange.backgroundColor = [UIColor blueColor];
    
    [self addSubview:self.viewToChange];
}

- (void)panView:(UIPanGestureRecognizer *)panGesture {
    if (panGesture.state == UIGestureRecognizerStateBegan) {
        self.handlePoint = [panGesture locationInView:panGesture.view];
    } else if (panGesture.state == UIGestureRecognizerStateChanged) {
        CGPoint locationInSuperView = [panGesture locationInView:self];
        CGRect newFrame = panGesture.view.frame;
        CGPoint origin = CGPointMake(locationInSuperView.x - self.handlePoint.x, locationInSuperView.y - self.handlePoint.y);
        
        origin.x = origin.x <= 0.0f ? 0.0f : origin.x;
        origin.x = origin.x >= CGRectGetWidth(self.frame) - CGRectGetWidth(panGesture.view.frame) ? CGRectGetWidth(self.frame) - CGRectGetWidth(panGesture.view.frame) : origin.x;
        origin.y = origin.y <= 0.0f ? 0.0f : origin.y;
        origin.y = origin.y >= CGRectGetHeight(self.frame) - CGRectGetHeight(panGesture.view.frame) ? CGRectGetHeight(self.frame) - CGRectGetHeight(panGesture.view.frame) : origin.y;
        
        newFrame.origin = origin;
        [panGesture.view setFrame:newFrame];
    } else if (panGesture.state == UIGestureRecognizerStateEnded) {
        [MyUserSetting shared].viewPosition = CGPointMake(panGesture.view.frame.origin.x, panGesture.view.frame.origin.y);
    }
}

@end
