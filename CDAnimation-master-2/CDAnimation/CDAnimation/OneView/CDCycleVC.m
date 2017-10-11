//
//  CDCycleVC.m
//  CDAnimation
//
//  Created by CDchen on 2017/10/11.
//  Copyright © 2017年 CDchen. All rights reserved.
//

#import "CDCycleVC.h"

@interface CDCycleVC ()<CAAnimationDelegate>
@property (nonatomic, strong) UIButton *myBtn;
@property (nonatomic, strong) UIButton *myBoy;
@end

@implementation CDCycleVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGFloat kAnimationDuration = 3.0f;
    
    self.view.backgroundColor = [UIColor whiteColor];
    _myBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _myBtn.backgroundColor = [UIColor greenColor];
    _myBtn.frame = CGRectMake(50, 100, 100, 100);
    _myBtn.layer.cornerRadius = 50;
    _myBtn.layer.masksToBounds = YES;
    [self.view addSubview:_myBtn];
    
    _myBoy = [UIButton buttonWithType:UIButtonTypeCustom];
    _myBoy.backgroundColor = [UIColor greenColor];
    _myBoy.frame = CGRectMake(50, 250, 100, 100);
    _myBoy.layer.cornerRadius = 50;
    _myBoy.layer.masksToBounds = YES;
    [self.view addSubview:_myBoy];
    
    //透明度变化
    CABasicAnimation *basic = [CABasicAnimation animationWithKeyPath:@"opacity"];
    basic.fromValue = [NSNumber numberWithFloat:1.0];
    basic.toValue = [NSNumber numberWithFloat:0.1];
    basic.removedOnCompletion = NO;
    basic.delegate = self;
    basic.duration  =kAnimationDuration;
    basic.repeatCount = MAXFLOAT;
    [_myBtn.layer addAnimation:basic forKey:@"alpha"];
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0, 0, 1)];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)];
    scaleAnimation.duration = kAnimationDuration;
    scaleAnimation.cumulative = NO;
    scaleAnimation.repeatCount = MAXFLOAT;
    [scaleAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [_myBtn.layer addAnimation: scaleAnimation forKey:@"myScale"];
    // 组动画
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = kAnimationDuration;
    group.removedOnCompletion = NO;
    group.repeatCount = MAXFLOAT;
    group.fillMode = kCAFillModeForwards;
    [group setAnimations:@[scaleAnimation]];
    
    [_myBoy.layer addAnimation:group forKey:@"animationOpacity"];
}



@end
