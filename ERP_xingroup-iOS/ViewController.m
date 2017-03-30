//
//  ViewController.m
//  ERP_xingroup-iOS
//
//  Created by xin-group on 16/3/24.
//  Copyright © 2016年 xin-group. All rights reserved.
//

#import "ViewController.h"
#import "ClientTool.h"
#import <RESideMenu/RESideMenu.h>
#import "FirstNextViewController.h"
#import "TopViewTableViewCell.h"
#import "MyActivity.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <FLEX/FLEXManager.h>
#import <EventKit/EventKit.h>

static NSString *cellIdstring=@"cellIdstringcell";

@interface ViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,UITabBarControllerDelegate>{
    UIImageView *dotImage;
}
@property(nonatomic,strong) UIScrollView *bigScrollView;
@property(nonatomic,strong) UIScrollView *smallScrollView;
@property(nonatomic,strong) NSMutableArray *smalllabelArray;

@property (strong, nonatomic) NSMutableArray *scrollTableViews;
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (nonatomic,assign) NSInteger currentPage;

@end

@implementation ViewController

-(void)initDataSource{
    _dataSource = [[NSMutableArray alloc] initWithCapacity:6];
    for (int i = 1; i <= 6; i ++) {
//        NSMutableArray *tempArray  = [[NSMutableArray alloc] initWithCapacity:9];
//        for (int j = 1; j <= 2; j ++) {
            NSString *tempStr = [NSString stringWithFormat:@"我是第%d个TableView的数据",i];
//            [tempArray addObject:tempStr];
//        }
        [_dataSource addObject:tempStr];
    }
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{

//    NSArray *tabBarItems = self.navigationController.tabBarController.tabBar.items;
//    UITabBarItem *personCenterTabBarItem = [tabBarItems objectAtIndex:1];
    if (self.navigationController.tabBarController.selectedIndex==1) {
//        personCenterTabBarItem.badgeValue = nil;
        dotImage.hidden=YES;
    }
}

- (NSString *)transform:(NSString *)chinese{
    //将NSString装换成NSMutableString
    NSMutableString *pinyin = [chinese mutableCopy];
    
    //将汉字转换为拼音(带音标)
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    NSLog(@"%@", pinyin);
    
    //去掉拼音的音标
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    NSLog(@"%@", pinyin);
    
    //返回最近结果
    return pinyin;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[self rac_signalForSelector:@selector(tableView:didSelectRowAtIndexPath:)] subscribeNext:^(id x) {
        
        UITableView *tmpTableView=(UITableView *)[x objectAtIndex:0];
        
        NSLog(@"tmpTableView.tag = %ld",tmpTableView.tag);
    }];
    
    NSLog(@"transform = %@",[self transform:@"华盛顿和飞机上电视电话号开始的附件是对话框上的家伙"]);
    
//    [self getDateInfo];
//    [self getAllDaysWithCalender];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor=[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title=MAINTITLE;
    [self setLeftItem];
    
    self.navigationController.tabBarController.delegate=self;
    
//    NSArray *tabBarItems = self.navigationController.tabBarController.tabBar.items;
//    UITabBarItem *personCenterTabBarItem = [tabBarItems objectAtIndex:1];
//    personCenterTabBarItem.badgeValue = @"2";//显示消息条数为2
    
    
    dotImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"newPic"]];
    dotImage.backgroundColor = [UIColor clearColor];
    CGRect tabFrame =self.navigationController.tabBarController.tabBar.frame;
    CGFloat x =ceilf(0.8 * tabFrame.size.width);
    CGFloat y =ceilf(0.1 * tabFrame.size.height);
    dotImage.frame =CGRectMake(x, y, 28,16);
    dotImage.hidden=NO;
    [self.navigationController.tabBarController.tabBar addSubview:dotImage];
    
    
    _smalllabelArray=[NSMutableArray array];
    _scrollTableViews = [[NSMutableArray alloc] init];
    
     [self loadNetData];
    
    if (self.firstLoadBool) {//第一次启动 页面隐藏
       
        UIButton *pushButton = [UIButton buttonWithType:UIButtonTypeCustom];
        pushButton.frame = CGRectMake(100.0f, 340.0f, 40.0f, 25.0f);
        pushButton.backgroundColor=[UIColor redColor];
        [pushButton addTarget:self action:@selector(pushButtonAction) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:pushButton];
        

        _smallScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 40)];
        _smallScrollView.backgroundColor=[UIColor yellowColor];
        _smallScrollView.showsVerticalScrollIndicator=NO;
        _smallScrollView.showsHorizontalScrollIndicator=NO;
        [_smallScrollView setContentOffset:CGPointMake(0, 40)];
        [_smallScrollView setContentSize:CGSizeMake(WIDTH/3*6, 40)];
        _smallScrollView.pagingEnabled=YES;
        [self.view addSubview:_smallScrollView];
        
        _bigScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, WIDTH, HEIGHT-44-20-44-44)];
        _bigScrollView.backgroundColor=[UIColor greenColor];
        _bigScrollView.showsVerticalScrollIndicator=NO;
        _bigScrollView.showsHorizontalScrollIndicator=NO;
        [_bigScrollView setContentSize:CGSizeMake(WIDTH*6, HEIGHT-44-20-44-44)];
        _bigScrollView.pagingEnabled=YES;
        _bigScrollView.delegate=self;
        _bigScrollView.tag=2000;
        [self.view addSubview:_bigScrollView];
        
        for (int i=0; i<6; i++) {
            UILabel *smalltitleLabel=[[UILabel alloc] initWithFrame:CGRectMake(WIDTH/3*i, 0, WIDTH/3, 40)];
            if (i==0) {
                smalltitleLabel.backgroundColor=[UIColor blueColor];
            }else{
                smalltitleLabel.backgroundColor=[UIColor greenColor];
            }
            smalltitleLabel.textColor=[UIColor blackColor];
            smalltitleLabel.textAlignment=NSTextAlignmentCenter;
            smalltitleLabel.font=[UIFont systemFontOfSize:15.0f];
            smalltitleLabel.text=[NSString stringWithFormat:@"smallScroll %d",i];
            smalltitleLabel.tag=i+1000;
            smalltitleLabel.userInteractionEnabled=YES;
            
            [_smallScrollView addSubview:smalltitleLabel];
            [_smalllabelArray addObject:smalltitleLabel];
            
            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSmallLabelAction:)];
            [smalltitleLabel addGestureRecognizer:tap];
        }
        [self initDowmTabview];
    }
}

