//
//  ViewController.m
//  matchDemo
//
//  Created by xiaoxuan on 2020/3/21.
//  Copyright © 2020 xiaoxuan. All rights reserved.
//

#import "ViewController.h"
#import "MatchProessView.h"

#define kScreenBounds       [[UIScreen mainScreen] bounds]
#define kScreenWidth        kScreenBounds.size.width
#define kScreenHeight       kScreenBounds.size.height


@interface ViewController ()

@property (nonatomic, strong) MatchProessView *matchProessView;

@property (nonatomic,strong) UIButton *speedBtn;

@property (nonatomic,strong) UIButton *resetBtn;

@property (nonatomic,strong) UILabel *time_Label;

@property (nonatomic,strong) UILabel *time_ClickLabel;

@property (nonatomic,assign) int num_click;

@property (strong, nonatomic) NSTimer *timer;

///目标倒计时时长
@property (nonatomic,assign) float time_num;

///共需要多少次达标
@property (nonatomic,assign) float time_Totalnum;

@property (nonatomic,assign) BOOL isBegin;

@property (nonatomic,assign) BOOL isStop;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];
    ///总目标点击70次进度完成
    self.time_Totalnum = 70;
    [self Building_PageVC];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self removeNSTimer];  // 将定时器从运行循环中移除，
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self removeNSTimer];
}

#pragma mark ============= 构建页面 ================
-(void)Building_PageVC{
    
   self.time_Label.text = [NSString stringWithFormat:@"倒计时:00:10:00"];
   self.num_click = 0;
   [self.view addSubview:self.speedBtn];
    self.speedBtn.frame = CGRectMake(kScreenWidth/2-40, 300, 80, 80);
  
       
   [self.view addSubview:self.resetBtn];
   self.resetBtn.frame = CGRectMake(kScreenWidth/2-40, 450, 80, 80);
       
   [self.view addSubview:self.time_Label];
    self.time_Label.frame = CGRectMake(0, 200, kScreenWidth, 20);
       
   [self.view addSubview:self.time_ClickLabel];
   self.time_ClickLabel.frame = CGRectMake(0, 250, kScreenWidth, 20);
    
   [self.view addSubview:self.matchProessView];
    
}
#pragma mark -添加定时器
-(void)addNSTimer{
   self.isBegin = YES;
    [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        [[UIApplication sharedApplication]endBackgroundTask:UIBackgroundTaskInvalid];
    }];
     _timer =[NSTimer scheduledTimerWithTimeInterval:0.01f target:self selector:@selector(beginChangeState) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop]addTimer:_timer forMode:NSDefaultRunLoopMode];
   
}

#pragma mark -删除定时器

-(void)removeNSTimer{
    [_timer invalidate];
    _timer =nil;
}

-(void)beginChangeState{
   
    self.time_num = self.time_num-0.01f;
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.time_Label.text = [self ConvertStrToTime:[NSString stringWithFormat:@"%f",self.time_num*1000]];
  
    });
        if (self.time_num <= 0) {// 如果进度条到头了
            self.isStop = YES;

            // 终止定时器
            [self removeNSTimer];
        };
}


-(MatchProessView *)matchProessView{
    if (!_matchProessView) {
        _matchProessView = [[MatchProessView alloc]initWithFrame:CGRectMake(30, 100, [[UIScreen mainScreen] bounds].size.width - 60, 10)];
        _matchProessView.changeTintColor = [UIColor orangeColor];
        _matchProessView.progressTintColor = [UIColor grayColor];
    }
    return _matchProessView;
}

-(UIButton *)speedBtn{
    if (!_speedBtn) {
        _speedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_speedBtn setTitle:@"开始/点击" forState:UIControlStateNormal];
        [_speedBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
       _speedBtn.backgroundColor = [UIColor blueColor];
       _speedBtn.layer.masksToBounds = YES;
       _speedBtn.layer.cornerRadius =30;
       [_speedBtn addTarget:self action:@selector(speed_BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _speedBtn.titleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
       _speedBtn.adjustsImageWhenHighlighted = NO;
    }
    return _speedBtn;

}

-(UIButton *)resetBtn{
    if (!_resetBtn) {
        _resetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_resetBtn setTitle:@"重置" forState:UIControlStateNormal];
        [_resetBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _resetBtn.backgroundColor = [UIColor redColor];
       _resetBtn.layer.masksToBounds = YES;
        _resetBtn.layer.cornerRadius = 30;
       [_resetBtn addTarget:self action:@selector(reset_BtnClick:) forControlEvents:UIControlEventTouchUpInside];
       _resetBtn.titleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
     
    }
    return _resetBtn;

}

-(UILabel *)time_Label{
    if (!_time_Label) {
        _time_Label = [[UILabel alloc]init];
        _time_Label.font = [UIFont systemFontOfSize:30 weight:UIFontWeightBold];
        _time_Label.textColor = [UIColor redColor];
        _time_Label.textAlignment = NSTextAlignmentCenter;
        
    }
    return _time_Label;
}

-(UILabel *)time_ClickLabel{
    if (!_time_ClickLabel) {
        _time_ClickLabel = [[UILabel alloc]init];
        _time_ClickLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightBold];
        _time_ClickLabel.textColor = [UIColor redColor];
        _time_ClickLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _time_ClickLabel;
}


-(void)speed_BtnClick:(id)sender{
    if (!self.isBegin) {
        
        //目标倒计时时长
       self.time_num = 10.00;
        
       [self addNSTimer];
    }
    if (self.isStop) {
        return;
    }
    self.num_click ++;
    self.time_ClickLabel.text = [NSString stringWithFormat:@"共点击了%d下",self.num_click];
    float speedNum = [[NSString stringWithFormat:@"%d",self.num_click] floatValue];
    float proportion = speedNum/self.time_Totalnum;
    CGFloat progressWidth = ([[UIScreen mainScreen] bounds].size.width - 60)*proportion;
    self.matchProessView.progressValue = progressWidth;
}

-(void)reset_BtnClick:(id)sender{
    self.isStop = NO;
    self.isBegin = NO;
    self.num_click = 0;
    self.matchProessView.progressValue = 0;
    self.time_Label.text = [NSString stringWithFormat:@"倒计时:00:10:00"];
    self.time_ClickLabel.text = @"共点击了0下";
    [self removeNSTimer];
    
}
- (NSString *)ConvertStrToTime:(NSString *)timeStr{
    long long time=[timeStr longLongValue];
    long ms = time%1000/10;
    long second = time/1000%60;
    long m = time/1000/60;
    NSString *timeString =[NSString stringWithFormat:@"倒计时：%02ld:%02ld:%02ld",m,second,ms];
    return timeString;
}



@end
