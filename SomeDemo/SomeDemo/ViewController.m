//
//  ViewController.m
//  SomeDemo
//
//  Created by 孙虎林 on 2021/1/30.
//

#import "ViewController.h"
#import "UIViewCube.h"
#import "UIView+Pool.h"

@interface ViewController ()
/// v
@property (nonatomic, strong) UIView *containView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *v = [[UIView alloc] init];
    self.containView = v;
    v.frame = self.view.bounds;
    [self.view addSubview:v];
    
    [v registerClass:UIViewCube.class forReuseIdentifier:@"UIViewCube1"];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 50, 50, 40)];
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(addView) forControlEvents:UIControlEventTouchUpInside];
}

- (void)addView {
    UIViewCube *cube = [self.containView dequeueReusableWithIdentifier:@"UIViewCube1"];
    cube.frame = CGRectMake(arc4random_uniform(375), arc4random_uniform(700), 100, 100);
    cube.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
    [self.containView addSubview:cube];
    
}

@end
