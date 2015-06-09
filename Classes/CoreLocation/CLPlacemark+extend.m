//
//  CLPlacemark+extend.m
//  ExpressBrother
//
//  Created by Steven on 15/5/3.
//  Copyright (c) 2015年 Neva. All rights reserved.
//

#import "CLPlacemark+extend.h"
#import "NSString+extend.h"

@implementation CLPlacemark (CLPlacemark_address)

- (NSString *)shortAddress
{
    NSString * address = self.name;
    
    // 过滤
    NSArray * tmp = @[
                      SAVE_STRING(self.thoroughfare),    // 街道
                      SAVE_STRING(self.subThoroughfare), // 门牌号
                      SAVE_STRING(self.locality),        // 市
                      SAVE_STRING(self.subLocality),     // 区
                      SAVE_STRING(self.country),         // 国家
                      SAVE_STRING(self.administrativeArea),     // 省
                      SAVE_STRING(self.subAdministrativeArea)   // 县
                      ];
    for (NSString * s in tmp)
    {
        if (s.length)
        {
            address = [address stringByReplacingOccurrencesOfString:s withString:@""];
        }
    }
    if (address.length == 0)
    {
        //街道
        NSString * thoroughfare = self.thoroughfare;
        //门牌号
        NSString * subThoroughfare = self.subAdministrativeArea;
        
        if (thoroughfare.length > 0)
        {
            address = [address stringByAppendingString:thoroughfare];
        }
        if (subThoroughfare.length > 0)
        {
            address = [address stringByAppendingString:subThoroughfare];
        }
    }
    return address;
}

- (NSString *)aboutStreet
{
    NSString * address = @"";
    // 县
    NSString * subAdministrativeArea = self.subAdministrativeArea;
    // 区
    NSString * subLocality = self.subLocality;
    // 街
    NSString * thoroughfare = self.thoroughfare;
    
    if (subAdministrativeArea.length > 0)
    {
        address = [address stringByAppendingString:subAdministrativeArea];
    }
    if (subLocality.length > 0)
    {
        address = [address stringByAppendingString:subLocality];
    }
    if (thoroughfare.length > 0)
    {
        address = [address stringByAppendingString:thoroughfare];
    }
    return address;
}

@end
