//
//  NewUser.h
//  itodo
//
//  Created by ramesh on 07/06/14.
//  Copyright (c) 2014 xenovus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewUser : NSObject
@property(weak,nonatomic) NSString *username;
@property (weak,nonatomic) NSString *password;
@property (weak, nonatomic) NSString *email;

- (void)encodeWithCoder:(NSCoder *)encoder;
- (id)initWithCoder:(NSCoder *)decoder;

@end
