//
//  ViewController.m
//  ios-opengl
//
//  Created by mac on 2020/9/3.
//  Copyright © 2020 TongArk. All rights reserved.
//

#import "ViewController.h"
#import "Ch2_1ViewController.h"
#import "Ch3_1ViewController.h"
#import "DrawTriangleViewController.h"

@interface ViewController ()

@property (strong, nonatomic) UIButton *ch2_1Btn;
@property (strong, nonatomic) UIButton *ch3_1Btn;
@property (strong, nonatomic) UIButton *demo1Btn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configBaseUI];
}

#pragma mark - BaseSet
- (void)configBaseUI{
    [self.view addSubview:self.ch2_1Btn];
    [self.ch2_1Btn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(80);
        make.left.equalTo(10);
        make.height.equalTo(40);
        make.width.equalTo(100);
    }];
    
    [self.view addSubview:self.ch3_1Btn];
    [self.ch3_1Btn makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.ch2_1Btn.right).offset(10);
        make.top.height.width.equalTo(self.ch2_1Btn);    }];
    
    [self.view addSubview:self.demo1Btn];
    [self.demo1Btn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ch2_1Btn.bottom).offset(10);
        make.left.height.width.equalTo(self.ch2_1Btn);
    }];
}

- (UIButton *)ch2_1Btn{
    if (!_ch2_1Btn) {
        UIButton *button = [[UIButton alloc]init];
        [button setBackgroundImage:nil forState:UIControlStateNormal];
        [button setTitle:@"Ch2.1" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(ch2_1) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:[UIImage imageNamed:@"TzClose"] forState:UIControlStateNormal];
        button.backgroundColor=UIColor.greenColor;
        _ch2_1Btn = button;
    }
    return _ch2_1Btn;
}

- (UIButton *)ch3_1Btn{
    if (!_ch3_1Btn) {
        UIButton *button = [[UIButton alloc]init];
        [button setBackgroundImage:nil forState:UIControlStateNormal];
        [button setTitle:@"Ch3.1" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(ch3_1) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:[UIImage imageNamed:@"TzClose"] forState:UIControlStateNormal];
        button.backgroundColor=UIColor.greenColor;
        _ch3_1Btn = button;
    }
    return _ch3_1Btn;
}

- (UIButton *)demo1Btn{
    if (!_demo1Btn) {
        UIButton *button = [[UIButton alloc]init];
        [button setBackgroundImage:nil forState:UIControlStateNormal];
        [button setTitle:@"三角" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(demo1) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:[UIImage imageNamed:@"TzClose"] forState:UIControlStateNormal];
        button.backgroundColor=UIColor.brownColor;
        _demo1Btn = button;
    }
    return _demo1Btn;
}

-(void)ch2_1{
    Ch2_1ViewController *vc=[Ch2_1ViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)ch3_1{
    Ch3_1ViewController *vc=[Ch3_1ViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)demo1{
    DrawTriangleViewController *vc=[DrawTriangleViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
