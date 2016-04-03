//
//  AceGooeyMenu.h
//  BezierDemo1
//
//  Created by 魏诗豪 on 16/3/29.
//  Copyright © 2016年 AceWei. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol AceGooeyMenuDelegate <NSObject>

//- (void)buddleButtonClick:(UIButton *)button;
- (void)buddleButtonClick:(NSUInteger)btnNum;

@end


@interface AceGooeyMenu : UIView


@property (nonatomic) id<AceGooeyMenuDelegate> delegate;


///小气泡半径（默认17.5）
@property (nonatomic) NSUInteger BuddleRadius;

///小气泡距离大气泡距离（默认80）
@property (nonatomic) float BuddleDistance;

///小气泡文字数组
@property (nonatomic) NSArray *BuddleStrArr;


- (instancetype)initWithArcWithCenter:(CGPoint)center radius:(CGFloat)radius BubbleColor:(UIColor *)BubbleColor;

@end
