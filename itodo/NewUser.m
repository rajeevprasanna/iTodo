//
//  NewUser.m
//  itodo
//
//  Created by ramesh on 07/06/14.
//  Copyright (c) 2014 xenovus. All rights reserved.
//

#import "NewUser.h"


@implementation NewUser


- (void)encodeWithCoder:(NSCoder *)encoder
{
    //Encode properties, other class variables, etc
	[encoder encodeObject:self.username forKey:@"username"];
	[encoder encodeObject:self.password forKey:@"password"];
	[encoder encodeObject:self.email forKey:@"email"];
}
- (id)initWithCoder:(NSCoder *)decoder
{
	self = [super init];
	if( self != nil )
	{
        //decode properties, other class vars
		self.username = [decoder decodeObjectForKey:@"username"];
		self.password = [decoder decodeObjectForKey:@"password"];
		self.email = [decoder decodeObjectForKey:@"email"];
	}
	return self;
}

@end