#pragma mark --根据scrollView的滚动位置复用tableView，减少内存开支
-(void)updateTableWithPageNumber: (NSUInteger)pageNumber{
    
    int tabviewTag = pageNumber % 2;
    CGRect tableNewFrame = CGRectMake(pageNumber * WIDTH, 0, WIDTH, _bigScrollView.frame.size.height);
    
    UITableView *reuseTableView = _scrollTableViews[tabviewTag];
    reuseTableView.frame = tableNewFrame;
    [reuseTableView reloadData];
}

-(void)modifyTopScrollViewPositiong: (UIScrollView *)scrollView{
    if ([_smallScrollView isEqual:scrollView]) {
        
        CGFloat contentOffsetX = _smallScrollView.contentOffset.x;
        CGFloat width = WIDTH/3;
        int count = (int)contentOffsetX/(int)width;
        CGFloat step = (int)contentOffsetX%(int)width;
        CGFloat sumStep = width * count;
        if (step > width/2) {
            sumStep = width * (count + 1);
        }
        [_smallScrollView setContentOffset:CGPointMake(sumStep, 0) animated:YES];
        return;
    }
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self scrollViewDidEndDecelerating:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if ([scrollView isEqual:_bigScrollView]) {
        _currentPage = _bigScrollView.contentOffset.x/WIDTH;
        [self updateTableWithPageNumber:_currentPage];
        return;
    }
    [self modifyTopScrollViewPositiong:scrollView];
}

#pragma mark - UIScrollViewDalegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView.tag==2000) {
        NSInteger pageInt= scrollView.contentOffset.x/self.view.frame.size.width;
        
        [UIView animateWithDuration:0.5 animations:^{
            if (pageInt>2) {
                _smallScrollView.contentOffset=CGPointMake(self.view.frame.size.width, 0);
            }else{
                _smallScrollView.contentOffset=CGPointMake(0, 0);
            }
        }];
        
        for (UILabel *smallllabel in _smalllabelArray) {
            if (smallllabel.tag==1000+pageInt){
                smallllabel.backgroundColor=[UIColor blueColor];
            }else{
                smallllabel.backgroundColor=[UIColor greenColor];
            }
        }
    }
}

