//
//  MFBaseModel.h
//  General
//
//  Created by patpat on 16/6/13.
//  Copyright © 2016年 test. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface MFBaseModel : MTLModel<MTLJSONSerializing>

- (BOOL)save;

- (BOOL)saveToPath:(NSString*)path;

+ (id)readByPath:(NSString*)path;

- (NSString*)stringFormat:(id)obj;



@end
