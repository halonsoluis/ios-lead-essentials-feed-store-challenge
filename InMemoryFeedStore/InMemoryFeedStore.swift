//
//  InMemoryFeedStore.swift
//  FeedStoreChallenge
//
//  Created by Hugo Alonso on 05/02/2021.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

import Foundation

public class InMemoryFeedStore: FeedStore {

	public init() {

	}
	
	public func deleteCachedFeed(completion: @escaping DeletionCompletion) {

	}

	public func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {

	}

	public func retrieve(completion: @escaping RetrievalCompletion) {
		completion(.empty)
	}
}
