//
//  SecondViewController.m
//  ERP_xingroup-iOS
//
//  Created by xin-group on 16/3/25.
//  Copyright © 2016年 xin-group. All rights reserved.
//

#import "SecondViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "PlayerView.h"
#import <AVKit/AVKit.h>
#import <MediaPlayer/MediaPlayer.h>

#define HLS_URL @"http://dlhls.cdn.zhanqi.tv/zqlive/"

@interface SecondViewController (){
    CATransform3D myTransform;
    UIButton *swtichBtn;
    UIButton *pauseBtn;
    BOOL buttonSelected;
}
@property (nonatomic ,strong) UIProgressView *progress;
@property (nonatomic ,strong) AVPlayer *player;
@property (nonatomic ,strong) AVPlayerItem *playerItem;
@property (nonatomic ,strong) PlayerView*playerView;
@property (nonatomic,strong)  UISlider*slider;//播放进度

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor yellowColor];
    self.title=@"SecondVC";
    
    _playerView=[[PlayerView alloc]initWithFrame:CGRectMake(10, 20+20+44, 300, 160)];
    myTransform = _playerView.layer.transform;
    [_playerView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_playerView];
    
    swtichBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [swtichBtn setFrame:CGRectMake(300-44+10,160-20+20+44, 44, 44)];
    [swtichBtn addTarget:self action:@selector(swtichAction:) forControlEvents:UIControlEventTouchUpInside];
    [swtichBtn setImage:[UIImage imageNamed:@"movie_fullscreen"] forState:UIControlStateNormal];
    [self.view addSubview:swtichBtn];
    
    pauseBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [pauseBtn setFrame:CGRectMake(0,0, 44, 44)];
    pauseBtn.center=_playerView.center;
    pauseBtn.tag=1000;
    [pauseBtn addTarget:self action:@selector(swtichAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *image = [UIImage imageNamed:@"movie_fullscreen"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [pauseBtn setBackgroundImage:image forState:UIControlStateNormal];
    buttonSelected=NO;
    [self.view addSubview:pauseBtn];
    
    //进度条按钮
    self.progress= [[UIProgressView alloc]initWithFrame:CGRectMake(10-2,160-20+5,300-15,10)];
    self.progress.progress=0;
    self.progress.progressTintColor= [UIColor colorWithRed:1.000 green:0.599 blue:0.345 alpha:1.000];
//    [_playerView addSubview:self.progress];
    
    // slider滑条事件
    self.slider= [[UISlider alloc]initWithFrame:CGRectMake(10-4,0,300-10,10)];
    self.slider.minimumValue=0;
    self.slider.maximumValue=0;
    self.slider.maximumTrackTintColor= [UIColor clearColor];
    [self.slider setThumbImage:[UIImage imageNamed:@"iconfont-yuan"]forState:UIControlStateNormal];
    [self.progress addSubview:self.slider];
//    [self.slider addTarget:self action:@selector(handleSlider:)forControlEvents:UIControlEventValueChanged];
    
//    [self playVideo];
    [self createMPPlayerController];
}

- (void)swtichAction:(UIButton *)sender{
    
    if (sender.tag==1000) {
        if (buttonSelected) {
            buttonSelected=NO;
            [_player play];
        }else{
            buttonSelected=YES;
            [_player pause];
        }
    
    }else{
    
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
        _playerView.frame = CGRectMake(0, 0, 560, 320);
        swtichBtn.hidden=YES;
        pauseBtn.hidden=YES;
        self.navigationController.navigationBarHidden=YES;
        [UIView animateWithDuration:0.3 animations:^{
            CATransform3D transform = CATransform3DMakeRotation(M_PI / 2, 0, 0, 1.0);
            _playerView.layer.transform  =  transform;
            _playerView.center = self.view.center;
        } completion:^(BOOL finished) {
            _playerView.center = self.view.center;
        }];
    }
}


- (void)playVideo{
    
    NSString *filePath = [NSString stringWithFormat:@"%@%@.m3u8",HLS_URL,@"112518_9iBKK"];
    filePath=[filePath stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *videoUrl = [NSURL URLWithString: filePath ];
    
    self.playerItem = [AVPlayerItem playerItemWithURL:videoUrl];
    
    [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];// 监听status属性
    [self.playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];// 监听loadedTimeRanges属性

    
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    self.playerView.player = _player;
    [_player play];
}


// KVO方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    AVPlayerItem *playerItem = (AVPlayerItem *)object;
    if ([keyPath isEqualToString:@"status"]) {
        if ([playerItem status] == AVPlayerStatusReadyToPlay) {
            NSLog(@"AVPlayerStatusReadyToPlay");
            
        } else if ([playerItem status] == AVPlayerStatusFailed) {
            NSLog(@"AVPlayerStatusFailed");
        }
    } else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        
        NSTimeInterval timeInterval = [self availableDuration];// 计算缓冲进度
        NSLog(@"Time Interval:%f",timeInterval);
        CMTime duration = self.playerItem.duration;
        CGFloat totalDuration = CMTimeGetSeconds(duration);
        [self.progress setProgress:timeInterval/totalDuration animated:YES];
    }
}

- (NSTimeInterval)availableDuration {
    NSArray *loadedTimeRanges = [[self.playerView.player currentItem] loadedTimeRanges];
    CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
    float startSeconds = CMTimeGetSeconds(timeRange.start);
    float durationSeconds = CMTimeGetSeconds(timeRange.duration);
    NSTimeInterval result = startSeconds + durationSeconds;// 计算缓冲总进度
    return result;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc {
    [self.playerItem removeObserver:self forKeyPath:@"status" context:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)createMPPlayerController{
    
    NSString *sFileNamePath = [NSString stringWithFormat:@"%@%@.m3u8",HLS_URL,@"112518_9iBKK"];
    sFileNamePath=[sFileNamePath stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *videoUrl = [NSURL URLWithString:sFileNamePath];

    AVPlayer *player = [AVPlayer playerWithURL:videoUrl];
    AVPlayerViewController *playerViewController = [AVPlayerViewController new];
    playerViewController.player = player;
    
    playerViewController.showsPlaybackControls=YES;
    playerViewController.allowsPictureInPicturePlayback=YES;
    
    [self presentViewController:playerViewController animated:YES completion:nil];
    
//    MPMoviePlayerViewController *movie = [[MPMoviePlayerViewController alloc]initWithContentURL:videoUrl];
//    [movie.moviePlayer prepareToPlay];
//    [self presentMoviePlayerViewControllerAnimated:movie];
//    
//    [movie.moviePlayer setControlStyle:MPMovieControlStyleFullscreen];
//    [movie.view setBackgroundColor:[UIColor clearColor]];
//    [movie.view setFrame:self.view.bounds];
//    
//    [[NSNotificationCenter defaultCenter]addObserver:self
//                                           selector:@selector(movieFinishedCallback:)
//                                               name:MPMoviePlayerPlaybackDidFinishNotification
//                                             object:movie.moviePlayer];
}

-(void)movieFinishedCallback:(NSNotification*)notify{
    MPMoviePlayerController* theMovie = [notify object];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                   name:MPMoviePlayerPlaybackDidFinishNotification
                                                 object:theMovie];
    [theMovie.view removeFromSuperview];
}

@end
