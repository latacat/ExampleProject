//
//  BOUSendSMSApi.h
//  BeijingOpenUniversity
//
//  Created by zhongda on 2018/11/30.
//  Copyright © 2018 zhongdayingcai. All rights reserved.
//

#import "SGBaseApi.h"

NS_ASSUME_NONNULL_BEGIN

@interface SGSendSMSApi : SGBaseApi

- (instancetype)initWithTypeName:(NSString *)typeName
                        phoenNum:(NSString *)phoneNum
                        sendType:(NSInteger)type;

@end

NS_ASSUME_NONNULL_END
