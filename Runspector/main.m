//
//  main.m
//  Runspector
//
//  Created by Keith Lee on 1/16/13.
//  Copyright (c) 2013 Keith Lee. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are
//  permitted provided that the following conditions are met:
//
//   1. Redistributions of source code must retain the above copyright notice, this list of
//      conditions and the following disclaimer.
//
//   2. Redistributions in binary form must reproduce the above copyright notice, this list
//      of conditions and the following disclaimer in the documentation and/or other materials
//      provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY Keith Lee ''AS IS'' AND ANY EXPRESS OR IMPLIED
//  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
//  FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL Keith Lee OR
//  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
//  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
//  SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
//  ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
//  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
//  ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
//  The views and conclusions contained in the software and documentation are those of the
//  authors and should not be interpreted as representing official policies, either expressed
//  or implied, of Keith Lee.

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

// Test class 1
@interface TestClass1 : NSObject { @public int myInt; }
@end
@implementation TestClass1
@end

int main(int argc, const char * argv[])
{
  @autoreleasepool
  {    
    // Create a few instances of one class and display its data
    TestClass1 *tc1A = [[TestClass1 alloc] init];
    tc1A->myInt = 0xa5a5a5a5;
    TestClass1 *tc1B = [[TestClass1 alloc] init];
    tc1B->myInt = 0xc3c3c3c3;
    long tc1Size = class_getInstanceSize([TestClass1 class]);
    NSData *obj1Data = [NSData dataWithBytes:(__bridge const void *)(tc1A)
                                     length:tc1Size];
    NSData *obj2Data = [NSData dataWithBytes:(__bridge const void *)(tc1B)
                                      length:tc1Size];
    NSLog(@"TestClass1 object tc1 contains %@", obj1Data);
    NSLog(@"TestClass1 object tc2 contains %@", obj2Data);    
    NSLog(@"TestClass1 memory address = %p", [TestClass1 class]);

    // Retrieve and display the data for the TestClass1 class object
    id testClz = objc_getClass("TestClass1");
    long tcSize = class_getInstanceSize([testClz class]);
    NSData *tcData = [NSData dataWithBytes:(__bridge const void *)(testClz)
                                     length:tcSize];
    NSLog(@"TestClass1 class contains %@", tcData);
    NSLog(@"TestClass1 superclass memory address = %p", [TestClass1 superclass]);
    
    // Retrieve and display metaclass data
    id metaClass = objc_getMetaClass("TestClass1");
    long mclzSize = class_getInstanceSize([metaClass class]);
    NSData *mclzData = [NSData dataWithBytes:(__bridge const void *)(metaClass)
                                      length:mclzSize];
    NSLog(@"TestClass1 metaclass contains %@", mclzData);
    class_isMetaClass(metaClass) ?
      NSLog(@"Class %s is a metaclass", class_getName(metaClass)) :
      NSLog(@"Class %s is not a metaclass", class_getName(metaClass));
  }
  return 0;
}

