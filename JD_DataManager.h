//
//  JD_DataManager.h
//  京东商城
//
//  Created by TY on 14-1-8.
//  Copyright (c) 2014年 张闽. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JD_DataManager : NSObject
{
    NSMutableArray *UserManage;
}
@property(nonatomic,retain)NSString *goodsID;//商品的id
@property(nonatomic,retain)NSString *userID;//用户id
@property(nonatomic,retain)NSString *cartID;//购物车id
@property(nonatomic,retain)NSString *orderID;//订单id
@property(nonatomic,retain)NSString *addressID;//地址id
@property(nonatomic,retain)NSString *star;
@property(nonatomic,assign)BOOL UserState;//用户状态
@property(nonatomic,assign)BOOL UserRegisterState;//用户注册状态
@property(nonatomic,retain)NSMutableArray *BuyCardInfoArray;//购物车数据
@property(nonatomic,retain)NSMutableArray *AddressArray;//地址
+(JD_DataManager *)shareGoodsDataManager;
-(UIImage *)getgoodsImage:(NSString *)imageString;//商品图片
@property(nonatomic,retain)NSMutableArray *OrderArray;//商品订单
-(void)downloadDataWithHTTPMethod:(NSString *)method WithBodyString:(NSString *)bodystring WithURLString:(NSString *)urlstring AndSuccess:(void (^)(NSData *))success AndFailed:(void (^)(void))failed;//异步请求  URL只需传http://192.168.1.135/shop/之后的
-(NSURLRequest *)requestWithURLString:(NSString *)string;//webView
-(NSMutableArray *)UserManage;
@end
