//
// Created by Michael Kuck on 5/27/14.
// Copyright (c) 2014 Michael Kuck. All rights reserved.
//

#import "MKMutableParallelArray.h"

#import "MKLog.h"

static NSString *const JSPreferencesKeyObjects = @"objects";

//============================================================
//== Private Interface
//============================================================
@interface MKMutableParallelArray ()

@property (strong, atomic, readonly) NSMutableArray *objects;

- (void)postUpdateNotification;

@end

//============================================================
//== Implementation
//============================================================
@implementation MKMutableParallelArray

//=== NSObject ===//
#pragma mark - NSObject

/*
 * (Inherited Comment)
 */
- (instancetype)init
{
    self = [super init];
    if (self) {
        _objects = [[NSMutableArray alloc] init];
    }
    return self;
}

/*
 * (Inherited Comment)
 */
- (NSString *)description
{
    return [self.objects description];
}

//=== NSCoding ===//
#pragma mark - NSCoding

/*
 * (Inherited Comment)
 */
- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.objects forKey:JSPreferencesKeyObjects];
}

/*
 * (Inherited Comment)
 */
- (id)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        _objects = [coder decodeObjectForKey:JSPreferencesKeyObjects];
    }
    return self;
}

//=== Public Implementation ===//
#pragma mark - Public Implementation

/**
* // DOCU: this method comment needs be updated.
*/
- (void)addObject:(id)object
{
    @synchronized(self) {
        [self.objects addObject:object];
    }
    [self postUpdateNotification];
}

/**
* // DOCU: this method comment needs be updated.
*/
- (void)insertObject:(id)object atIndex:(NSUInteger)index
{
    @synchronized(self) {
        [self.objects insertObject:object atIndex:index];
    }
    [self postUpdateNotification];
}

/**
* // DOCU: this method comment needs be updated.
*/
- (id)objectAtIndex:(NSUInteger)index
{
    @synchronized(self) {
        return self.objects[index];
    }
}

/**
* // DOCU: this method comment needs be updated.
*/
- (void)removeObjectAtIndex:(NSUInteger)index
{
    @synchronized(self) {
        [self.objects removeObjectAtIndex:index];
    }
    [self postUpdateNotification];
}

/**
* // DOCU: this method comment needs be updated.
*/
- (void)removeObject:(id)object
{
    @synchronized(self) {
        [self.objects removeObjectAtIndex:[self.objects indexOfObject:object]];
    }
    [self postUpdateNotification];
}

/**
* // DOCU: this method comment needs be updated.
*/
- (NSUInteger)indexOfObject:(id)object
{
    @synchronized(self) {
        return [self.objects indexOfObject:object];
    }
}

/**
* // DOCU: this method comment needs be updated.
*/
- (BOOL)contains:(id)object
{
    @synchronized(self) {
        return [self.objects containsObject:object];
    }
}

/**
* // DOCU: this method comment needs be updated.
*/
- (NSArray *)asArray
{
    @synchronized(self) {
        return [NSArray arrayWithArray:self.objects];
    }
}

/**
* // DOCU: this method comment needs be updated.
*/
- (NSUInteger)count
{
    @synchronized(self) {
        return [self.objects count];
    }
}

//=== Private Implementation ===//
#pragma mark - Private Implementation

/**
* // DOCU: this method comment needs be updated.
*/
- (void)postUpdateNotification
{
    MKLogDebug(@"Did change, sending out notification...");
    [[NSNotificationCenter defaultCenter] postNotificationName:MKMutableParallelArrayDidChangeNotification object:self];
}

@end
