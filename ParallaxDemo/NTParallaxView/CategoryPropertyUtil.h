//
//  Util.h
//  PathPullToRefreshDemo
//
//  Created by demon on 8/29/13.
//  Copyright (c) 2013 demonNico. All rights reserved.
//

#ifndef PathPullToRefreshDemo_Util_h
#define PathPullToRefreshDemo_Util_h

#import <objc/runtime.h>
#define SYNTHESIZE_CATEGORY_OBJ_PROPERTY(propertyGetter, propertySetter)                                                             \
- (id) propertyGetter {                                                                                                             \
return objc_getAssociatedObject(self, @selector( propertyGetter ));                                                             \
}                                                                                                                                   \
- (void) propertySetter (id)obj{                                                                                                    \
objc_setAssociatedObject(self, @selector( propertyGetter ), obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);                            \
}


#define SYNTHESIZE_CATEGORY_VALUE_PROPERTY(valueType, propertyGetter, propertySetter)                                                \
- (valueType) propertyGetter {                                                                                                      \
valueType ret = {0};                                                                                                                  \
[objc_getAssociatedObject(self, @selector( propertyGetter )) getValue:&ret];                                                    \
return ret;                                                                                                                     \
}                                                                                                                                   \
- (void) propertySetter (valueType)value{                                                                                           \
NSValue *valueObj = [NSValue valueWithBytes:&value objCType:@encode(valueType)];                                                \
objc_setAssociatedObject(self, @selector( propertyGetter ), valueObj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);                       \
}


#endif
