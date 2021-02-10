//
//  InMemoryFeedStore.swift
//  FeedStoreChallenge
//
//  Created by Hugo Alonso on 05/02/2021.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import Foundation

public class InMemoryFeedStore: FeedStore {
	private static var cache: CacheData?

	private let queue = DispatchQueue(
		label: "\(InMemoryFeedStore.self)Queue",
		qos: .userInitiated,
		attributes: .concurrent
	)

	public init() {}

	public func retrieve(completion: @escaping RetrievalCompletion) {
		queue.async {
			guard let cache = Self.cache else {
				return completion(.empty)
			}
			completion(.found(feed: cache.feed, timestamp: cache.timesstamp))
		}
	}
	
	public func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {
		queue.async(flags: .barrier) {
			Self.cache = CacheData(feed: feed, timesstamp: timestamp)
			completion(nil)
		}
	}

	public func deleteCachedFeed(completion: @escaping DeletionCompletion) {
		queue.async(flags: .barrier) {
			Self.cache = nil
			completion(nil)
		}
	}
}

extension InMemoryFeedStore {
	private struct CacheData {
		let feed: [LocalFeedImage]
		let timesstamp: Date
	}
}
