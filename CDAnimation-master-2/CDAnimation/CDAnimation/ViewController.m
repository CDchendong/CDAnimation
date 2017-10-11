//
//  ViewController.m
//  CDAnimation
//
//  Created by CDchen on 2017/9/29.
//  Copyright © 2017年 CDchen. All rights reserved.
//

#import "ViewController.h"
#import "CDPinBallVC.h"
#import "CDRotateVC.h"
#import "CDCycleVC.h"
#define WW [UIScreen mainScreen].bounds.size.width
#define HH [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<CAAnimationDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) UIView *circleView;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@end

@implementation ViewController

- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WW, HH) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 60;
    }
    return _tableView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"整理动画";
    [self.view addSubview:self.tableView];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    switch (indexPath.row) {
        case 0:
            {
                cell.textLabel.text = @"弹球动画,画圆,进度条";
            }
            break;
        case 1:
            {
                cell.textLabel.text = @"旋转动画";
            }
            break;
        case 2:
            {
                cell.textLabel.text = @"效果动画";
            }
            break;
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case 0:
            {
                CDPinBallVC *vc = [[CDPinBallVC alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
            break;
        case 1:
            {
                CDRotateVC *vc = [[CDRotateVC alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
            break;
        case 2:
            {
                CDCycleVC *vc = [[CDCycleVC alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
            break;
        default:
            break;
    }
}

@end
