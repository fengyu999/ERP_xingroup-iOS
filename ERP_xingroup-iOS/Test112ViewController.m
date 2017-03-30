//
//  Test112ViewController.m
//  ERP_xingroup-iOS
//
//  Created by xin-group on 16/5/16.
//  Copyright © 2016年 xin-group. All rights reserved.
//

#import "Test112ViewController.h"
#import "PYEchartsView.h"
#import "PYColor.h"
#import "PYOption.h"

#import "PYLabel.h"
#import "PYLabelLine.h"
#import "PYItemStyle.h"
#import "PYTextStyle.h"
#import "RMMapper.h"
#import "PYPieSeries.h"

#define SCREEN_WIDTH    ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define RGBACOLOR(R,G,B,A) [UIColor colorWithRed:(R)/255.0f green:(G)/255.0f blue:(B)/255.0f alpha:(A)]

@interface Test112ViewController ()
@property (nonatomic,strong) PYEchartsView *tWebview;
@end

@implementation Test112ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.title=@"图表";
    _tWebview =[[PYEchartsView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, SCREEN_WIDTH)];
    [_tWebview setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:_tWebview];
    
    NSArray *titleArray=[NSArray arrayWithObjects:@"折线图",@"漏斗图",@"旋风条形图",@"标准条形图", nil];
    
    for (int i=0; i<4; i++) {
        UIButton *typeButton=[UIButton buttonWithType:UIButtonTypeSystem];
        typeButton.frame=CGRectMake((SCREEN_WIDTH-100*2-20)/2+120*(i%2), 10+45*(i/2), 100, 40);
        typeButton.backgroundColor=[UIColor redColor];
        [typeButton setTitle:titleArray[i] forState:UIControlStateNormal];
        typeButton.tag=i;
        [typeButton addTarget:self action:@selector(touchUpButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:typeButton];
    }

    [self showStackedLineDemo];
    [_tWebview loadEcharts];
}

- (void)touchUpButtonAction:(UIButton *)sender{
    switch (sender.tag) {
        case 0:
            [self showStackedLineDemo];
            break;
        case 1:
            [self showLouDouDemo];
            break;
        case 2:
            [self showTornadoDemo];
            break;
        case 3:
            [self showBinDemo];
//            [self showBasicBarDemo];
            break;
        default:
            break;
    }
    [_tWebview loadEcharts];
}