- (void)initDowmTabview{

    [UITableView appearance].separatorInset=UIEdgeInsetsZero;
    
    for (int i=0; i<2; i++) {
        
        UITableView *bigTableView=[[UITableView alloc] initWithFrame:CGRectMake(WIDTH*i, 0, WIDTH, _bigScrollView.frame.size.height) style:UITableViewStylePlain];
        bigTableView.tableFooterView=[[UIView alloc] init];
        bigTableView.tableHeaderView=[[UIView alloc] init];
        bigTableView.showsVerticalScrollIndicator=NO;
        bigTableView.showsHorizontalScrollIndicator=NO;
        bigTableView.backgroundColor=[UIColor clearColor];
        bigTableView.delegate=self;
        bigTableView.dataSource=self;
        bigTableView.tag=3000+i;
        [bigTableView registerClass:[TopViewTableViewCell class] forCellReuseIdentifier:cellIdstring];
        
        [_scrollTableViews addObject:bigTableView];
        [_bigScrollView addSubview:bigTableView];
        
        if ([bigTableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [bigTableView setSeparatorInset:UIEdgeInsetsZero];
        }
        
        if ([bigTableView respondsToSelector:@selector(setLayoutMargins:)])  {
            [bigTableView setLayoutMargins:UIEdgeInsetsZero];
        }
    }
}

- (void)tapSmallLabelAction:(UITapGestureRecognizer *)tap{
    
    _bigScrollView.contentOffset=CGPointMake(WIDTH*(tap.view.tag-1000), 0);
    int tabviewTag = (tap.view.tag-1000) % 2;
    CGRect tableNewFrame = CGRectMake((tap.view.tag-1000) * WIDTH, 0, WIDTH, _bigScrollView.frame.size.height);
    _currentPage = (tap.view.tag-1000);
    [UIView animateWithDuration:0.5f animations:^{
        UITableView *reuseTableView = _scrollTableViews[tabviewTag];
        reuseTableView.frame = tableNewFrame;
        [reuseTableView reloadData];
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    //获取日历事件
    EKEventStore* eventStore = [[EKEventStore alloc] init];
    NSDate* ssdate = [NSDate dateWithTimeIntervalSinceNow:-3600*24];//事件段，开始时间
    NSDate* ssend = [NSDate dateWithTimeIntervalSinceNow:3600*24];//结束时间，取中间
    NSPredicate* predicate = [eventStore predicateForEventsWithStartDate:ssdate
                                                                 endDate:ssend
                                                               calendars:nil];
    
    NSArray* events = [eventStore eventsMatchingPredicate:predicate];//数组里面就是时间段中的EKEvent事件数组
    NSLog(@"events = %@",events);
    //往日历写事件
//    EKEvent *event  = [EKEvent eventWithEventStore:eventStore];
//    NSDate *startDate = [[NSDate alloc] init];
//    NSDate *endDate  = [[NSDate alloc] init];
//    event.title     = @"New event test";
//    event.startDate = startDate;
//    event.endDate   = endDate;
//    
//    event.location = @"上海市，静安区";
//    [event setCalendar:[eventStore defaultCalendarForNewEvents]];
//    __block NSError *err;
//    //ios 6以后和之前方法不一样
//    if([eventStore respondsToSelector:@selector(requestAccessToEntityType:completion:)]) {
//        [eventStore requestAccessToEntityType:EKEntityTypeEvent
//                                   completion:^(BOOL granted, NSError *error) {
//                                       dispatch_async(dispatch_get_main_queue(), ^{
//                                           if (granted) {
//                                               [eventStore saveEvent:event span:EKSpanFutureEvents commit:YES error:&err];
//                                           } else {
//                                               NSLog(@"不允许访问日历");
//                                           }
//                                       });
//                                   }];
//    } else {
//        [eventStore saveEvent:event span:EKSpanThisEvent error:&err];
//    }
    
    
    [self initDataSource];
    
    UIColor * color = [UIColor whiteColor];
    NSDictionary * dict = [NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    
    UIImage *navBarImage = [self imageWithColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"navbar_bg"]]];
    //设置statusBar和navigationbar为一体
    [self.navigationController.navigationBar setBackgroundImage:navBarImage forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
    
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    
    if (kAppDelegate.showLeftController == YES){
        [self presentLeftMenuViewController:nil];
        kAppDelegate.showLeftController = NO;
    }
}

-(UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)pushButtonAction{
    FirstNextViewController *firstNextVC=[[FirstNextViewController alloc] init];
    [self.navigationController pushViewController:firstNextVC animated:YES];
}

- (void)setLeftItem{
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0.0f, 0.0f, 20.0f, 20.0f);
    [leftButton setImage:[UIImage imageNamed:@"personCenter"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(presentLeftView) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
}

-(void)presentLeftView{
    
    // This call shows the FLEX toolbar if it's not already shown.
    [[FLEXManager sharedManager] showExplorer];
//    [self.navigationController presentLeftMenuViewController:nil];
}

- (void)dismiss:(id)sender {
    [SVProgressHUD dismiss];
}

- (void)loadNetData{
    //test test

//    [SVProgressHUD showWithStatus:nil];
//    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
//    [ClientTool postUrlPath:@"/pay/payAddRecord" withParamers:nil andBody:@{@"tradeAmount":@"0.01",@"tradeMemberId":@"47"} success:^(id responseObject) {
//        
//        if ([responseObject[@"success"] boolValue]){
//            
//            [SVProgressHUD showSuccessWithStatus:@"成功"];
//            [self performSelector:@selector(dismiss:) withObject:nil afterDelay:1];
//            
//            UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 44+20, 320, self.view.frame.size.height-44-20-44-200)];
//            [imageView sd_setImageWithURL:[NSURL URLWithString:[responseObject[@"content"] objectForKey:@"cover"]]];
//            [self.view addSubview:imageView];
//        }
//        
//    } failure:^(NSError *error) {
//        [SVProgressHUD dismiss];
//    }];
}


- (void)configureCell:(TopViewTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tmpTableview{
//    NSMutableArray *tempArray = _dataSource[_currentPage];
    if (indexPath.row!=[_dataSource count]) {
        cell.fd_enforceFrameLayout = YES; // Enable to use "-sizeThatFits:"
        
        if ([tmpTableview isEqual:_scrollTableViews[_currentPage%2]]) {
            [cell loadEntity:_dataSource[indexPath.row]];
        }
    }
}

#pragma mark - UItableViewDalegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    NSMutableArray *tempArray = _dataSource[_currentPage];
    return _dataSource.count+1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:cellIdstring configuration:^(TopViewTableViewCell *cell) {
        [self configureCell:cell atIndexPath:indexPath tableView:tableView];
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    NSMutableArray *tempArray = _dataSource[_currentPage];
    if (indexPath.row==[_dataSource count]) {
        
        NSString *cellidstring=@"cellidstring";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellidstring];
        if (cell==nil) {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidstring];
        }
        
        cell.textLabel.text=[NSString stringWithFormat:@"%ld",[self getNumberOfDaysInMonth]];
        cell.textLabel.textColor=[UIColor redColor];
        
        CABasicAnimation *animation = [CABasicAnimation animation];
        animation.keyPath = @"position.x";
        animation.fromValue = @50;
        animation.toValue = @150;
        animation.duration = 1;
        
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        
        [cell.textLabel.layer addAnimation:animation forKey:@"basic"];
        cell.textLabel.layer.position = CGPointMake(150, 0);
        
        return cell;
    }else{
        TopViewTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdstring forIndexPath:indexPath];
        [self configureCell:cell atIndexPath:indexPath tableView:tableView];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

//    FirstNextViewController *firstNextVC=[[FirstNextViewController alloc] init];
//    [self.navigationController pushViewController:firstNextVC animated:YES];
    
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"xincap://"]];
    
    [self sharesender];
    
    //在打开应用直线可以用canOpenURL方法来判断是否能够打开该应用,该方法返回一个布尔类型
//    [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"abc://"]];
    
    
//    UIAlertView *alertview=[[UIAlertView alloc] initWithTitle:nil message:@"提示" delegate:self cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
//    alertview.alertViewStyle=UIAlertViewStyleLoginAndPasswordInput;
//    
//    UITextField *nameField = [alertview textFieldAtIndex:0];
//    nameField.placeholder = @"请输入一个名称";
//    
//    UITextField *urlField = [alertview textFieldAtIndex:1];
//    [urlField setSecureTextEntry:NO];
//    urlField.placeholder = @"请输入一个URL";
//    urlField.text = @"http://";
//    
//    [alertview show];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}




-(void)sharesender
{
    //要分享的内容，加要一个数组里边，初始化UIActivityViewController
    NSString *textToShare = @"要分享内容title";
    NSString *description = @"这是我的内容---------";
    UIImage *imageToShare = [UIImage imageNamed:@"personCenter"];
    NSURL *urlToShare = [NSURL URLWithString:@"http://www.iashes.com/"];
    NSArray *activityItems = @[textToShare, description,imageToShare, urlToShare];
    //创建自定义的Activity，加到一个数组里边
    MyActivity *act1 = [[MyActivity alloc]initWithImage:[UIImage imageNamed:@"personCenter"] atURL:@"http://www.iashes.com/" atTitle:@"share Sina" atShareContentArray:activityItems];
    //myActivity是自定义的类，继承于UIActivity
    MyActivity *act2 = [[MyActivity alloc]initWithImage:[UIImage imageNamed:@"personCenter"] atURL:@"http://www.iashes.com/admin.html" atTitle:@"share Renren" atShareContentArray:activityItems];
    
    NSArray *apps = @[act1,act2];
    //创建
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:apps];
    //关闭系统的一些分享
    activityVC.excludedActivityTypes = @[UIActivityTypePostToTwitter,
                                         UIActivityTypeMessage,
                                         UIActivityTypePrint,
                                         UIActivityTypeCopyToPasteboard,
                                         UIActivityTypeAssignToContact,
                                         UIActivityTypeSaveToCameraRoll,
                                         UIActivityTypeAddToReadingList,
                                         UIActivityTypePostToFlickr,
                                         UIActivityTypePostToVimeo,
                                        // UIActivityTypePostToTencentWeibo,
                                         UIActivityTypeAirDrop];
    //模态
    [self presentViewController:activityVC animated:YES completion:nil];
}



#pragma mark - TEST
- (NSInteger)getNumberOfDaysInMonth
{
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar]; // 指定日历的算法
    NSDate * currentDate = [NSDate date];
    // 只要个时间给日历,就会帮你计算出来。这里的时间取当前的时间。
    NSRange range = [calendar rangeOfUnit:NSDayCalendarUnit
                                   inUnit: NSMonthCalendarUnit
                                  forDate:currentDate];
    return range.length;
}

