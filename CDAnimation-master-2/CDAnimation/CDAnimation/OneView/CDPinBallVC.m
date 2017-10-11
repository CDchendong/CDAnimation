//
//  CDPinBallVC.m
//  CDAnimation
//
//  Created by CDchen on 2017/10/10.
//  Copyright © 2017年 CDchen. All rights reserved.
//

#import "CDPinBallVC.h"
#define WW [UIScreen mainScreen].bounds.size.width
#define HH [UIScreen mainScreen].bounds.size.height
@interface CDPinBallVC ()<CAAnimationDelegate>
@property (nonatomic, strong)UIButton * myBtn;
@property (nonatomic, strong)UIButton *beginBtn;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) UIView *circleView;

@end

@implementation CDPinBallVC
- (UIView *)circleView
{
    if (!_circleView)
    {
        _circleView = [[UIView alloc] initWithFrame:CGRectMake(250, 100, 80, 80)];
        _circleView.backgroundColor = [UIColor yellowColor];
    }
    return _circleView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _myBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _myBtn.backgroundColor = [UIColor greenColor];
    _myBtn.frame = CGRectMake(100, 100, 100, 100);
    _myBtn.layer.cornerRadius = 50;
    _myBtn.layer.masksToBounds = YES;
    [self.view addSubview:_myBtn];
    
    
    _beginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _beginBtn.backgroundColor = [UIColor lightGrayColor];
    [_beginBtn setTitle:@"开始" forState:UIControlStateNormal];
    [_beginBtn addTarget:self action:@selector(beginAction) forControlEvents:UIControlEventTouchUpInside];
    _beginBtn.frame = CGRectMake(150, 450, 100, 50);
    
    [self.view addSubview:_beginBtn];
    [self.view addSubview:self.circleView];
   
}

- (void)beginAction{
    
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animation];
    // 动画路径
    animation.keyPath = @"position";
    animation.duration = 2.0;
    animation.delegate = self;
    // 下落上弹的点
    animation.values = @[
                         [NSValue valueWithCGPoint:CGPointMake(150, 150)],
                         [NSValue valueWithCGPoint:CGPointMake(150, 280)],
                         [NSValue valueWithCGPoint:CGPointMake(150, 170)],
                         [NSValue valueWithCGPoint:CGPointMake(150, 280)],
                         [NSValue valueWithCGPoint:CGPointMake(150, 230)],
                         [NSValue valueWithCGPoint:CGPointMake(150, 280)],
                         [NSValue valueWithCGPoint:CGPointMake(150, 270)],
                         [NSValue valueWithCGPoint:CGPointMake(150, 280)]
                         ];
    // 上下弹时 的状态可以自己修改效果 默认kCAMediaTimingFunctionDefault
    //    animation.timingFunctions = @[
    //                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn],
    //                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseOut],
    //                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn],
    //                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseOut],
    //                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn],
    //                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseOut],
    //                                  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn]
    //                                  ];
    //时间限制
    animation.keyTimes = @[@0.0, @0.32, @0.52, @0.73, @0.84, @0.91, @0.96, @1.0];
    _myBtn.layer.position = CGPointMake(150, 280);
    [_myBtn.layer addAnimation:animation forKey:nil];

    /*
       画圆
     */
    if (!_shapeLayer)
    {
        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.frame = _circleView.bounds;
    }
    //    shapeLayer.strokeStart = 0.1;
    //    shapeLayer.strokeEnd   = 0.8;
    // 贝塞尔路径
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:_circleView.bounds];
    _shapeLayer.path = path.CGPath;
    // 填充色
    _shapeLayer.fillColor = [UIColor clearColor].CGColor;
    // 路径的宽度
    _shapeLayer.lineWidth = 2.0f;
    _shapeLayer.strokeColor = [UIColor greenColor].CGColor;
    // 动画实现的view层
    [_circleView.layer addSublayer:_shapeLayer];
    
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    basicAnimation.duration = 3.0f;
    basicAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    // 动画从那开始到哪结束
    basicAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    basicAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    /*
     （要想fillMode有效，最好设置removedOnCompletion=NO）
     kCAFillModeRemoved 这个是默认值,也就是说当动画开始前和动画结束后,动画对layer都没有影响,动画结束后,layer会恢
     复到之前的状态 
     kCAFillModeForwards 当动画结束后,layer会一直保持着动画最后的状态.
     kCAFillModeBackwards 在动画开始前,你只要将动画加入了一个layer,layer便立即进入动画的初始状态并等待动画开始.
     你可以这样设定测试代码,将一个动画加入一个layer的时候延迟5秒执行.然后就会发现在动画没有开始的时候,只要动画被
     加入了layer,layer便处于动画初始状态
     kCAFillModeBoth 这个其实就是上面两个的合成.动画加入后在开始之前,layer便处于动画初始状态,动画结束后layer保持
     动画最后的状
     **/
    basicAnimation.fillMode = kCAFillModeForwards;
    basicAnimation.removedOnCompletion = NO;
    [_shapeLayer addAnimation:basicAnimation forKey:@"strokeEndAnimation"];
}

@end