//标准条形图
-(void)showBasicBarDemo {
    NSString *basicBarJson = @"{\"grid\":{\"x\":30,\"x2\":45},\"tooltip\":{\"trigger\":\"axis\"},\"legend\":{\"data\":[\"2011年\",\"2012年\"]},\"toolbox\":{\"show\":false,\"feature\":{\"mark\":{\"show\":true},\"dataView\":{\"show\":true,\"readOnly\":false},\"magicType\":{\"show\":true,\"type\":[\"line\",\"bar\"]},\"restore\":{\"show\":true},\"saveAsImage\":{\"show\":true}}},\"calculable\":true,\"xAxis\":[{\"type\":\"value\",\"boundaryGap\":[0,0.01]}],\"yAxis\":[{\"type\":\"category\",\"data\":[\"巴西\",\"印尼\",\"美国\",\"印度\",\"中国\",\"世界人口(万)\"]}],\"series\":[{\"name\":\"2011年\",\"type\":\"bar\",\"data\":[38203,23489,29034,104970,131744,650230]},{\"name\":\"2012年\",\"type\":\"bar\",\"data\":[19325,23438,31000,121594,134141,681807]}]}";
    
    NSData *jsonData = [basicBarJson dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    PYOption *option = [RMMapper objectWithClass:[PYOption class] fromDictionary:jsonDic];
    [_tWebview setOption:option];
}

//旋风条形图
-(void)showTornadoDemo {
    NSString *tornadoJson = @"{\"grid\":{\"x\":30,\"x2\":45},\"tooltip\":{\"trigger\":\"axis\",\"axisPointer\":{\"type\":\"shadow\"}},\"legend\":{\"data\":[\"利润\",\"收入\"]},\"toolbox\":{\"show\":false,\"feature\":{\"mark\":{\"show\":true},\"dataView\":{\"show\":true,\"readOnly\":false},\"magicType\":{\"show\":true,\"type\":[\"line\",\"bar\"]},\"restore\":{\"show\":true},\"saveAsImage\":{\"show\":true}}},\"calculable\":true,\"xAxis\":[{\"type\":\"value\"}],\"yAxis\":[{\"type\":\"category\",\"axisTick\":{\"show\":false},\"data\":[\"周一\",\"周二\",\"周三\",\"周四\",\"周五\",\"周六\",\"周日\"]}],\"series\":[{\"name\":\"利润\",\"type\":\"bar\",\"itemStyle\":{\"normal\":{\"label\":{\"show\":true,\"position\":\"inside\"}}},\"data\":[200,170,240,244,200,220,210]},{\"name\":\"收入\",\"type\":\"bar\",\"stack\":\"总量\",\"barWidth\":5,\"itemStyle\":{\"normal\":{\"label\":{\"show\":true}}},\"data\":[320,302,341,374,390,450,420]}]}";
    
    //@"{\"grid\":{\"x\":30,\"x2\":45},\"tooltip\":{\"trigger\":\"axis\",\"axisPointer\":{\"type\":\"shadow\"}},\"legend\":{\"data\":[\"利润\",\"支出\",\"收入\"]},\"toolbox\":{\"show\":false,\"feature\":{\"mark\":{\"show\":true},\"dataView\":{\"show\":true,\"readOnly\":false},\"magicType\":{\"show\":true,\"type\":[\"line\",\"bar\"]},\"restore\":{\"show\":true},\"saveAsImage\":{\"show\":true}}},\"calculable\":true,\"xAxis\":[{\"type\":\"value\"}],\"yAxis\":[{\"type\":\"category\",\"axisTick\":{\"show\":false},\"data\":[\"周一\",\"周二\",\"周三\",\"周四\",\"周五\",\"周六\",\"周日\"]}],\"series\":[{\"name\":\"利润\",\"type\":\"bar\",\"itemStyle\":{\"normal\":{\"label\":{\"show\":true,\"position\":\"inside\"}}},\"data\":[200,170,240,244,200,220,210]},{\"name\":\"收入\",\"type\":\"bar\",\"stack\":\"总量\",\"barWidth\":5,\"itemStyle\":{\"normal\":{\"label\":{\"show\":true}}},\"data\":[320,302,341,374,390,450,420]},{\"name\":\"支出\",\"type\":\"bar\",\"stack\":\"总量\",\"itemStyle\":{\"normal\":{\"label\":{\"show\":true,\"position\":\"left\"}}},\"data\":[-120,-132,-101,-134,-190,-230,-210]}]}";
    
    NSData *jsonData = [tornadoJson dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    PYOption *option = [RMMapper objectWithClass:[PYOption class] fromDictionary:jsonDic];
    [_tWebview setOption:option];
}

-(void)showStackedLineDemo{
    
    PYOption *option = [[PYOption alloc] init];
    option.tooltip = [[PYTooltip alloc] init];
    option.tooltip.trigger = @"axis";
    option.legend = [[PYLegend alloc] init];
    option.legend.data = @[@"邮件营销",@"视频广告",@"直接访问",@"搜索引擎"];//@"联盟广告",
    
    PYGrid *grid = [[PYGrid alloc] init];
    grid.x = @(40);
    grid.x2 = @(50);
    
    option.grid = grid;
    option.toolbox = [[PYToolbox alloc] init];
    option.toolbox.show = NO;
    option.toolbox.feature = [[PYToolboxFeature alloc] init];
    option.toolbox.feature.mark = [[PYToolboxFeatureMark alloc] init];
    option.toolbox.feature.mark.show = YES;
    option.toolbox.feature.dataView = [[PYToolboxFeatureDataView alloc] init];
    option.toolbox.feature.dataView.show = YES;
    option.toolbox.feature.dataView.readOnly = NO;
    option.toolbox.feature.magicType = [[PYToolboxFeatureMagicType alloc] init];
    option.toolbox.feature.magicType.show = YES;
    option.toolbox.feature.magicType.type = @[@"line", @"bar", @"stack", @"tiled",@"funnel"];
    option.toolbox.feature.restore = [[PYToolboxFeatureRestore alloc] init];
    option.toolbox.feature.restore.show = YES;
    option.toolbox.feature.saveAsImage = [[PYToolboxFeatureSaveAsImage alloc] init];
    option.toolbox.feature.saveAsImage.show = YES;
    option.calculable = YES;
    
    PYAxis *xAxis = [[PYAxis alloc] init];
    xAxis.type = @"category";
    xAxis.boundaryGap = @(NO);
    xAxis.data = @[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"];
    option.xAxis = [[NSMutableArray alloc] initWithObjects:xAxis, nil];
    
    PYAxis *yAxis = [[PYAxis alloc] init];
    yAxis.type = @"value";
    option.yAxis = [[NSMutableArray alloc] initWithObjects:yAxis, nil];
    NSMutableArray *serieses = [[NSMutableArray alloc] init];
    
    PYCartesianSeries *series1 = [[PYCartesianSeries alloc] init];
    series1.name = @"邮件营销";
    series1.type = @"line";
    series1.stack = @"总量";
    series1.data = @[@(120),@(132),@(101),@(134),@(90),@(230),@(210)];
    [serieses addObject:series1];
    
//    PYCartesianSeries *series2 = [[PYCartesianSeries alloc] init];
//    series2.name = @"联盟广告";
//    series2.type = @"line";
//    series2.stack = @"总量";
//    series2.data = @[@(220), @(182), @(191), @(234), @(290), @(330), @(310)];
//    [serieses addObject:series2];
    
    PYCartesianSeries *series3 = [[PYCartesianSeries alloc] init];
    series3.name = @"视频广告";
    series3.type = @"line";
    series3.stack = @"总量";
    series3.data = @[@(150), @(232), @(201), @(153), @(190), @(330), @(410)];
    [serieses addObject:series3];
    
    PYCartesianSeries *series4 = [[PYCartesianSeries alloc] init];
    series4.name = @"直接访问";
    series4.type = @"line";
    series4.stack = @"总量";
    series4.data = @[@(320), @(332), @(301), @(334), @(390), @(330), @(320)];
    [serieses addObject:series4];
    
    PYCartesianSeries *series5 = [[PYCartesianSeries alloc] init];
    series5.name = @"搜索引擎";
    series5.type = @"line";
    series5.stack = @"总量";
    series5.data = @[@(820), @(932), @(901), @(934), @(1290), @(1330), @(1320)];
    [serieses addObject:series5];
    
    [option setSeries:serieses];
    [_tWebview setOption:option];
}

-(void)showLouDouDemo{
    
    PYOption *option = [[PYOption alloc] init];
    option.tooltip = [[PYTooltip alloc] init];
    option.tooltip.trigger = @"item";
    option.legend = [[PYLegend alloc] init];
    option.legend.data = @[@"邮件营销",@"联盟广告",@"视频广告",@"直接访问",@"搜索引擎"];
    
    
    option.toolbox = [[PYToolbox alloc] init];
    option.toolbox.show = NO;
    option.toolbox.feature = [[PYToolboxFeature alloc] init];
    option.toolbox.feature.mark = [[PYToolboxFeatureMark alloc] init];
    option.toolbox.feature.mark.show = YES;
    option.toolbox.feature.dataView = [[PYToolboxFeatureDataView alloc] init];
    option.toolbox.feature.dataView.show = YES;
    option.toolbox.feature.dataView.readOnly = NO;
    option.toolbox.feature.magicType = [[PYToolboxFeatureMagicType alloc] init];
    option.toolbox.feature.magicType.show = YES;
    option.toolbox.feature.magicType.type = @[@"line", @"bar", @"stack", @"tiled",@"funnel"];
    option.toolbox.feature.restore = [[PYToolboxFeatureRestore alloc] init];
    option.toolbox.feature.restore.show = YES;
    option.toolbox.feature.saveAsImage = [[PYToolboxFeatureSaveAsImage alloc] init];
    option.toolbox.feature.saveAsImage.show = YES;
    option.calculable = YES;
    
    NSMutableArray *serieses12 = [[NSMutableArray alloc] init];
    
    PYLabel *label=[[PYLabel alloc] init];
    label.show=YES;
    label.position=@"inside";
    label.textStyle.fontSize=[NSNumber numberWithInt:20];
    [serieses12 addObject:label];
    
    
    PYLabelLine *labelLine=[[PYLabelLine alloc] init];
    labelLine.show=YES;
    labelLine.length=[NSNumber numberWithInt:10];
    labelLine.lineStyle.width=[NSNumber numberWithInt:1];
    labelLine.lineStyle.type=@"solid";
    [serieses12 addObject:labelLine];
    
    PYItemStyle *itemStyle=[[PYItemStyle alloc] init];
    [itemStyle.normal.borderColor setColor:[UIColor lightGrayColor]];
    itemStyle.normal.borderWidth=[NSNumber numberWithFloat:1.0f];
    [serieses12 addObject:itemStyle];
    
    PYSeries *serieses=[[PYSeries alloc] init];
    serieses.name=@"漏斗";
    serieses.type=@"funnel";
    NSDictionary *tmp1=[NSDictionary dictionaryWithObjectsAndKeys:@"邮件营销",@"name",@90,@"value",nil];
    NSDictionary *tmp2=[NSDictionary dictionaryWithObjectsAndKeys:@"联盟广告",@"name",@70,@"value",nil];
    NSDictionary *tmp3=[NSDictionary dictionaryWithObjectsAndKeys:@"视频广告",@"name",@60,@"value",nil];
    NSDictionary *tmp4=[NSDictionary dictionaryWithObjectsAndKeys:@"直接访问",@"name",@80,@"value",nil];
    NSDictionary *tmp5=[NSDictionary dictionaryWithObjectsAndKeys:@"搜索引擎",@"name",@100,@"value",nil];
    serieses.data=[NSArray arrayWithObjects:tmp1,tmp2,tmp3,tmp4,tmp5, nil];
    
    [serieses12 addObject:serieses];
    [option setSeries:serieses12];
    [_tWebview setOption:option];
}


-(void)showBinDemo{
    
//    PYOption *option = [[PYOption alloc] init];
//
//    option.tooltip = [[PYTooltip alloc] init];
//    option.tooltip.trigger = @"item";
//    option.tooltip.formatter=@"{a} <br/>{b} : {c} ({d}%)";
//    option.legend = [[PYLegend alloc] init];
//    option.legend.data = @[@"邮件营销",@"联盟广告",@"视频广告",@"直接访问",@"搜索引擎"];
//    option.legend.orient=@"horizontal";
//
//    NSMutableArray *serieses12 = [[NSMutableArray alloc] init];
//    
//    PYPieSeries *serieses=[[PYPieSeries alloc] init];
//    serieses.name=@"漏斗123";
//    serieses.type=@"pie";
//    serieses.radius=@"45%";
//    serieses.center=[NSArray arrayWithObjects:@"50%",@"50%",nil];
//    
//    NSDictionary *tmp1=[NSDictionary dictionaryWithObjectsAndKeys:@"邮件营销",@"name",@90,@"value",nil];
//    NSDictionary *tmp2=[NSDictionary dictionaryWithObjectsAndKeys:@"联盟广告",@"name",@70,@"value",nil];
//    NSDictionary *tmp3=[NSDictionary dictionaryWithObjectsAndKeys:@"视频广告",@"name",@60,@"value",nil];
//    NSDictionary *tmp4=[NSDictionary dictionaryWithObjectsAndKeys:@"直接访问",@"name",@80,@"value",nil];
//    NSDictionary *tmp5=[NSDictionary dictionaryWithObjectsAndKeys:@"搜索引擎",@"name",@100,@"value",nil];
//    serieses.data=[NSArray arrayWithObjects:tmp1,tmp2,tmp3,tmp4,tmp5, nil];
//    
//    [serieses12 addObject:serieses];
//    [option setSeries:serieses12];
//    [_tWebview setOption:option];
    
    NSString *basicPieJson = @"{\"title\":{},\"tooltip\":{\"trigger\":\"item\",\"formatter\":\"{a} <br/>{b} : {c} ({d}%)\"},\"legend\":{\"orient\":\"horizontal\",\"left\":\"left\",\"data\":[\"直接访问\",\"邮件营销\",\"联盟广告\",\"视频广告\",\"搜索引擎\"]},\"series\":[{\"name\":\"访问来源\",\"type\":\"pie\",\"radius\":\"45%\",\"center\":[\"50%\",\"50%\"],\"data\":[{\"value\":335,\"name\":\"直接访问\"},{\"value\":310,\"name\":\"邮件营销\"},{\"value\":234,\"name\":\"联盟广告\"},{\"value\":135,\"name\":\"视频广告\"},{\"value\":1548,\"name\":\"搜索引擎\"}]}]}";
    NSData *jsonData = [basicPieJson dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    PYOption *option = [RMMapper objectWithClass:[PYOption class] fromDictionary:jsonDic];
    [_tWebview setOption:option];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
