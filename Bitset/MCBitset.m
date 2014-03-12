//
//  MCBitset.m
//  Bitset
//
//  Created by Jeremy Tregunna on 12-07-06.
//  Copyright (c) 2012 Merge Conflict. All rights reserved.
//

#include <limits.h>
#include <string.h>
#import "MCBitset.h"

static const unsigned int WORD_BITS = CHAR_BIT * sizeof(unsigned int);

@interface MCBitset ()
@property (readonly, assign) unsigned int* bitarray;

- (void)growBitsetToFitIndex:(NSUInteger)newIndex;
- (void)growBitsetIfNeededToAccessIndex:(NSUInteger)index;
@end

@implementation MCBitset
{
    unsigned int* bitarray;
    NSUInteger    wordCount;
}

@synthesize bitarray = bitarray;

#pragma mark - Setup / teardown

- (instancetype)initWithSize:(size_t)size
{
    if((self = [super init]))
    {
    	wordCount = size / CHAR_BIT + 1;
        bitarray = calloc(wordCount, sizeof(*bitarray));
    }
    return self;
}

- (void)dealloc
{
    free(bitarray);
#if !__has_feature(objc_arc)
    [super dealloc];
#endif
}

- (void)growBitsetToFitIndex:(NSUInteger)newIndex
{
    NSUInteger count = newIndex / CHAR_BIT + 1;
    // Same size?
    if(count == wordCount)
        return;

    unsigned int* wordsNeeded = calloc(count, sizeof(*wordsNeeded));
    NSUInteger difference = count - wordCount;

    NSAssert(difference > 0, @"newSize / CHAR_BIT + 1 must be bigger than wordCount");

    memset(wordsNeeded, 0, count);
    memcpy(wordsNeeded + difference, bitarray, wordCount);
    free(bitarray);
    bitarray = wordsNeeded;
    wordCount = count;
}

- (void)growBitsetIfNeededToAccessIndex:(NSUInteger)index
{
    NSUInteger wordIndex = index / WORD_BITS;
    if(wordIndex > wordCount)
        [self growBitsetToFitIndex:index];
}

#pragma mark - Comparison

- (BOOL)isEqual:(MCBitset*)other
{
    if(self == other)
        return YES;

    if([self count] != [other count])
        return NO;

    for(NSUInteger i = 0; i < wordCount; i++)
    {
        if(bitarray[i] != other.bitarray[i])
            return NO;
    }

    return YES;
}

#pragma mark - Properties

- (NSUInteger)capacity
{
    return wordCount * WORD_BIT;
}

- (NSUInteger)count
{
    NSUInteger count = 0;
    for(NSUInteger i = 0; i < wordCount; i++)
    	count += __builtin_popcountll(bitarray[i]);
    return [self capacity] - count;
}

#pragma mark - Accessing elements in the bitset

- (BOOL)bitAtIndex:(NSUInteger)index
{
    [self growBitsetIfNeededToAccessIndex:index];
    return ((bitarray[index / WORD_BITS] & (1 << (index % WORD_BITS))) != 0);
}

- (void)setBitAtIndex:(NSUInteger)index
{
    [self growBitsetIfNeededToAccessIndex:index];
    bitarray[index / WORD_BITS] |= (1 << (index % WORD_BITS));
}

- (void)setBitAtIndex:(NSUInteger)index to:(BOOL)value
{
    if(value)
        [self setBitAtIndex:index];
    else
        [self clearBitAtIndex:index];
}

- (void)flipBitAtIndex:(NSUInteger)index
{
    bitarray[index / WORD_BITS] ^= (1 << (index % WORD_BITS));
}

- (void)clear
{
    memset(bitarray, 0, wordCount);
}

- (void)clearBitAtIndex:(NSUInteger)index
{
    [self growBitsetIfNeededToAccessIndex:index];
    bitarray[index / WORD_BITS] &= ~(1 << (index % WORD_BITS));
}

- (void)setAll
{
    memset(bitarray, 0xffffffff, wordCount);
}

@end
