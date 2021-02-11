//
//  InMemoryFeedStore.swift
//  FeedStoreChallenge
//
//  Created by Hugo Alonso on 05/02/2021.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import Foundation

public class InMemoryFeedStore: FeedStore {
	private var cache: CacheData?

	public static let shared = InMemoryFeedStore()

	private let queue = DispatchQueue(
		label: "\(InMemoryFeedStore.self)Queue",
		qos: .userInitiated,
		attributes: .concurrent
	)

	private init() {}

	public func retrieve(completion: @escaping RetrievalCompletion) {
		queue.async { [weak self] in
			guard let cache = self?.cache else {
				return completion(.empty)
			}
			completion(.found(feed: cache.feed, timestamp: cache.timesstamp))
		}
	}
	
	public func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {
		queue.async(flags: .barrier) { [weak self] in
			self?.cache = CacheData(feed: feed, timesstamp: timestamp)
			completion(nil)
		}
	}

	public func deleteCachedFeed(completion: @escaping DeletionCompletion) {
		queue.async(flags: .barrier) { [weak self] in
			self?.cache = nil
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
