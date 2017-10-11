//
//  CDRotateVC.m
//  CDAnimation
//
//  Created by CDchen on 2017/10/11.
//  Copyright © 2017年 CDchen. All rights reserved.
//

#import "CDRotateVC.h"

@interface CDRotateVC ()
@end

@implementation CDRotateVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cd_cycleImage"]];
    image.frame =CGRectMake(50, 100, self.view.bounds.size.width-100, self.view.bounds.size.width-100);
    image.layer.cornerRadius = (self.view.bounds.size.width-100)/2;
    image.layer.masksToBounds = YES;
    image.contentMode = UIViewContentModeScaleAspectFill;
    image.clipsToBounds = YES;
    [self.view addSubview:image];
    
    UIImageView *small = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.bounds.size.width-100)/2-10, -3, 30, 30)];
    small.image = [UIImage imageNamed:@"cd_cycleSmall"];
    [image addSubview:small];
    
    CABasicAnimation *monkeyAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    monkeyAnimation.toValue = [NSNumber numberWithFloat:2.0 *M_PI];
    monkeyAnimation.duration = 30.0f;
    monkeyAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    monkeyAnimation.cumulative = NO;
    monkeyAnimation.removedOnCompletion = NO;
    monkeyAnimation.repeatCount = FLT_MAX;
    [image.layer addAnimation:monkeyAnimation forKey:@"AnimatedKey"];
    //[_cycleImage stopAnimating];
    // 加载动画 但不播放动画
    image.layer.speed = 3.0;
}


@end
