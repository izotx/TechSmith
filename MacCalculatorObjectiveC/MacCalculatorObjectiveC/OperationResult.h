//
//  OperationResult.h
//  MacCalculatorObjectiveC
//
//  Created by Janusz Chudzynski on 11/29/18.
//  Copyright © 2018 Janusz Chudzynski. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OperationResult : NSObject
    @property NSString * message;
    @property BOOL error;
    @property int value;

@end
