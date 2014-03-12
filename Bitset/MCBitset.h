//
//  MCBitset.h
//  Bitset
//
//  Created by Jeremy Tregunna on 12-07-06.
//  Copyright (c) 2012 Merge Conflict. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCBitset : NSObject

/** Create a new, empty bitset of a specific size.
 
 @param size Size of the bitset in 32-bit words.
 
 @return Instance of bitset.
 */
- (instancetype)initWithSize:(size_t)size;

/** Test if a bit is set at a specific index.
 
 @param index Index in the bitset to test
 
 @return Boolean indicating whether the bit at the specific index is set or not.
 */
- (BOOL)bitAtIndex:(NSUInteger)index;

/** Sets the bit at a specific index to 1.
 
 @param index The index to set.
 */
- (void)setBitAtIndex:(NSUInteger)index;

/** Sets the bit at a specific index to the supplied value.
 
 @param index The index to set.
 @param value Boolean indicating which value to set
 */
- (void)setBitAtIndex:(NSUInteger)index to:(BOOL)value;

/** Flips the bit at a specific index.
 
 @param index The index to flip.
 */
- (void)flipBitAtIndex:(NSUInteger)index;

/** Resets all the bits in the bitset to 0. */
- (void)clear;

/** Resets bit at a specific index to 0.
 
 @param index The index to clear.
 */
- (void)clearBitAtIndex:(NSUInteger)index;

/** Set all bits in the bitset to 1.
 
 I suspect this method to be of lesser importance than any of the others. Provided in case it may be useful.
 */
- (void)setAll;

@end
