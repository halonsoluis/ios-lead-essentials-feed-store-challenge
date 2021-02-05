//
//  InMemoryFeedStore.swift
//  FeedStoreChallenge
//
//  Created by Hugo Alonso on 05/02/2021.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import Foundation

public class InMemoryFeedStore: FeedStore {

	private struct CacheData {
		let feed: [LocalFeedImage]
		let timesstamp: Date
	}

	private var cache: CacheData?

	public init() {

	}
	
	public func deleteCachedFeed(completion: @escaping DeletionCompletion) {
		cache = nil
		completion(nil)
	}

	public func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {

		cache = CacheData(feed: feed, timesstamp: timestamp)
		completion(nil)
	}

	public func retrieve(completion: @escaping RetrievalCompletion) {
		guard let cache = cache else {
			return completion(.empty)
		}

		if cache.feed.isEmpty {
			return completion(.empty)
		} else {
			completion(.found(feed: cache.feed, timestamp: cache.timesstamp))
		}
	}
}
