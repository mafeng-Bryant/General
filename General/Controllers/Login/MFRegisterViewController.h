//
//  MFRegisterViewController.h
//  General
//
//  Created by patpat on 16/6/14.
//  Copyright © 2016年 test. All rights reserved.
//

#import "MFBaseViewController.h"
#import "TPKeyboardAvoidingTableView.h"

typedef enum {
    RegisterTypeEmail = 0,
    RegisterTypePhone = 1
}RegisterType;


@interface MFRegisterViewController : MFBaseViewController

-(instancetype)initWithRegisterType:(RegisterType)type;

@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingTableView *tableView;



@end
