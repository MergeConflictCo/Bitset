//
//  MCBitsetTests.m
//  Bitset
//
//  Created by Jeremy Tregunna on 2014-03-12.
//  Copyright (c) 2014 Jeremy Tregunna. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MCBitset.h"

@interface MCBitsetTests : XCTestCase
@property (nonatomic, strong) MCBitset* bitset;
@end

#define BITSET_SIZE 8

@implementation MCBitsetTests

- (void)setUp
{
    [super setUp];

    self.bitset = [[MCBitset alloc] initWithSize:BITSET_SIZE];
}

- (void)testSettingArbitraryBit
{
    [self.bitset setBitAtIndex:2];
    XCTAssertTrue([self.bitset bitAtIndex:2], @"Bit 2 is set");
}

- (void)testSettingArbitraryBitToSpecificValue
{
    [self.bitset setBitAtIndex:3 to:YES];
    XCTAssertTrue([self.bitset bitAtIndex:3], @"Bit 3 is set");
    [self.bitset setBitAtIndex:1 to:NO];
    XCTAssertFalse([self.bitset bitAtIndex:1], @"Bit 1 is not set");
}

- (void)testFlippingArbitraryBit
{
    XCTAssertFalse([self.bitset bitAtIndex:0], @"Bit 0 is not set");
    [self.bitset flipBitAtIndex:0];
    XCTAssertTrue([self.bitset bitAtIndex:0], @"Bit 0 is set");
    [self.bitset flipBitAtIndex:0];
    XCTAssertFalse([self.bitset bitAtIndex:0], @"Bit 0 is not set");
}

- (void)testSettingAllBits
{
    [self.bitset setAll];
    for(int i = 0; i < BITSET_SIZE; i++)
    {
        XCTAssertTrue([self.bitset bitAtIndex:i], @"Bit %i is set", i);
    }
}

- (void)testClearAllBits
{
    [self.bitset setAll];
    [self.bitset clear];
    for(int i = 0; i < BITSET_SIZE; i++)
    {
        XCTAssertFalse([self.bitset bitAtIndex:i], @"Bit %i is not set", i);
    }
}

- (void)testClearArbitraryBit
{
    [self.bitset setBitAtIndex:4];
    XCTAssertTrue([self.bitset bitAtIndex:4], @"Bit 4 is set");
    [self.bitset clearBitAtIndex:4];
    XCTAssertFalse([self.bitset bitAtIndex:4], @"Bit 4 is not set");
}

- (void)testSettingBitOutsideOfInitialRange
{
    [self.bitset setBitAtIndex:4242 to:YES];
    XCTAssertTrue([self.bitset bitAtIndex:4242], @"Bit 42 is set after growing bitset");
}

@end