- (void)getDateInfo
{
    NSDate * date  = [NSDate date];
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian]; // 指定日历的算法 NSCalendarIdentifierGregorian,NSGregorianCalendar
    // NSDateComponent 可以获得日期的详细信息，即日期的组成
    NSDateComponents *comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond|NSCalendarUnitWeekOfMonth|NSCalendarUnitWeekday fromDate:date];
    
    NSLog(@"年 = year = %ld",comps.year);
    NSLog(@"月 = month = %ld",comps.month);
    NSLog(@"日 = day = %ld",comps.day);
    NSLog(@"时 = hour = %ld",comps.hour);
    NSLog(@"分 = minute = %ld",comps.minute);
    NSLog(@"秒 = second = %ld",comps.second);
    NSLog(@"星期 =weekDay = %ld ",comps.weekday);
}

/**
 *  获取当月中所有天数是周几
 */
- (void)getAllDaysWithCalender
{
    NSUInteger dayCount = [self getNumberOfDaysInMonth]; //一个月的总天数
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    NSDate * currentDate = [NSDate date];
    
    [formatter setDateFormat:@"yyyy-MM"];
    NSString * str = [formatter stringFromDate:currentDate];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSMutableArray * allDaysArray = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 1; i <= dayCount; i++) {
        
        NSString * sr = [NSString stringWithFormat:@"%@-%ld",str,i];
        NSDate *suDate = [formatter dateFromString:sr];
        [allDaysArray addObject:[self getweekDayWithDate:suDate]];
    }
    NSLog(@"allDaysArray %@ %@",allDaysArray,str);
}

/**
 *  获得某天的数据
 *
 *  获取指定的日期是星期几
 */
- (id) getweekDayWithDate:(NSDate *) date
{
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar]; // 指定日历的算法
    NSDateComponents *comps = [calendar components:NSWeekdayCalendarUnit fromDate:date];
    
    //1是周日，2是周一 3.以此类推
    return @([comps weekday]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
