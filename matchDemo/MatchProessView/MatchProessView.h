//
//  MatchProessView.h
//  matchDemo
//
//  Created by xiaoxuan on 2020/3/21.
//  Copyright © 2020 xiaoxuan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MatchProessView : UIView

@property (nonatomic) CGFloat progressHeight;

@property (nonatomic) CGFloat progressValue;

@property (nonatomic, strong) UIColor *changeTintColor;

@property (nonatomic, strong) UIColor *progressTintColor;
@end

NS_ASSUME_NONNULL_END
