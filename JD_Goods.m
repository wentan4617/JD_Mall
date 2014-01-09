//
//  JD_Goods.m
//  京东商城
//
//  Created by TY on 14-1-8.
//  Copyright (c) 2014年 张太松. All rights reserved.
//

#import "JD_Goods.h"
#import "JD_Goods_Info.h"
#import "JD_Goods_Evaluate.h"
#import "JD_ShopCar.h"
#import "ASIFormDataRequest.h"

@interface JD_Goods ()

@end

@implementation JD_Goods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //ScrollView
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _scrollView.contentSize =CGSizeMake(self.view.frame.size.width, 789);
    _scrollView.showsVerticalScrollIndicator = NO;//隐藏滚动条
    [self.view addSubview:_scrollView];
    //返回按钮
    UIImageView *backButton = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"back"]];
    backButton.frame = CGRectMake(10, 20, 58, 58);
    backButton.layer.cornerRadius = 29;
    backButton.userInteractionEnabled = YES;
    UITapGestureRecognizer *lTap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(popToView:)];
    [backButton addGestureRecognizer:lTap1];
    [self.view addSubview:backButton];
    //去往购物车按钮
    UIImageView *carButton = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"car"]];
    carButton.frame = CGRectMake(self.view.frame.size.width-68, 20, 58, 58);
    carButton.userInteractionEnabled = YES;
    UITapGestureRecognizer *lTap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(popToShopCar:)];
    [carButton addGestureRecognizer:lTap2];
    [self.view addSubview:carButton];
    //释放
    [backButton release];
    [carButton release];
    [lTap1 release];
    [lTap2 release];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //隐藏NavigationBar
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    //请求数据
    NSURL *goodsURL = [NSURL URLWithString:@"http://192.168.1.136/shop/getgoodsinfo.php"];
    ASIFormDataRequest *lRequest = [ASIFormDataRequest requestWithURL:goodsURL];
    [lRequest setPostValue:[JD_DataManager shareGoodsDataManager].goodsID forKey:@"goodsid"];
    [lRequest startSynchronous];
    NSDictionary *lDictionary = [NSJSONSerialization JSONObjectWithData:[lRequest responseData] options:NSJSONReadingAllowFragments error:nil];
    _goodsInfo = [lDictionary objectForKey:@"msg"];
    [self setGoodsInfo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [_scrollView release];
    [super dealloc];
}
#pragma mark - BackButton
-(void)popToView:(UITapGestureRecognizer *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)popToShopCar:(UITapGestureRecognizer *)sender
{
    NSLog(@"ToShopCar");
}
#pragma mark - setGoods
-(void)setGoodsInfo
{
    NSURL *imageURL = [NSURL URLWithString:[@"http://192.168.1.136/shop/goodsimage/" stringByAppendingString:[_goodsInfo objectForKey:@"headerimage"]]];
    NSData *lData = [NSData dataWithContentsOfURL:imageURL];
    UIImage *goodsImage = [UIImage imageWithData:lData];
    UIImageView *headerImageView = [[UIImageView alloc]initWithImage:goodsImage];
    headerImageView.frame = CGRectMake(self.view.frame.size.width/2-50, 40, 100, 100);
    [_scrollView addSubview:headerImageView];
    
    UIView *goodsInfo = [[UIView alloc]initWithFrame:CGRectMake(10, 160, 300, 150)];
    goodsInfo.backgroundColor = [UIColor clearColor];
    goodsInfo.layer.cornerRadius = 8;
    [_scrollView addSubview:goodsInfo];
    UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    infoButton.frame = CGRectMake(0, 0, 300, 50);
    infoButton.backgroundColor = [UIColor blueColor];
    [infoButton addTarget:self action:@selector(toGoodsInfo:) forControlEvents:UIControlEventTouchUpInside];
    [goodsInfo addSubview:infoButton];
    UIView *goodsOtherInfo = [[UIView alloc]initWithFrame:CGRectMake(0, 50, 300, 100)];
    goodsOtherInfo.backgroundColor = [UIColor purpleColor];
    [goodsInfo addSubview:goodsOtherInfo];
    
    UIButton *evaluateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    evaluateButton.frame = CGRectMake(10, 330, 300, 50);
    evaluateButton.backgroundColor = [UIColor grayColor];
    [evaluateButton addTarget:self action:@selector(toGoodsEvaluate:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:evaluateButton];
    
    
    [headerImageView release];
    [goodsInfo release];
    [goodsOtherInfo release];
}

-(void)toGoodsInfo:(UIButton *)sender
{
    JD_Goods_Info *lInfo = [[JD_Goods_Info alloc]init];
    [self.navigationController pushViewController:lInfo animated:YES];
    [lInfo release];
}

-(void)toGoodsEvaluate:(UIButton *)sender
{
    JD_Goods_Evaluate *lEvaluate = [[JD_Goods_Evaluate alloc]init];
    [self.navigationController pushViewController:lEvaluate animated:YES];
    [lEvaluate release];
}

@end