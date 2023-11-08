//
//  Model.m
//  ToDoList
//
//  Created by Mustafa on 30/08/2023.
//

#import "Model.h"

@implementation Model


- (void)encodeWithCoder:( NSCoder *)coder {
    [coder encodeObject:_name forKey:@"name"];
    [coder encodeObject:_desc forKey:@"desc"];
    [coder encodeInt:_prio forKey:@"pri"];
    [coder encodeInt:_status forKey:@"status"];
    [coder encodeObject:_date forKey:@"date"];
    [coder encodeInt:_idNum forKey:@"idNum"];
}

- (id)initWithCoder:( NSCoder *)coder {
    
    
    if((self = [super init])){
        _name = [coder decodeObjectOfClass:[NSString class] forKey:@"name"];
        _desc = [coder decodeObjectOfClass:[NSString class] forKey:@"desc"];
        _prio = [coder decodeIntForKey:@"pri"];
        _idNum = [coder decodeIntForKey:@"idNum"];
        _status = [coder decodeIntForKey:@"status"];
        _date = [coder decodeObjectOfClass:[NSDate class] forKey:@"date"];
      
        
    }
    return self;
}



+(BOOL)supportsSecureCoding{
    return YES;
}

@end
