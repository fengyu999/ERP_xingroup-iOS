//
//  RealmTest.h
//  ERP_xingroup-iOS
//
//  Created by xin-group on 16/6/6.
//  Copyright © 2016年 xin-group. All rights reserved.
//

#import <Realm/Realm.h>

@interface RealmTest : RLMObject

@end

// This protocol enables typed collections. i.e.:
// RLMArray<RealmTest>
RLM_ARRAY_TYPE(RealmTest)
