//
//  SecondViewController.m
//  BezierDemo1
//
//  Created by 魏诗豪 on 16/3/29.
//  Copyright © 2016年 AceWei. All rights reserved.
//

#import "SecondViewController.h"
#import "AceGooeyMenu.h"

@interface SecondViewController ()<AceGooeyMenuDelegate>

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    AceGooeyMenu *vi = [[AceGooeyMenu alloc] initWithFrame:CGRectMake(100, 100, 50, 50)];
    
    AceGooeyMenu *vi = [[AceGooeyMenu alloc] initWithArcWithCenter:self.view.center radius:35 BubbleColor:[UIColor blueColor]];
//    vi.BuddleRadius = 20;
//    vi.BuddleDistance = 100;
    vi.BuddleStrArr = @[@"一个", @"二个", @"三个", @"四个"];
    vi.delegate = self;
    [self.view addSubview:vi];
}


- (void)buddleButtonClick:(NSUInteger)btnNum
{
    NSLog(@"%ld",btnNum);
}

@end
