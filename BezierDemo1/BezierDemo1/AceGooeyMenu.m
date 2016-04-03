//
//  AceGooeyMenu.m
//  BezierDemo1
//
//  Created by 魏诗豪 on 16/3/29.
//  Copyright © 2016年 AceWei. All rights reserved.
//

#import "AceGooeyMenu.h"

@interface AceGooeyMenu (){
    CGPoint PointA;
    CGPoint PointB;
    CGPoint PointC;
    CGPoint PointD;
    CGPoint PointE;
    CGPoint PointF;
    CGPoint PointG;
    CGPoint PointH;
    
    CGPoint PointTop;
    CGPoint PointLeft;
    CGPoint PointRight;
    CGPoint PointBottom;
    
    BOOL isShow;
}


@property (nonatomic, strong) CAShapeLayer *roundLayer;
@property (nonatomic) UIColor *BubbleColor;

@property (nonatomic, strong) UIButton *btn1;
@property (nonatomic, strong) UIButton *btn2;
@property (nonatomic, strong) UIButton *btn3;
@property (nonatomic, strong) UIButton *btn4;

@property (nonatomic) NSMutableArray *btnArr;


@end

@implementation AceGooeyMenu


- (instancetype)initWithArcWithCenter:(CGPoint)center radius:(CGFloat)radius BubbleColor:(UIColor *)BubbleColor
{
    CGRect frame = CGRectMake(center.x-radius, center.y-radius, radius*2, radius*2);
    self = [self initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.BubbleColor = BubbleColor;
        isShow = NO;
        
        if (!_BubbleColor) {
            _BubbleColor = [UIColor blueColor];
        }
        
        if (!_BuddleRadius) {
            self.BuddleRadius = 17.5;
        }
        
        if (!_BuddleDistance) {
            _BuddleDistance = 80;
        }
        
        [self addRoundLayer];
    }
    
    return self;
}


- (void)addRoundLayer
{
    self.roundLayer = [CAShapeLayer layer];
    _roundLayer.frame = self.bounds;
    [self.layer addSublayer:_roundLayer];
    
    
    UIBezierPath *path = [self drawCanvaRoundWithFrame:_roundLayer.bounds];
    _roundLayer.path = path.CGPath;
    _roundLayer.fillColor = _BubbleColor.CGColor;
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)];
    [self addGestureRecognizer:tap];
    
    _btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _btnArr = [NSMutableArray arrayWithObjects:_btn1, _btn2, _btn3, _btn4, nil];
    
    

}


- (void)click:(UIGestureRecognizer *)gesture
{
    isShow = !isShow;
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"path"];
    
    NSArray *arr = [self createAnimateKeyFrame:@[@0.5, @0.2, @0.8, @0.35, @0.65, @0.45, @0.55, @0.5]];
    animation.values = arr;
    
    animation.duration = 1.5;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.calculationMode = kCAAnimationLinear;
    [_roundLayer addAnimation:animation forKey:nil];
    
    
    if (isShow) {
        [_btnArr enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            obj.bounds = CGRectMake(0, 0, 5, 5);
            obj.layer.cornerRadius = CGRectGetHeight(obj.frame)/2;
            obj.center = self.center;
            [obj.titleLabel setFont:[UIFont boldSystemFontOfSize:0]];
            obj.backgroundColor = _BubbleColor;
            [obj setTitle:_BuddleStrArr[idx] forState:UIControlStateNormal];
            [self.superview insertSubview:obj belowSubview:self];
            
            [obj addTarget:self action:@selector(littleBuddleClick:) forControlEvents:UIControlEventTouchUpInside];
            
            
            [UIView animateWithDuration:1.2 delay:0.1+idx*0.1 usingSpringWithDamping:0.4 initialSpringVelocity:0.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                obj.bounds = CGRectMake(0, 0, self.BuddleRadius*2, self.BuddleRadius*2);
                
                [obj.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
                
                CGFloat x = self.center.x-cosf(M_PI/5*(idx+1))*_BuddleDistance;
                CGFloat y = self.center.y-sinf(M_PI/5*(idx+1))*_BuddleDistance;
                
                CGPoint Point = CGPointMake(x, y);
                obj.center = Point;
                obj.layer.cornerRadius = self.BuddleRadius;
            } completion:nil];
            
        }];
    } else {
        [_btnArr enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [UIView animateWithDuration:1.2 delay:0.1+idx*0.1 usingSpringWithDamping:0.4 initialSpringVelocity:0.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                obj.bounds = CGRectMake(0, 0, 5, 5);
                obj.layer.cornerRadius = _BuddleRadius;
                obj.center = self.center;
                [obj.titleLabel setFont:[UIFont boldSystemFontOfSize:0]];
            } completion:nil];
            
        }];
    }
}



- (void)littleBuddleClick:(UIButton *)button
{
    NSInteger num = -1;
    
    for (NSInteger i=0; i<_btnArr.count; i++) {
        UIButton *btn = _btnArr[i];
        if ([btn isEqual:button]) {
            num = i;
        }
    }
    
    [self.delegate buddleButtonClick:num];
}



#pragma mark pointArr：转化成NSNumber类型的参数
- (NSMutableArray *)createAnimateKeyFrame:(NSArray *)pointArr
{
    NSMutableArray *arr = [NSMutableArray array];
    
    for (NSNumber *num in pointArr) {
        float n = [num floatValue];
        PointTop = CGPointMake(_roundLayer.bounds.size.width*n, 0);
        UIBezierPath *path = [self drawCanvaRoundWithFrame:_roundLayer.bounds];
        NSValue *value = (__bridge id)path.CGPath;
        [arr addObject:value];
    }
    
    return arr;
}



#pragma mark 绘制贝塞尔曲线
- (UIBezierPath *)drawCanvaRoundWithFrame: (CGRect)frame
{
    CGFloat offset = CGRectGetHeight(frame)/3.6;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        PointTop = CGPointMake(frame.size.width/2, 0);
    });
    
    PointRight = CGPointMake(frame.size.width, frame.size.height/2);
    PointBottom = CGPointMake(frame.size.width/2, frame.size.height);
    PointLeft = CGPointMake(0, frame.size.height/2);
    
    
    PointA = CGPointMake(PointTop.x+offset, PointTop.y);
    PointB = CGPointMake(PointRight.x, PointRight.y-offset);
    PointC = CGPointMake(PointRight.x, PointRight.y+offset);
    PointD = CGPointMake(PointBottom.x+offset, PointBottom.y);
    PointE = CGPointMake(PointBottom.x-offset, PointBottom.y);
    PointF = CGPointMake(PointLeft.x, PointLeft.y+offset);
    PointG = CGPointMake(PointLeft.x, PointLeft.y-offset);
    PointH = CGPointMake(PointTop.x-offset, PointTop.y);
    
    
    //// Bezier Drawing
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    
    [bezierPath moveToPoint:PointTop];
    
    [bezierPath addCurveToPoint:PointRight controlPoint1:PointA controlPoint2:PointB];
    [bezierPath addCurveToPoint:PointBottom controlPoint1:PointC controlPoint2:PointD];
    [bezierPath addCurveToPoint:PointLeft controlPoint1:PointE controlPoint2:PointF];
    [bezierPath addCurveToPoint:PointTop controlPoint1:PointG controlPoint2:PointH];
    
    bezierPath.lineWidth = 1;
    
    return bezierPath;
}


@end
