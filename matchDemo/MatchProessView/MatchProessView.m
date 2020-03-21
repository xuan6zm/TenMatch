//
//  MatchProessView.m
//  matchDemo
//
//  Created by xiaoxuan on 2020/3/21.
//  Copyright © 2020 xiaoxuan. All rights reserved.
//

#import "MatchProessView.h"

@interface MatchProessView ()

@property (nonatomic, strong) UIView *progressView;

@property (nonatomic) CGRect rect_progressView;

- (void)_setHeightRestrictionOfFrame:(CGFloat)height;


@end

@implementation MatchProessView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor =[UIColor greenColor];
        
        [self _setHeightRestrictionOfFrame:frame.size.height];
    }
    return self;
}

- (void)_setHeightRestrictionOfFrame:(CGFloat)height
{
    CGRect rect = self.frame;
    
    _progressHeight = MIN(height, 100.0);
    _progressHeight = MAX(_progressHeight, 5.0);
    
    self.frame = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, _progressHeight);
    
    self.rect_progressView = CGRectZero;
    _rect_progressView.size.height = _progressHeight;
    self.progressView.frame = self.rect_progressView;
    
    self.layer.cornerRadius = self.progressView.layer.cornerRadius =  _progressHeight / 2.0;
    
    
}

- (void)setProgressHeight:(CGFloat)progressHeight
{
    [self _setHeightRestrictionOfFrame:progressHeight];
}

- (void)setProgressTintColor:(UIColor *)progressTintColor
{
    _progressTintColor = progressTintColor;
    
    self.backgroundColor = _progressTintColor;
}

-(void)setChangeTintColor:(UIColor *)changeTintColor{
    _changeTintColor = changeTintColor;
    self.progressView.backgroundColor = _changeTintColor;
}

- (void)setProgressValue:(CGFloat)progressValue
{
    _progressValue = progressValue;
    
    _progressValue = MIN(progressValue, self.bounds.size.width);
    
    _rect_progressView.size.width = _progressValue;
    
    
    CGFloat maxValue = self.bounds.size.width;
    
    double durationValue = (_progressValue/2.0) / maxValue + .5;
    
    [UIView animateWithDuration:durationValue animations:^{
        
        self.progressView.frame = self->_rect_progressView;
    }];
}

- (UIView *)progressView
{
    if (!_progressView) {
        _progressView = [[UIView alloc] initWithFrame:CGRectZero];
        _progressView.backgroundColor = [UIColor greenColor];
        [self addSubview:self.progressView];
    }
    return _progressView;
}


@end
